/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.op;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.modules.bus.entity.wp.WechatRefundRecord;
import com.chinazhoufan.admin.modules.bus.service.wp.WechatRefundRecordService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayRecord;
import com.chinazhoufan.admin.modules.bus.service.wp.WechatPayRecordService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.mobile.wechat.service.pay.WechatPayService;
import com.chinazhoufan.mobile.wechat.service.pay.WechatRefundService;
import com.chinazhoufan.mobile.wechat.service.pay.exception.WechatPayException;

/**
 * 订单支付、退款 Service
 * @author 张金俊
 * @version 2017-05-15
 */
@Service
@Transactional(readOnly = true)
public class OrderPayService {
	
	private static final Logger logger = LoggerFactory.getLogger(OrderPayService.class);

	@Autowired
	private MemberService memberService;
	@Autowired
	private WechatPayService wechatPayService;
	@Autowired
	private WechatRefundService wechatRefundService;
	@Autowired
	private WechatPayRecordService wechatPayRecordService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private WechatRefundRecordService wechatRefundRecordService;

	/**
	 * 体验订单退款
	 * @param experienceOrder	体验单
	 * @param refundFee		退款金额
	 */
	@Transactional(readOnly = false)
	public void experienceOrderRefund(ExperienceOrder experienceOrder, BigDecimal refundFee) throws WechatPayException{
		logger.info("------体验单退款experienceOrderRefund------");
		logger.debug("refund experienceOrder info:[experienceOrder.id="+experienceOrder.getId()+",refundFee="+refundFee+"]");
		
		// 退款会员
		Member member = memberService.get(experienceOrder.getMember().getId());
		// 退款对应的微信支付记录
		WechatPayRecord wprParam = new WechatPayRecord();
		wprParam.setOutTradeNo(experienceOrder.getOrderNo());
		List<WechatPayRecord> wprList = wechatPayRecordService.findList(wprParam);
		
		// 处理该订单的所有微信支付记录，分别退款
		BigDecimal restRefundFee = refundFee;	// 设置剩余应退金额(初始为体验单需退款总金额，每次微信支付记录退款后扣除对应退款金额，直至退款总金额退完)
		for(WechatPayRecord wechatPayRecord : wprList){
			BigDecimal currentRefundFee = new BigDecimal("0");	// 当前微信支付记录要退款的金额
			BigDecimal recordFee = new BigDecimal(wechatPayRecord.getCashFee()).divide(new BigDecimal("100"));		// 当前微信支付记录的原始支付金额
			// 剩余应退金额 大于 当前微信支付记录的总金额（即：当前微信支付记录不够退）
			if(restRefundFee.compareTo(recordFee) > 1){
				currentRefundFee = recordFee;
				restRefundFee = restRefundFee.subtract(recordFee);
			}else {
				currentRefundFee = restRefundFee;
				restRefundFee = new BigDecimal("0");
			}
			
			// 更新微信支付记录中的退款编号
			wechatPayRecord.setRefundNo(codeGeneratorService.generateCode(WechatPayRecord.GENERATECODE_REFUNDNO));	// 微信支付记录退款编号
			wechatPayRecord.setRefundAutoStatus(WechatPayRecord.STATUS_AUTO_REFUNDING);								// 微信支付记录自动退款状态：退款中
			try {
				// 执行微信退款
				wechatRefundService.wxRefund(wechatPayRecord, currentRefundFee, member.getWechatOpenid());
				// 查询退款
				wechatRefundService.refundQuery(wechatPayRecord);
				
				/*wechatPayRecord.setRefundAutoStatus(WechatPayRecord.STATUS_AUTO_SUCCESS);
				wechatPayRecord.setRefundAutoMoney(currentRefundFee);
				wechatPayRecord.setRefundAutoTime(new Date());*/
				//生成微信退款记录
				WechatRefundRecord wechatRefundRecord = new WechatRefundRecord();
				wechatRefundRecord.setRefundAutoStatus(WechatPayRecord.STATUS_AUTO_SUCCESS);
				wechatRefundRecord.setRefundAutoMoney(currentRefundFee);
				wechatRefundRecord.setRefundAutoTime(new Date());
				wechatRefundRecord.setRefundNo(wechatPayRecord.getRefundNo());
				wechatRefundRecord.setWxPayId(wechatPayRecord.getId());
				wechatRefundRecordService.save(wechatRefundRecord);

			} catch (Exception e) {
				logger.debug("experienceOrder refund exception:执行微信退款失败，转为人工退款");
				e.printStackTrace();
				logger.info(e.getMessage());
				wechatPayRecord.setRefundAutoStatus(WechatPayRecord.STATUS_AUTO_FALSE);
				wechatPayRecord.setRefundAutoMoney(BigDecimal.ZERO);
				wechatPayRecord.setRefundAutoTime(new Date());
				wechatPayRecord.setRefundArtificialStatus(WechatPayRecord.STATUS_ARTI_TOREFUND);					// 微信支付记录人工退款状态：待退款

				//生成微信退款记录
				WechatRefundRecord wechatRefundRecord = new WechatRefundRecord();
				wechatRefundRecord.setRefundAutoStatus(WechatPayRecord.STATUS_AUTO_FALSE);
				wechatRefundRecord.setRefundArtificialStatus(WechatPayRecord.STATUS_ARTI_TOREFUND);
				wechatRefundRecord.setRefundAutoMoney(BigDecimal.ZERO);
				wechatRefundRecord.setRefundAutoTime(new Date());
				wechatRefundRecord.setRefundNo(wechatPayRecord.getRefundNo());
				wechatRefundRecord.setWxPayId(wechatPayRecord.getId());
				wechatRefundRecordService.save(wechatRefundRecord);

			}
			wechatPayRecordService.save(wechatPayRecord);
			
			// 判断是否还有剩余应退金额，如没有，跳出循环结束支付
			if(restRefundFee.compareTo(new BigDecimal("0")) < 1){
				break;
			}
		}
	}
	
}

