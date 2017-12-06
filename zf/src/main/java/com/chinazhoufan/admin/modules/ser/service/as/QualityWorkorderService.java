package com.chinazhoufan.admin.modules.ser.service.as;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.dao.bs.BreakdownStandardDao;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceProduceDao;
import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrderDueTemp;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.service.bs.BreakdownStandardService;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProduceService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;

import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkorder;
import com.chinazhoufan.admin.modules.ser.dao.as.QualityWorkorderDao;

/**
 * 质检工单列表Service
 * @author 舒剑雄
 * @version 2017-10-13
 */
@Service
@Transactional(readOnly = true)
public class QualityWorkorderService extends CrudService<QualityWorkorderDao, QualityWorkorder> {

	@Autowired
	private QualityWorkordProductService qualityWorkordProductService;

	@Autowired
	private ReturnOrderService returnOrderService;

	@Autowired
	private ReturnProduceService returnProduceService;

	@Autowired
	private ExperienceProduceDao experienceProduceDao;

	@Autowired
	private SendOrderService sendOrderService;

	@Autowired
	private BuyOrderService buyOrderService;

	@Autowired
	private BreakdownStandardService breakdownStandardService;

	@Autowired
	private BreakdownStandardDao breakdownStandardDao;

	@Autowired
	private ReturnProductService returnProductService;

	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private MemberNotifyService memberNotifyService;

	@Autowired
	private ServiceApplyService serviceApplyService;


	public QualityWorkorder get(String id) {
		return super.get(id);
	}

	public List<QualityWorkorder> findList(QualityWorkorder qualityWorkorder) {
		return super.findList(qualityWorkorder);
	}

	public Page<QualityWorkorder> findPage(Page<QualityWorkorder> page, QualityWorkorder qualityWorkorder) {
		return super.findPage(page, qualityWorkorder);
	}

	@Transactional(readOnly = false,propagation = Propagation.NOT_SUPPORTED)
	public void updateOrder(QualityWorkorder qualityWorkorder) {

		//校验工单状态
		if(!QualityWorkorder.WORKORDER_STATUS_DEAL.equals(qualityWorkorder.getStatus())){
			throw new ServiceException("失败：工单状态不是未处理状态！");
		}
		List<QualityWorkordProduct> qualityWorkordProductList = qualityWorkorder.getQualityWorkordProductList();
		if(qualityWorkordProductList.size() == 0){
			throw new ServiceException("工单没有关联货品，请核查！");
		}
		for(QualityWorkordProduct qualityWorkordProduct:qualityWorkordProductList){
			if(QualityWorkordProduct.Dt_3.equals(qualityWorkordProduct.getDamageType()) && 0==qualityWorkordProduct.getProduceNormal()){
				throw new ServiceException("工单关联货品损坏换新时，没有多余的产品库存，请核查！");
			}
		}
		qualityWorkordProductService.batchSave(qualityWorkordProductList);//更新工单对应的货品

		//如果损坏金额客服没有做修改则直接自动结算
		Boolean settFlag = true;
		for(QualityWorkordProduct qualityWorkordProduct : qualityWorkordProductList){
			BreakdownStandard breakdownStandard=breakdownStandardDao.getByType(qualityWorkordProduct.getDamageType());
			if(breakdownStandard != null && breakdownStandard.getMoneyLossPercent().multiply(qualityWorkordProduct.getPriceSrc()).compareTo(qualityWorkordProduct.getDecMoney()) == 0){
			}else{
				settFlag = false;
			}
		}
		if(settFlag){
			//更新体验产品的质检金额，覆盖原先质检的信息
			Boolean isSave = updateExperienceDec(qualityWorkorder);
			if(!isSave){
				throw new ServiceException("失败：更新体验产品质检金额信息错误！");
			}
			//结算
			settleWorkOrder(qualityWorkorder);
			qualityWorkorder.setStatus(QualityWorkorder.WORKORDER_STATUS_FINISH);

			//更新退货单状态
			ReturnOrder returnOrder = new ReturnOrder();
			returnOrder.setOrderId(qualityWorkorder.getOrderId());
			returnOrder.setStatus(ReturnOrder.STATUS_FINISH);
			returnOrderService.updateStatusByorder(returnOrder);
		}else{
			qualityWorkorder.setStatus(QualityWorkorder.WORKORDER_STATUS_APPROVE);
		}
		super.save(qualityWorkorder);
	}
	@Transactional(readOnly = false)
	public void save(QualityWorkorder qualityWorkorder) {
		super.save(qualityWorkorder);
	}
	@Transactional(readOnly = false)
	public void delete(QualityWorkorder qualityWorkorder) {
		super.delete(qualityWorkorder);
	}

	@Transactional(readOnly = false,propagation = Propagation.NOT_SUPPORTED)
	public void approve(QualityWorkorder qualityWorkorder) {
		//校验工单状态
		if(!QualityWorkorder.WORKORDER_STATUS_APPROVE.equals(qualityWorkorder.getStatus())){
			throw new ServiceException("失败：工单状态不是待审核状态！");
		}
		//根据工单获取明细
		QualityWorkordProduct qualityWorkordProduct = new QualityWorkordProduct();
		qualityWorkordProduct.setWorkOrderId(qualityWorkorder.getId());
		qualityWorkorder.setQualityWorkordProductList(qualityWorkordProductService.findListByQualityWorkorderId(qualityWorkordProduct));
		//更新体验产品的质检金额，覆盖原先质检的信息
		Boolean isSave = updateExperienceDec(qualityWorkorder);
		if(!isSave){
			throw new ServiceException("失败：更新体验产品质检金额信息错误！");
		}
		//结算
		settleWorkOrder(qualityWorkorder);
		qualityWorkorder.setStatus(QualityWorkorder.WORKORDER_STATUS_FINISH);

		//更新退货单状态
		ReturnOrder returnOrder = new ReturnOrder();
		returnOrder.setOrderId(qualityWorkorder.getOrderId());
		returnOrder.setStatus(ReturnOrder.STATUS_FINISH);
		returnOrderService.updateStatusByorder(returnOrder);
		super.save(qualityWorkorder);
	}

	public QualityWorkorder getDetail(QualityWorkorder qualityWorkorder) {
		return  dao.getDetail(qualityWorkorder);
	}
	/**
	 * 工单审核结算
	 * @param
	 * @throws IOException
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public void settleWorkOrder(QualityWorkorder qualityWorkorder){
		String isLightBroken= null;//是否存在轻度损坏的货品
		List<String> brokenList = new ArrayList<>();
		//自动结算退款金额
		QualityWorkorder workorder = get(qualityWorkorder.getId());
		//判断是否存在影响二次销售的损坏商品，如有，则该货品转自动购买
		List<QualityWorkordProduct> qualityWorkordProductList =qualityWorkorder.getQualityWorkordProductList();
		if(qualityWorkordProductList.size() == 0){
			throw new ServiceException("工单没有关联货品，请核查！");
		}
		//把存在影响二次销售的产品存入map中
		Map<String,Integer> breakMap = new HashMap<>();
		Map<String,Integer> changeMap = new HashMap<>();//换新map
		for(QualityWorkordProduct qualityWorkordProduct: qualityWorkordProductList ){
			brokenList.add(qualityWorkordProduct.getDamageType());
			if(QualityWorkordProduct.Dt_3.equals(qualityWorkordProduct.getDamageType()) || QualityWorkordProduct.Dt_5.equals(qualityWorkordProduct.getDamageType())){
				//获取应转购买的产品id
				if(breakMap.get(qualityWorkordProduct.getProduct().getProduce().getId()) == null){
					breakMap.put(qualityWorkordProduct.getProduct().getProduce().getId(),1);
				}else{
					breakMap.put(qualityWorkordProduct.getProduct().getProduce().getId(),breakMap.get(qualityWorkordProduct.getProduct().getProduce().getId())+1);

				}
				if(changeMap.get(qualityWorkordProduct.getProduct().getProduce().getId()) == null){
					if(QualityWorkordProduct.Dt_3.equals(qualityWorkordProduct.getDamageType())){//货品遗失，不计算购买数量
						changeMap.put(qualityWorkordProduct.getProduct().getProduce().getId(),1);
					}
				}else{
					if(QualityWorkordProduct.Dt_3.equals(qualityWorkordProduct.getDamageType())){//货品遗失，不计算购买数量
						changeMap.put(qualityWorkordProduct.getProduct().getProduce().getId(),breakMap.get(qualityWorkordProduct.getProduct().getProduce().getId())+1);
					}
				}

			}
		}
		//自动转购买
		BigDecimal money= null;
		BigDecimal overdueMoney= BigDecimal.ZERO;
		BigDecimal settlementDecMoney= BigDecimal.ZERO;
		Integer settlementDecBeansNum= 0;
		BigDecimal srcReturnMoney= BigDecimal.ZERO;
		BigDecimal settlementDecableBeansMoney= BigDecimal.ZERO;
		BigDecimal settlementDecBeansMoney= BigDecimal.ZERO;
		Member member = null;
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
		try {
			if(breakMap.size() > 0){
				//先更新体验产品的转自动购买的数量
				for (Map.Entry<String, Integer> entry : breakMap.entrySet()) {
					Integer buyNum = entry.getValue();
					//当回货货品为遗失时，判断货品是否报备过且报备类型为商品错发或者漏发，如是则不算购买，购买数量减
					Map<String,Integer> loseProMap = serviceApplyService.findLoseByOrder(workorder.getOrderId());
					if(loseProMap.size() > 0){
						for(Map.Entry<String, Integer> loseMap : loseProMap.entrySet()){
							if(breakMap.get(loseMap.getKey()) !=null){
								//报备且是错发或漏发
								logger.info("---------------工单结算时用户报备的产品及数量："+loseMap.getKey()+"数量"+loseMap.getValue());
								buyNum=buyNum-loseMap.getValue();
							}
						}
					}
					if(buyNum >0){
						Map<String,Object> param = new HashMap<>();
						param.put("produceId",entry.getKey());
						param.put("buyNum",buyNum);
						param.put("orderId",workorder.getOrderId());
						param.put("decisionType", ExperienceProduce.DECISIONTYPE_BUY);
						experienceProduceDao.updateBuyNumByExperienceOrderAndProduce(param);
					}else{
						//直接走质检，不转购买
						ExperienceOrder experienceOrder = new ExperienceOrder();
						experienceOrder.setId(workorder.getOrderId());
						//没有影响二次销售的产品则自动结算，不转购买
						experienceOrderService.settleExperienceOrderAuto(experienceOrder);
						break;
					}

				}
				if(changeMap.size() > 0){
					for (Map.Entry<String, Integer> entry : changeMap.entrySet()) {
						//先更新体验产品的换新的数量
						Map<String, Object> param = new HashMap<>();
						param.put("produceId", entry.getKey());
						param.put("changeNewNum", entry.getValue());
						param.put("orderId", workorder.getOrderId());
						experienceProduceDao.updateChangeNumByExperienceOrderAndProduce(param);
					}
				}
				ExperienceOrder experienceOrder = experienceOrderService.getDetail(workorder.getOrderId());
				member = experienceOrder.getMember();
				if(experienceOrder.getEpList() != null && experienceOrder.getEpList().size() > breakMap.size()){
					experienceOrder.setAllBuyFalg("false");
				}
				experienceOrder.setIsQuality("true");//用于回货发货
				experienceOrder.setIsLightBroken(isLightBroken);
				BuyOrder buyOrder = buyOrderService.createByExperienceOrder(experienceOrder);
				//用户体验的产品全部遗失,即changeMap==0，则赔偿时不生成发货单
				if(changeMap.size() > 0){
					//生成发货单
					sendOrderService.createByExperienceOrder(experienceOrder);
				}
			}else{
				ExperienceOrder experienceOrder = new ExperienceOrder();
				experienceOrder.setId(workorder.getOrderId());
				experienceOrder.setIsLightBroken(isLightBroken);
				//没有影响二次销售的产品则自动结算，不转购买
				experienceOrderService.settleExperienceOrderAuto(experienceOrder);
			}
		}catch (IOException e) {
			e.printStackTrace();
		}catch (ServiceException se){
			String msg = se.getMessage();
			if(msg.startsWith("{")) {
				JSONObject jsonObject = JSONObject.fromObject(msg);
				ExperienceOrderDueTemp temp = (ExperienceOrderDueTemp) JSONObject.toBean(jsonObject, ExperienceOrderDueTemp.class);
				if (temp != null && temp.getArrearageAmount() != null) {
					money = temp.getArrearageAmount();
					overdueMoney = temp.getMoneySettOverdue() == null ? BigDecimal.ZERO : temp.getMoneySettOverdue();
					settlementDecMoney = temp.getMoneySettDec() == null ? BigDecimal.ZERO : temp.getMoneySettDec();
					srcReturnMoney = temp.getMoneySettSrcReturn() == null ? BigDecimal.ZERO : temp.getMoneySettSrcReturn();                    // 结算原始应退金额
					settlementDecableBeansMoney = temp.getMoneySettDecableBeans() == null ? BigDecimal.ZERO : temp.getMoneySettDecableBeans();    // 结算魅力豆可抵金额
					settlementDecBeansMoney = temp.getMoneySettDecBeans() == null ? BigDecimal.ZERO : temp.getMoneySettDecBeans();            // 结算魅力豆抵扣金额
					settlementDecBeansNum = temp.getNumSettDecBeans() == null ? 0 : temp.getNumSettDecBeans();                // 结算魅力豆抵扣数量
				}
				try {
					String messageCode = null;
					String damageType = temp.getDamageType();
					if (StringUtils.isNotBlank(damageType)){
						switch (damageType){
							case QualityWorkordProduct.Dt_3:
								messageCode = Notify.MSG_ORDER_DUE_FOR_NEW;
								break;
							case QualityWorkordProduct.Dt_2:
								messageCode = Notify.MSG_ORDER_DUE;
								break;
							case QualityWorkordProduct.Dt_1:
								messageCode = Notify.MSG_ORDER_SLIGHT_DAMAGE;
								break;
							case QualityWorkordProduct.Dt_5:
								messageCode = Notify.MSG_LOST_PART_DEBT;
								break;
							default:
								break;
						}
					}
					Member me =new Member();
					me.setId(temp.getMemberId());
					if(Notify.MSG_ORDER_SLIGHT_DAMAGE.equals(messageCode)){
						memberNotifyService.createByNotifyCode(messageCode, me, temp.getOrderNo(), temp.getMoneySettDecableBeans());
					}else {
						memberNotifyService.createByNotifyCode(messageCode, me, temp.getOrderNo());
					}
				} catch (Exception e) {
					throw new ServiceException(e.getMessage());
				}
			}else{
				throw new ServiceException(se.getMessage());
			}
		}
		if(money != null){
			ExperienceOrder eo = new ExperienceOrder();
			eo.setArrearageAmount(money);
			eo.setStatusSystem(ExperienceOrder.STATUSSYSTEM_DUE);
			eo.setStatusMember(ExperienceOrder.STATUSMEMBER_DUE);
			eo.setId(qualityWorkorder.getOrderId());
			eo.setMoneySettOverdue(overdueMoney);
			eo.setMoneySettDec(settlementDecMoney);
			eo.setMoneySettSrcReturn(srcReturnMoney);					// 结算原始应退金额
			eo.setMoneySettDecableBeans(settlementDecableBeansMoney);	// 结算魅力豆可抵金额
			eo.setMoneySettDecBeans(settlementDecBeansMoney);			// 结算魅力豆抵扣金额
			eo.setNumSettDecBeans(settlementDecBeansNum);				// 结算魅力豆抵扣数量
			eo.setSettlementTime(new Date());
			experienceOrderService.updateDueStatus(eo);
		}
	}

	@Transactional(readOnly = false)
	public void refuse(QualityWorkorder qualityWorkorder) {
		//校验工单状态
		if(!QualityWorkorder.WORKORDER_STATUS_APPROVE.equals(qualityWorkorder.getStatus())){
			throw new ServiceException("失败：工单状态不是待审核状态！");
		}
		//更新工单状态
		qualityWorkorder.setStatus(QualityWorkorder.WORKORDER_STATUS_DEAL);
		super.save(qualityWorkorder);
	}

	/**
	 * 根据质检工单ID更新体验单的质检金额信息
	 * @param qualityWorkorder
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean updateExperienceDec(QualityWorkorder qualityWorkorder) {
		QualityWorkordProduct qualityWorkordProduct = new QualityWorkordProduct();
		qualityWorkordProduct.setWorkOrderId(qualityWorkorder.getId());
		List<QualityWorkordProduct> list = qualityWorkordProductService.findListByQualityWorkorderId(qualityWorkordProduct);
		if(list.size() == 0){
			throw new ServiceException("质检单没有关联货品，请核查！");
		}
		//根据订单号获取体验单
		ExperienceOrder ep = experienceOrderService.get(qualityWorkorder.getOrderId());
		Boolean isAllFree = false;
		if(ep.getMoneyProduce().compareTo(BigDecimal.ZERO) == 0){//判断是否全免押金，如果全免押金则不扣质检金额
			isAllFree = true;
		}
		//更新用户体验产品的质检扣减金额
		String produceId =null;
		Map<String,Map<String,BigDecimal>> proMap = new HashMap<>();//产品Id：所属该产品的货品质检金额之和
		Map<String,BigDecimal> decableMap=null;
		for(QualityWorkordProduct qualityProduct : list){
			if(QualityWorkordProduct.RT_MEMBER.equals(qualityProduct.getResponsibilityType())){//责任人划分，如果责任不是会员不做体验单质检扣除金额
				//过滤影响二次销售损坏商品
				/*if(ReturnProduct.Dt_3.equals(returnProduct.getDamageType())){
					//不算质检金额和抵扣魅力豆
				}else{*/
				if(isAllFree && QualityWorkordProduct.Dt_1.equals(qualityProduct.getDamageType())){
					qualityProduct.setDecMoney(BigDecimal.ZERO);
				}
				if(ReturnProduct.Dt_5.equals(qualityProduct.getDamageType())){//货品遗失，扣减金额为零（因为增加了商品漏发或者的报备，不扣用户钱）
					qualityProduct.setDecMoney(BigDecimal.ZERO);
				}
				String returnProduceId =qualityProduct.getReturnProduceId();
				ReturnProduce returnProduce =returnProduceService.get(returnProduceId);
				if(returnProduce != null){
					//存在退货货品有来自不同的退货产品，做归类处理
					produceId =returnProduce.getProduce().getId();
					if(proMap.get(produceId) == null){
						decableMap = new HashMap<>();
						decableMap.put("decMoney",qualityProduct.getDecMoney());
						if(breakdownStandardService.getByType(qualityProduct.getDamageType())){
							decableMap.put("decableBeans",qualityProduct.getDecMoney());
						}
						proMap.put(produceId,decableMap);
					}else{
						BigDecimal afterMoney = proMap.get(produceId).get("decMoney").add(qualityProduct.getDecMoney());
						decableMap.put("decMoney",afterMoney);
						if(breakdownStandardService.getByType(qualityProduct.getDamageType())){
							BigDecimal afterBeansMoney = (proMap.get(produceId).get("decableBeans")==null?BigDecimal.ZERO:proMap.get(produceId).get("decableBeans")).add(qualityProduct.getDecMoney());
							decableMap.put("decableBeans",afterBeansMoney);
						}
					}
				}else{
					return false;
				}
				//}

			}else{
				String returnProduceId =qualityProduct.getReturnProduceId();
				ReturnProduce returnProduce =returnProduceService.get(returnProduceId);
				if(returnProduce != null){
					if(proMap.get(returnProduce.getProduce().getId()) == null){
						decableMap = new HashMap<>();
						decableMap.put("decMoney",BigDecimal.ZERO);
						//decableMap.put("decableBeans",BigDecimal.ZERO);
						proMap.put(returnProduce.getProduce().getId(),decableMap);
					}else{
						BigDecimal afterMoney = proMap.get(returnProduce.getProduce().getId()).get("decMoney").add(BigDecimal.ZERO);
						//BigDecimal afterBeansMoney = proMap.get(returnProduce.getProduce().getId()).get("decableBeans").add(BigDecimal.ZERO);
						decableMap.put("decMoney",afterMoney);
						//decableMap.put("decableBeans",afterBeansMoney);
					}
				}
			}

		}
		//根据来源订单Id和对应产品Id，更新体验产品质检扣减金额
		String orderId = qualityWorkorder.getOrderId();
		Map<String,Object> praMap = new HashMap<>();
		if(orderId != null){
			for (Map.Entry<String, Map<String,BigDecimal>> entry : proMap.entrySet()) {
				praMap.put("produceId",entry.getKey());
				praMap.put("orderId",orderId);
				praMap.put("status", ExperienceProduce.STATUS_TOSETTLEMENT);
				praMap.put("moneyCheckDec",entry.getValue().get("decMoney"));
				if(entry.getValue().get("decableBeans") == null){
					praMap.put("decableBeans",BigDecimal.ZERO);
				}else{
					praMap.put("decableBeans",entry.getValue().get("decableBeans"));
				}
				experienceProduceDao.updateByExperienceOrderAndProduce(praMap);
			}
		}

		return true;
	}

}