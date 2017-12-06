/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.oe;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrderDueTemp;

import com.google.common.collect.Maps;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceOrderTaskDao;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;

/**
 * 体验单操作Service
 * @author 张金俊
 * @version 2017-08-22
 */
@Service
@Transactional(readOnly = true)
public class ExperienceOrderTaskService extends CrudService<ExperienceOrderTaskDao, ExperienceOrder> {
	
	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private ExperienceProduceService experienceProduceService;
	@Autowired
	private MemberNotifyService memberNotifyService;
	
	/**
	 * 查询所有已送达的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findArrived(ExperienceOrder experienceOrder){
		return dao.findArrived(experienceOrder);
	}
	
	/**
	 * 对所有已送达的体验订单进行确认收货，同时设置体验开始日期为当前日期
	 * @param experienceOrder
	 */
	@Transactional(readOnly = false)
	public void updateArrivedToExperiencing(ExperienceOrder experienceOrder) {
		dao.updateArrivedToExperiencing(experienceOrder);
	}
	
	/**
	 * 查询所有超过最长体验期的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findExpired(ExperienceOrder experienceOrder){
		return dao.findExpired(experienceOrder);
	}
	
	/**
	 * 超过最长体验期的体验订单自动转购买
	 * 1.更新体验单、体验产品（设置体验产品为“待结算”）
	 * 2.新增购买单、购买产品
	 * 3.调用自动结算功能，结算订单，余额退款
	 * @param eo	体验单ID
	 * @return
	 */
	@Transactional(readOnly = false, propagation = Propagation.NOT_SUPPORTED)
	public BuyOrder updateExpiredToBuyAuto(ExperienceOrder eo)throws ServiceException {
		logger.info("体验超期订单自动转购买");
		BuyOrder buyOrder = new BuyOrder();
		BigDecimal money= null;
		BigDecimal buyOrderMoney = null;
		try {
			buyOrder = buyOrderService.createByExperienceOrder(eo);
		}catch (IOException e) {
			e.printStackTrace();
		}catch (ServiceException se) {
			String msg = se.getMessage();
			if (msg.startsWith("{")) {
				JSONObject jsonObject = JSONObject.fromObject(msg);
				ExperienceOrderDueTemp temp = (ExperienceOrderDueTemp) JSONObject.toBean(jsonObject, ExperienceOrderDueTemp.class);
				if (temp != null && temp.getArrearageAmount() != null) {
					money = temp.getArrearageAmount();
					buyOrderMoney = temp.getBuyOrderMoney();
					buyOrder.setMoneyTotal(buyOrderMoney);
				}
			} else {
				throw new ServiceException(se.getMessage());
			}
		}
		if(money != null){
			eo.setArrearageAmount(money);
			eo.setStatusSystem(ExperienceOrder.STATUSSYSTEM_DUE);
			eo.setStatusMember(ExperienceOrder.STATUSMEMBER_DUE);
			experienceOrderService.updateDueStatus(eo);
			
			//发送欠款消息
			try {
				memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_AUTOBUY_DEBT, eo.getMember(),eo.getOrderNo(),
						ConfigUtils.getConfig(ExperienceOrder.CONFIG_DELAYABLEDAYS).getConfigValue(),buyOrderMoney, money);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return buyOrder;
	}
	
	/**
	 * 查询所有距离体验到期剩余时长为remainDays天的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findByRemainDays(ExperienceOrder experienceOrder){
		return dao.findByRemainDays(experienceOrder);
	}
	
	/**
	 * 查询所有超过体验期时长为pastDays天的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findByPastDays(ExperienceOrder experienceOrder){
		return dao.findByPastDays(experienceOrder);
	}
	
	/**
	 * 查询所有到达预约体验日期、已到货还未支付尾款的预约体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findAppointToClose(ExperienceOrder experienceOrder){
		return dao.findAppointToClose(experienceOrder);
	}
	
	/**
	 * 取消所有到达预约体验日期、已到货还未支付尾款的预约体验订单
	 * @param experienceOrder
	 * @return
	 */
	@Transactional(readOnly = false)
	public void updateAppointToClose(ExperienceOrder experienceOrder){
		dao.updateAppointToClose(experienceOrder);
	}

	/**
	 * 查询欠款一天的订单
	 * @return
	 */
	public List<ExperienceOrder> findOneDayDebt(){
		Map<String , Object> map = Maps.newHashMap();
		map.put("STATUSSYSTEM_DUE", ExperienceOrder.STATUSSYSTEM_DUE);
		return dao.findOneDayDebt(map);
	}

	/**
	 * 查询欠款一天周的订单
	 * @return
	 */
	public List<ExperienceOrder> findOneWeekDebt(){
		Map<String , Object> map = Maps.newHashMap();
		map.put("STATUSSYSTEM_DUE", ExperienceOrder.STATUSSYSTEM_DUE);
		return dao.findOneWeekDebt(map);
	}

	/**
	 * 查询预约订单尾款支付前一天列表
	 * @param experienceOrder
	 * @return
	 */
    public List<ExperienceOrder> findAppointPay(ExperienceOrder experienceOrder) {
		return dao.findAppointPay(experienceOrder);
    }
	/**
	 * 查询订单
	 * @return
	 */
	public List<ExperienceOrder> findListByPastSevenDays() {
		return dao.findListByPastSevenDays();
	}
}

