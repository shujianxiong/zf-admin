/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 *//*

package com.chinazhoufan.admin.common.schedule.service;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkorder;
import com.chinazhoufan.admin.modules.ser.service.as.QualityWorkorderService;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

*/
/**
 * 每天上午7点
 * 对体验时间超过七天，且质检完成的体验订单进行自动结算
 * @author 张金俊
 * @version 2017-08-22
 *//*

@Service
@Transactional(readOnly = false)
public class AutoSettleService extends AbstractTaskListener {

	@Autowired
	private ExperienceOrderTaskService experienceOrderTaskService;

	@Autowired
	private ExperienceOrderService experienceOrderService;

	@Autowired
	private ReturnOrderService returnOrderService;
	@Autowired
	private QualityWorkorderService qualityWorkorderService;
	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private SendOrderService sendOrderService;

	@Autowired
	private MemberNotifyService memberNotifyService;

    public void doTask(TaskEvent event) {
    	System.out.println("doTask AutoSettleService.doTask()");
    	try {
			List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findListByPastSevenDays();
			for(ExperienceOrder experienceOrder :experienceOrderList){
				String settBuy = experienceOrder.getSettBuy();
				//根据订单查询退货单和质检工单
				ReturnOrder returnOrder = returnOrderService.getDetail(experienceOrder.getType(),experienceOrder.getId());
				//检查退货单是否为待结算或者挂起状态
				if(ReturnOrder.STATUS_TOACCOUNT.equals(returnOrder.getStatus()) || ReturnOrder.STATUS_HANG.equals(returnOrder.getStatus())){
					QualityWorkorder qualityWorkorder = qualityWorkorderService.getByOrder(experienceOrder.getType(),experienceOrder.getId());
					if(qualityWorkorder == null || QualityWorkorder.WORKORDER_STATUS_FINISH.equals(qualityWorkorder.getStatus())){
						//当质检工单存在时，只有处理完成的才能结算
						experienceOrder= experienceOrderService.checkExperienceOrderRefune(experienceOrder);
						BigDecimal returnMoney = experienceOrder.getMoneySettReturn();
						if (returnMoney != null && returnMoney.compareTo(BigDecimal.ZERO) == -1) {
							//产生欠款，更新订单欠款金额和退货单状态
							returnOrderService.update(returnOrder);
							ExperienceOrder eo = new ExperienceOrder();
							eo.setArrearageAmount(returnMoney.abs());
							eo.setStatusSystem(ExperienceOrder.STATUSSYSTEM_DUE);
							eo.setStatusMember(ExperienceOrder.STATUSMEMBER_DUE);
							eo.setId(experienceOrder.getId());
							eo.setMoneySettOverdue(experienceOrder.getMoneySettOverdue());
							eo.setMoneySettDec(experienceOrder.getMoneySettDec());
							eo.setMoneySettSrcReturn(experienceOrder.getMoneySettSrcReturn());                    // 结算原始应退金额
							eo.setMoneySettDecableBeans(experienceOrder.getMoneySettDecableBeans());    // 结算魅力豆可抵金额
							eo.setMoneySettDecBeans(BigDecimal.ZERO);            // 结算魅力豆抵扣金额
							eo.setNumSettDecBeans(0);                			// 结算魅力豆抵扣数量
							eo.setSettlementTime(new Date());
							experienceOrderService.updateDueStatus(eo);
							//欠款消息发送
							Member me = experienceOrder.getMember();
							if(qualityWorkorder != null){
								if (QualityWorkordProduct.Dt_1.equals(getBrokenByQua(qualityWorkorder))) {
									memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_SLIGHT_DAMAGE, me, experienceOrder.getOrderNo(), experienceOrder.getMoneySettDecBeans() == null ? "0" : experienceOrder.getMoneySettDecBeans().toString());
								} else {
									if (getBreakMapByQua(qualityWorkorder).size() > 0) {
										memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_BACK, me, experienceOrder.getOrderNo());
									} else {
										memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_BACK_FOR_NEW, me, experienceOrder.getOrderNo());
									}
								}
							}else{
								if (ReturnProduct.Dt_1.equals(getBroken(returnOrder))) {
									memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_SLIGHT_DAMAGE, me, experienceOrder.getOrderNo(), experienceOrder.getMoneySettDecBeans() == null ? "0" : experienceOrder.getMoneySettDecBeans().toString());
								} else {
									if (getBreakMap(returnOrder).size() > 0) {
										memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_BACK, me, experienceOrder.getOrderNo());
									} else {
										memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_BACK_FOR_NEW, me, experienceOrder.getOrderNo());
									}
								}
							}
							continue;
						}
						if(ExperienceOrder.TRUE_FLAG.equals(settBuy)){
							//转购买
							if(qualityWorkorder != null){
								//如果存在质检工单，则根据工单进行结算
								ExperienceOrder settleOrder = experienceOrderService.getDetail(returnOrder.getOrderId());
								if(settleOrder.getEpList() != null && settleOrder.getEpList().size() > getBreakMap(returnOrder).size()){
									settleOrder.setAllBuyFalg("false");
								}
								settleOrder.setIsQuality("true");//用于回货发货
								settleOrder.setIsLightBroken(getBroken(returnOrder));
								BuyOrder buyOrder = buyOrderService.createByExperienceOrder(settleOrder);
								//用户体验的产品全部遗失,即changeMap==0，则赔偿时不生成发货单
								if(getChangeMap(returnOrder).size() > 0){
									//生成发货单
									sendOrderService.createByExperienceOrder(settleOrder);
								}
							}else{
								//如果存在质检工单，则根据工单进行结算
								ExperienceOrder settleOrder = experienceOrderService.getDetail(returnOrder.getOrderId());
								if(settleOrder.getEpList() != null && settleOrder.getEpList().size() > getBreakMapByQua(qualityWorkorder).size()){
									settleOrder.setAllBuyFalg("false");
								}
								settleOrder.setIsQuality("true");//用于回货发货
								settleOrder.setIsLightBroken(getBrokenByQua(qualityWorkorder));
								BuyOrder buyOrder = buyOrderService.createByExperienceOrder(settleOrder);
								//用户体验的产品全部遗失,即changeMap==0，则赔偿时不生成发货单
								if(getChangeMapByQua(qualityWorkorder).size() > 0){
									//生成发货单
									sendOrderService.createByExperienceOrder(settleOrder);
								}
							}
						}else{
							experienceOrderService.settleExperienceOrderAuto(experienceOrder);
						}
					}
				}
			}
		}catch (Exception e){
			e.printStackTrace();
		}
    }

    public Map<String,Integer> getBreakMap(ReturnOrder returnOrder){
		//把存在影响二次销售的产品存入map中
		Map<String,Integer> breakMap = new HashMap<>();
		//判断是否存在影响二次销售的损坏商品，如有，则该货品转自动购买
		List<ReturnProduct> returnProductList = returnOrder.getReturnProductList();
		if (returnProductList.size() == 0) {
			return breakMap;
		}
		for (ReturnProduct returnProduct : returnProductList) {
			if (ReturnProduct.Dt_3.equals(returnProduct.getDamageType()) || ReturnProduct.Dt_5.equals(returnProduct.getDamageType())) {
				//获取应转购买的产品id
				if (breakMap.get(returnProduct.getProduct().getProduce().getId()) == null) {
					breakMap.put(returnProduct.getProduct().getProduce().getId(), 1);
				} else {
					breakMap.put(returnProduct.getProduct().getProduce().getId(), breakMap.get(returnProduct.getProduct().getProduce().getId()) + 1);
				}
			}
		}

    	return breakMap;
	}

	public Map<String,Integer> getChangeMap(ReturnOrder returnOrder){
		//把存在影响二次销售的产品存入map中
		Map<String,Integer> changeMap = new HashMap<>();
		//判断是否存在影响二次销售的损坏商品，如有，则该货品转自动购买
		List<ReturnProduct> returnProductList = returnOrder.getReturnProductList();
		if (returnProductList.size() == 0) {
			return changeMap;
		}
		for (ReturnProduct returnProduct : returnProductList) {
			if (ReturnProduct.Dt_3.equals(returnProduct.getDamageType()) || ReturnProduct.Dt_5.equals(returnProduct.getDamageType())) {
				//获取应转购买的产品id
				if(changeMap.get(returnProduct.getProduct().getProduce().getId()) == null){
					if(QualityWorkordProduct.Dt_3.equals(returnProduct.getDamageType())){//货品遗失，不计算购买数量
						changeMap.put(returnProduct.getProduct().getProduce().getId(),1);
					}
				}else{
					if(QualityWorkordProduct.Dt_3.equals(returnProduct.getDamageType())){//货品遗失，不计算购买数量
						changeMap.put(returnProduct.getProduct().getProduce().getId(),changeMap.get(returnProduct.getProduct().getProduce().getId())+1);
					}
				}
			}
		}

		return changeMap;
	}
	public String getBroken(ReturnOrder returnOrder){
		String isLightBroken= null;//存在损坏的货品
		String isSlightDamage = null;
		List<String> brokenList = new ArrayList<>();
		List<ReturnProduct> returnProductList = returnOrder.getReturnProductList();
		if (returnProductList.size() == 0) {
			return isLightBroken;
		}
		for (ReturnProduct returnProduct : returnProductList) {
			brokenList.add(returnProduct.getDamageType());
			if (ReturnProduct.Dt_3.equals(returnProduct.getDamageType()) || ReturnProduct.Dt_5.equals(returnProduct.getDamageType())) {
				isSlightDamage = BaseEntity.FALSE_FLAG;
			} else if (ReturnProduct.Dt_1.equals(returnProduct.getDamageType())) {
				if (!BaseEntity.FALSE_FLAG.equals(isSlightDamage)) {
					isSlightDamage = BaseEntity.TRUE_FLAG;
				}
			} else {
				isSlightDamage = BaseEntity.FALSE_FLAG;
			}
		}
		//记录货品损坏类型
		if(brokenList.contains(ReturnProduct.Dt_5)){
			isLightBroken= ReturnProduct.Dt_5;
		}else if(brokenList.contains(ReturnProduct.Dt_3)){
			isLightBroken= ReturnProduct.Dt_3;
		}else if(brokenList.contains(ReturnProduct.Dt_2)){
			isLightBroken= ReturnProduct.Dt_2;
		}else if(brokenList.contains(ReturnProduct.Dt_1)){
			isLightBroken= ReturnProduct.Dt_1;
		}
		return isLightBroken;
	}

	public Map<String,Integer> getBreakMapByQua(QualityWorkorder qualityWorkorder){
		//把存在影响二次销售的产品存入map中
		Map<String,Integer> breakMap = new HashMap<>();
		//判断是否存在影响二次销售的损坏商品，如有，则该货品转自动购买
		List<QualityWorkordProduct> qualityWorkordProductList = qualityWorkorder.getQualityWorkordProductList();
		if (qualityWorkordProductList.size() == 0) {
			return breakMap;
		}
		for (QualityWorkordProduct qualityWorkordProduct : qualityWorkordProductList) {
			if (ReturnProduct.Dt_3.equals(qualityWorkordProduct.getDamageType()) || ReturnProduct.Dt_5.equals(qualityWorkordProduct.getDamageType())) {
				//获取应转购买的产品id
				if (breakMap.get(qualityWorkordProduct.getProduct().getProduce().getId()) == null) {
					breakMap.put(qualityWorkordProduct.getProduct().getProduce().getId(), 1);
				} else {
					breakMap.put(qualityWorkordProduct.getProduct().getProduce().getId(), breakMap.get(qualityWorkordProduct.getProduct().getProduce().getId()) + 1);
				}
			}
		}

		return breakMap;
	}

	public Map<String,Integer> getChangeMapByQua(QualityWorkorder qualityWorkorder){
		//把存在影响二次销售的产品存入map中
		Map<String,Integer> changeMap = new HashMap<>();
		//判断是否存在影响二次销售的损坏商品，如有，则该货品转自动购买
		List<QualityWorkordProduct> qualityWorkordProductList = qualityWorkorder.getQualityWorkordProductList();
		if (qualityWorkordProductList.size() == 0) {
			return changeMap;
		}
		for (QualityWorkordProduct qualityWorkordProduct : qualityWorkordProductList) {
			if (ReturnProduct.Dt_3.equals(qualityWorkordProduct.getDamageType()) || ReturnProduct.Dt_5.equals(qualityWorkordProduct.getDamageType())) {
				//获取应转购买的产品id
				if(changeMap.get(qualityWorkordProduct.getProduct().getProduce().getId()) == null){
					if(QualityWorkordProduct.Dt_3.equals(qualityWorkordProduct.getDamageType())){//货品遗失，不计算购买数量
						changeMap.put(qualityWorkordProduct.getProduct().getProduce().getId(),1);
					}
				}else{
					if(QualityWorkordProduct.Dt_3.equals(qualityWorkordProduct.getDamageType())){//货品遗失，不计算购买数量
						changeMap.put(qualityWorkordProduct.getProduct().getProduce().getId(),changeMap.get(qualityWorkordProduct.getProduct().getProduce().getId())+1);
					}
				}
			}
		}

		return changeMap;
	}
	public String getBrokenByQua(QualityWorkorder qualityWorkorder){
		String isLightBroken= null;//存在损坏的货品
		String isSlightDamage = null;
		List<String> brokenList = new ArrayList<>();
		List<QualityWorkordProduct> qualityWorkordProductList = qualityWorkorder.getQualityWorkordProductList();
		if (qualityWorkordProductList.size() == 0) {
			return  isLightBroken;
		}
		for (QualityWorkordProduct qualityWorkordProduct : qualityWorkordProductList) {
			brokenList.add(qualityWorkordProduct.getDamageType());
			if (ReturnProduct.Dt_3.equals(qualityWorkordProduct.getDamageType()) || ReturnProduct.Dt_5.equals(qualityWorkordProduct.getDamageType())) {
				isSlightDamage = BaseEntity.FALSE_FLAG;
			} else if (ReturnProduct.Dt_1.equals(qualityWorkordProduct.getDamageType())) {
				if (!BaseEntity.FALSE_FLAG.equals(isSlightDamage)) {
					isSlightDamage = BaseEntity.TRUE_FLAG;
				}
			} else {
				isSlightDamage = BaseEntity.FALSE_FLAG;
			}
		}
		//记录货品损坏类型
		if(brokenList.contains(QualityWorkordProduct.Dt_5)){
			isLightBroken= QualityWorkordProduct.Dt_5;
		}else if(brokenList.contains(QualityWorkordProduct.Dt_3)){
			isLightBroken= QualityWorkordProduct.Dt_3;
		}else if(brokenList.contains(QualityWorkordProduct.Dt_2)){
			isLightBroken= QualityWorkordProduct.Dt_2;
		}else if(brokenList.contains(QualityWorkordProduct.Dt_1)){
			isLightBroken= QualityWorkordProduct.Dt_1;
		}
		return isLightBroken;
	}
}*/
