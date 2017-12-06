/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ob;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Address;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackItemService;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
//import com.chinazhoufan.admin.modules.bus.entity.jo.OrderJudge;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyProduce;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceProduceService;
//import com.chinazhoufan.admin.modules.bus.service.jo.OrderJudgeService;
import com.chinazhoufan.admin.modules.bus.dao.ob.BuyOrderDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;

/**
 * 购买单Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class BuyOrderService extends CrudService<BuyOrderDao, BuyOrder> {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private ProduceService produceService;
	@Autowired
	private BuyProduceService buyProduceService;	
	@Autowired
	private ExperienceProduceService experienceProduceService;
	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	ExperiencePackItemService experiencePackItemService;
	@Autowired
	private ExperiencePackService experiencePackService;
	
	public BuyOrder get(String id) {
		return super.get(id);
	}
	
	/**
	 * 根据订单ID获取购买订单及购买产品信息
	 * @param id	购买订单ID
	 * @return
	 */
	public BuyOrder getDetail(String id) {
		BuyOrder buyOrder = new BuyOrder(id);
		return dao.getDetail(buyOrder);
	}
	
	public List<BuyOrder> findList(BuyOrder buyOrder) {
		return super.findList(buyOrder);
	}
	
	public Page<BuyOrder> findPage(Page<BuyOrder> page, BuyOrder buyOrder) {
		return super.findPage(page, buyOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(BuyOrder buyOrder) {
		super.save(buyOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(BuyOrder buyOrder) {
		super.delete(buyOrder);
	}
	
	/**
	 * 后台工作人员执行关闭订单的操作
	 * @param buyOrder
	 */
	@Transactional(readOnly = false)
	public void closeBuyOrder(BuyOrder buyOrder) {
		// 只有系统订单状态为“待支付”、且支付状态为“待支付”或“待付定金”的购买单才可以关闭
		if(!BuyOrder.STATUSSYSTEM_TOPAY.equals(buyOrder.getStatusSystem())
				|| 
				(!BuyOrder.STATUSPAY_TOPAY_TOTAL.equals(buyOrder.getStatusPay()) 
						&& !BuyOrder.STATUSPAY_TOPAY_APPOINT.equals(buyOrder.getStatusPay()))) {
			throw new ServiceException("警告：当前购买单的系统订单状态不是“待支付”、或支付状态不是待付全款或待付定金状态，不允许执行关闭操作");
		}
		
		buyOrder.setStatusMember(BuyOrder.STATUSMEMBER_CLOSE);
		buyOrder.setStatusSystem(BuyOrder.STATUSSYSTEM_CLOSE);
		buyOrder.setCloseType(BuyOrder.CLOSETYPE_STAFF);
		buyOrder.setCloseTime(new Date());
		super.save(buyOrder);
	}

	
//	/**
//	 * 订单评价审核
//	 * @param experienceOrder
//	 * @param orderJudgeId
//	 * @param judgeType
//	 */
//	@Transactional(readOnly = false)
//	public void judge(BuyOrder buyOrder, String orderJudgeId, Integer judgeType) {
//		buyOrder.setStatusJudge(BuyOrder.STATUSJUDGE_JUDGED);
//		buyOrder.preUpdate();
//		dao.update(buyOrder);
//		
//		OrderJudge judge = judgeService.get(orderJudgeId);
//		if(judgeType == 0) {
//			judge.setCheckStatus(OrderJudge.CHECKSTATUS_REFUSE);
//		} else if(judgeType == 1) {
//			judge.setCheckStatus(OrderJudge.CHECKSTATUS_PASS);
//		}
//		judge.preUpdate();
//		judgeService.save(judge);
//		
//	}
	
//	/**
//	 * 根据产品ID和订单类型   将预购单中的预约到货状态由     待采购   -> 已到货
//	 * @param buyOrder
//	 */
//	public void updateAppointStockStatusByProduce(BuyOrder buyOrder) {
//		dao.updateAppointStockStatusByProduce(buyOrder);
//	};
	
	
	/**
	 * 统计购买单里面当天的成交量，包括预约购买
	 * @param buyOrder
	 * @return
	 */
	public Integer statBuyOrderDayTradingVolume(BuyOrder buyOrder) {
		return dao.statBuyOrderDayTradingVolume(buyOrder);
	}
	
	
	public List<BuyOrder> listBuyOrderByIds(List<String> ids) {
		return dao.listBuyOrderByIds(ids);
	}

	public BuyOrder getByExperienceOrder(String experienceOrderId) {
		return dao.getByExperienceOrder(experienceOrderId);
	}
	
	@Transactional(readOnly=false)
	public BuyOrder createByExperienceOrder(ExperienceOrder experienceOrder) throws ServiceException, IOException {
		BuyOrder buyOrder = getByExperienceOrder(experienceOrder.getId());
		if (buyOrder == null) {
			buyOrder =  new BuyOrder();
			buyOrder.setType(BuyOrder.TYPE_BUY);
			buyOrder.setBuyType(BuyOrder.BUYTYPE_ING);
			buyOrder.setMember(experienceOrder.getMember());
			buyOrder.setMoneyAppointService(experienceOrder.getMoneyAppointService());
			buyOrder.setExperienceOrder(experienceOrder);
			buyOrder.setOrderNo(codeGeneratorService.generateCode(BuyOrder.GENERATECODE_ORDERNO));
			buyOrder.setStatusSystem(BuyOrder.STATUSMEMBER_TOSETTLEMENT);
			buyOrder.setStatusMember(BuyOrder.STATUSSYSTEM_TOSETTLEMENT);
			buyOrder.setStatusPay(BuyOrder.STATUSPAY_TOPAY_TOTAL);
			buyOrder.setStatusInvoice(BuyOrder.FALSE_FLAG);
			buyOrder.setMoneyLgt(experienceOrder.getMoneyLgt());
			buyOrder.setMoneyAppoint(experienceOrder.getMoneyAppoint());
			buyOrder.setReceiveName(experienceOrder.getReceiveName());
			buyOrder.setReceiveTel(experienceOrder.getReceiveTel());
			buyOrder.setReceiveAreaStr(experienceOrder.getReceiveAreaStr());
			buyOrder.setReceiveAreaDetail(experienceOrder.getReceiveAreaDetail());
			buyOrder.setMoneyTotal(BigDecimal.ZERO);
			buyOrder.setMoneyProduce(BigDecimal.ZERO);
			buyOrder.setMoneyBeansDeduct(BigDecimal.ZERO);
			buyOrder.setNumBeansDeduct(0);
			buyOrder.setMoneyPaid(BigDecimal.ZERO);
			Warehouse wh =new Warehouse();
			wh.setId("1cd60b6ac88e48768684801157ab6d1e");
			buyOrder.setOutWarehouse(wh);
			buyOrder.preInsert();
			dao.insert(buyOrder);
		}
		BuyProduce buyProduce = null;
		Produce produce = null;
		for(ExperienceProduce experienceProduce : experienceOrder.getEpList()) {
			produce = produceService.get(experienceProduce.getProduce().getId());
			//校验是否超过体验包体验次数,不超过算折扣
			BigDecimal scale = BigDecimal.ONE;
			if (experienceOrder.getExperiencePackId() != null) {
                ExperiencePack experiencePack = experiencePackService.get(experienceOrder.getExperiencePackId());
				if (experiencePack != null) {
                    scale = experiencePack.getDiscountScale();
				}
			}
			produce.setExperiencePackScale(scale);
			buyProduce = new BuyProduce();
			buyProduce.setBuyOrder(buyOrder);
			buyProduce.setProduce(produce);
			buyProduce.setGoodsTitle(produce.getGoods().getTitle());
			buyProduce.setNum(experienceProduce.getBuyNum() == null ? experienceProduce.getNum() : experienceProduce.getBuyNum());
			buyProduce.setProduceName(produce.getName());
			buyProduce.setPriceSrc(produce.getPriceSrc());
			buyProduce.setDiscountBuy(produceService.getBuyDiscount(buyProduce.getProduce()));
			buyProduce.setPriceBuy(produceService.getBuyDiscountPrice(buyProduce.getProduce()).setScale(2, BigDecimal.ROUND_HALF_UP));
			buyProduce.setExperienceProduce(experienceProduce);
			buyProduceService.save(buyProduce);
			whProduceService.releaseLockStock(buyOrder.getOutWarehouse().getId(), produce.getId(), buyProduce.getNum());
			experienceProduce.setDecisionBuyOrder(buyOrder);
			experienceProduce.setPriceSrcBuy(buyProduce.getPriceSrc());
			experienceProduce.setDiscountBuy(buyProduce.getDiscountBuy());
			experienceProduce.setPriceBuy(buyProduce.getPriceBuy());
			experienceProduce.setStatus(ExperienceProduce.STATUS_TOSETTLEMENT);
			experienceProduce.setExperienceOrder(experienceOrder);
			if (!"false".equals(experienceOrder.getAllBuyFalg())) {//主要用于质检部分转购买和超期自动转购买
				experienceProduce.setDecisionType(ExperienceProduce.DECISIONTYPE_BUY);
			}
			experienceProduceService.save(buyProduce.getExperienceProduce());
		}
		experienceOrderService.settleExperienceOrderAuto(experienceOrder);
		return buyOrder;
	}
	@Transactional(readOnly = false)
	public Integer getCountByMem(BuyOrder buyOrder){
		return dao.getCountByMem(buyOrder);
	}

	/**
	 * 获取用户交易信息
	 * @param memberId
	 * @return
	 *          buyTimes 购买次数
	 *          buyMoney 购买商品总金额
	 */
    public Map<String, Object> getMemberTradeInfo(String memberId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("STATUSSYSTEM_CLOSE", BuyOrder.STATUSSYSTEM_CLOSE);
		return dao.getMemberTradeInfo(map);
    }

	/**
	 * 获取邀请用户交易信息
	 * @param memberIds
	 * @return
	 *          buyTimes 购买次数
	 *          buyMoney 购买商品总金额
	 */
    public Map<String, Object> getMemberTradeInfo(List<String> memberIds) {
		Map<String, Object> map = Maps.newHashMap();
    	if (memberIds!=null && !memberIds.isEmpty()){
			map.put("memberIds", memberIds);
			map.put("STATUSSYSTEM_CLOSE", BuyOrder.STATUSSYSTEM_CLOSE);
			return dao.getMemberTradeInfo(map);
		}else {
    		map.put("buyTimes", 0);
    		map.put("buyMoney", 0);
    		return map;
		}

	}

}