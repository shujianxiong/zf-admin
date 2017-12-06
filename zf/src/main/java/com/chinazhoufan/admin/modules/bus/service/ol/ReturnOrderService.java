package com.chinazhoufan.admin.modules.bus.service.ol;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.bus.bean.Order;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceProduceDao;
import com.chinazhoufan.admin.modules.bus.dao.ol.ReturnOrderDao;
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
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkorder;
import com.chinazhoufan.admin.modules.ser.entity.as.Workorder;
import com.chinazhoufan.admin.modules.ser.service.as.QualityWorkordProductService;
import com.chinazhoufan.admin.modules.ser.service.as.QualityWorkorderService;
import com.chinazhoufan.admin.modules.ser.service.as.WorkorderService;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.mobile.wechat.service.pay.config.OrderType;
import com.google.common.collect.Lists;

/**
 * 退货单Service
 * @author 张金俊
 * @version 2017-04-19
 */
@Service
@Transactional(readOnly = true)
public class ReturnOrderService extends CrudService<ReturnOrderDao, ReturnOrder> {

	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private ReturnProductService returnProductService;
	@Autowired
	private ReturnProduceService returnProduceService;
	@Autowired
	private ExperienceProduceDao experienceProduceDao;
	@Autowired
	private BreakdownStandardService breakdownStandardService;
	@Autowired
	private QualityWorkorderService qualityWorkorderService;
	@Autowired
	private QualityWorkordProductService qualityWorkordProductService;
	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	CodeGeneratorService codeGeneratorService;

	@Autowired
	private ProductService productService;
	@Autowired
	private WorkorderService workorderService;
	@Autowired
	private ServiceApplyService serviceApplyService;

	@Autowired
	private MemberNotifyService memberNotifyService;

	public ReturnOrder get(String id) {

		return super.get(id);
	}

	/**
	 * 通过订单类型、订单ID查询对应退货单
	 * @param orderType	订单类型
	 * @param orderId	订单ID
	 * @return
	 */
	public ReturnOrder getByOrder(String orderType, String orderId) {
		return dao.getByOrder(orderType, orderId);
	}

	public List<ReturnOrder> findList(ReturnOrder returnOrder) {
		return super.findList(returnOrder);
	}

	public Page<ReturnOrder> findPage(Page<ReturnOrder> page, ReturnOrder returnOrder) {
		return super.findPage(page, returnOrder);
	}

	@Transactional(readOnly = false)
	public void save(ReturnOrder returnOrder) {
		super.save(returnOrder);
	}

	@Transactional(readOnly = false)
	public void delete(ReturnOrder returnOrder) {
		super.delete(returnOrder);
	}


	/**
	 * 根据物流单号获取退货单信息
	 * @param returnOrder
	 * @return
	 */
	public List<ReturnOrder> findReturnOrderByExpressNo(ReturnOrder returnOrder) {
		return dao.findReturnOrderByExpressNo(returnOrder);
	}


	/**
	 * 根据退货单ID获取退货单明细，包括产品对应的货位及库存
	 * @param returnOrder
	 * @return
	 */
	public List<ReturnOrder> findWithProduceAndWareplaceByExpressNo(ReturnOrder returnOrder) {
		return dao.findWithProduceAndWareplaceByExpressNo(returnOrder);
	}


	/**
	 * 根据退货单ID获取退货单,及退货货品明细
	 * @param returnOrder
	 * @return
	 */
	public ReturnOrder findWithProductByExpressNo(ReturnOrder returnOrder) {
		return dao.findWithProductByExpressNo(returnOrder);
	}



	/**
	 * 根据ID变更退货单状态
	 * @param returnOrder
	 */
	@Transactional(readOnly = false)
	public void updateStatusById(ReturnOrder returnOrder) {
		returnOrder.preUpdate();
		dao.updateStatusById(returnOrder);
	}


	/**
	 * 根据回货单运单号，获取关联订单信息并返回，同时更新回货收货人信息
	 * @param expressNo
	 * @return
	 */
	@Transactional(readOnly = false)
	public List<Order> findOrderByExpressNo(String expressNo) {
		ReturnOrder returnOrder = new ReturnOrder();
		returnOrder.setExpressNo(expressNo);
		List<ReturnOrder> returnOrderList = dao.findReturnOrderByExpressNo(returnOrder);

		if(returnOrderList.isEmpty())
			return null;

		//退货单收货
		Date receiveTime = new Date();
		User receiveBy = UserUtils.getUser();

		List<String> buyOrderIdList = Lists.newArrayList();
		List<String> expOrderIdList = Lists.newArrayList();
		for(ReturnOrder ro : returnOrderList) {
			if(ReturnOrder.STATUS_RETURNING.equals(ro.getStatus()) || ReturnOrder.STATUS_REFUSE.equals(ro.getStatus())) {
				if (OrderType.EXPERIENCE.getType().equals(ro.getOrderType())) {
					expOrderIdList.add(ro.getOrderId());
				} else if (OrderType.BUY.getType().equals(ro.getOrderType())) {
					buyOrderIdList.add(ro.getOrderId());
				}

				//物流公司类型转文字说明
				ro.setExpressCompany(ro.getExpressCompany());
			}
		}

		for(ReturnOrder ro : returnOrderList) {
			if(ReturnOrder.STATUS_RETURNING.equals(ro.getStatus()) || ReturnOrder.STATUS_REFUSE.equals(ro.getStatus())){
				ro.setReceiveTime(receiveTime);
				ro.setReceiveBy(receiveBy);
				ro.setStatus(ReturnOrder.STATUS_TOCHECK);
				this.save(ro);
				//更新该退货单下的货品的状态，体验中=》锁定
				List<ReturnProduct> returnProductList = returnProductService.getByReturnOrder(ro.getId());
				for(ReturnProduct returnProduct :returnProductList ){
					Product product = returnProduct.getProduct();
					product.setStatus(Product.STATUS_LOCKED);
					product.setUpdateDate(new Date());
					product.setUpdateBy(UserUtils.getUser());
					productService.updateSingle(returnProduct.getProduct());
				}
			}
		}

		Order order = null;
		ReturnOrder ro = returnOrderList.get(0);
		List<Order> orderList = Lists.newArrayList();

		if(!expOrderIdList.isEmpty()) {
			List<ExperienceOrder> epList = experienceOrderService.findListByIds(expOrderIdList);
			for(ExperienceOrder eo : epList) {
				order = new Order();
				order.expressCompany = DictUtils.getDictLabel(ro.getExpressCompany(), "express_company", "");
				order.expressNo = ro.getExpressNo();
				order.orderNo = eo.getOrderNo();
				order.orderStatus = eo.getStatusMember();
				order.orderType = eo.getType();
				order.receiveTime = receiveTime;
				order.receiveBy = receiveBy;
				order.outOfDays = "0";
				if(eo.getAppointPickDate() != null && eo.getRealExpDate() != null){
					Date realExpDate = eo.getRealExpDate();	// 实际体验日期（体验开始日期）
					String experienceDaysStr = ConfigUtils.getConfig("experienceOrderExperienceDays").getConfigValue();	// 体验订单可体验时长（天）
					//Integer experienceDays = Integer.valueOf(experienceDaysStr);
					Integer experienceDays =eo.getExperienceDays() == null?Integer.valueOf(experienceDaysStr):eo.getExperienceDays();
					Date realExpEndDate = DateUtils.getDateOffset(realExpDate, 5, experienceDays-1);	// 体验结束日期
					if(DateUtils.compare_date(eo.getAppointPickDate(), realExpEndDate) == 1){
						BigDecimal overdueDays = new BigDecimal(DateUtils.getDistanceOfTwoDate(realExpEndDate, eo.getAppointPickDate()));	// 延迟回货天数
						order.outOfDays = overdueDays.floatValue()+"";
					}
				}

				orderList.add(order);
			}
		}

		if(!buyOrderIdList.isEmpty()) {
			List<BuyOrder> boList = buyOrderService.listBuyOrderByIds(buyOrderIdList);
			for(BuyOrder bo : boList) {
				order = new Order();
				order.expressCompany = DictUtils.getDictLabel(ro.getExpressCompany(), "express_company", "");
				order.expressNo = ro.getExpressNo();
				order.orderNo = bo.getOrderNo();
				order.orderStatus = bo.getStatusMember();
				order.orderType = bo.getType();
				order.outOfDays = "0";
				order.receiveTime = receiveTime;
				order.receiveBy = receiveBy;
				orderList.add(order);
			}
		}
		return orderList;
	}

	/**
	 * 根据退货单ID更新对应的货品，及退货单状态
	 * @param returnOrder
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean updateStatusAndProduct(ReturnOrder returnOrder) {
		//校验退货单状态
		if(!ReturnOrder.STATUS_TOCHECK.equals(returnOrder.getStatus())){
			return false;
		}
		List<ReturnProduct> returnProductList =returnOrder.getReturnProductList();
		if(returnProductList.size() == 0){
			throw new ServiceException("体验单没有关联货品，请核查！");
		}
		returnProductService.batchSave(returnProductList);//更新退货单对应的货品
		//根据订单号获取体验单
		ExperienceOrder ep = experienceOrderService.get(returnOrder.getOrderId());
		Boolean isAllFree = false;
		if(ep.getMoneyProduce().compareTo(BigDecimal.ZERO) == 0){//判断是否全免押金，如果全免押金则不扣质检金额
			isAllFree = true;
		}
		//更新用户体验产品的质检扣减金额
		String produceId =null;
		Map<String,Map<String,BigDecimal>> proMap = new HashMap<>();//产品Id：所属该产品的货品质检金额之和
		Map<String,BigDecimal> decableMap=null;
		for(ReturnProduct returnProduct : returnProductList){
			if(ReturnProduct.RT_MEMBER.equals(returnProduct.getResponsibilityType())){//责任人划分，如果责任不是会员不做体验单质检扣除金额
				//过滤影响二次销售损坏商品
				/*if(ReturnProduct.Dt_3.equals(returnProduct.getDamageType())){
					//不算质检金额和抵扣魅力豆
				}else{*/
				if(isAllFree && ReturnProduct.Dt_1.equals(returnProduct.getDamageType())){
					returnProduct.setDecMoney(BigDecimal.ZERO);
				}
				if(ReturnProduct.Dt_5.equals(returnProduct.getDamageType())){//货品遗失，扣减金额为零（因为增加了商品漏发或者的报备，不扣用户钱）
					returnProduct.setDecMoney(BigDecimal.ZERO);
				}
				String returnProduceId =returnProduct.getReturnProduce().getId();
				ReturnProduce returnProduce =returnProduceService.get(returnProduceId);
				if(returnProduce != null){
					//存在退货货品有来自不同的退货产品，做归类处理
					produceId =returnProduce.getProduce().getId();
					if(proMap.get(produceId) == null){
						decableMap = new HashMap<>();
						decableMap.put("decMoney",returnProduct.getDecMoney());
						if(breakdownStandardService.getByType(returnProduct.getDamageType())){
							decableMap.put("decableBeans",returnProduct.getDecMoney());
						}
						proMap.put(produceId,decableMap);
					}else{
						BigDecimal afterMoney = proMap.get(produceId).get("decMoney").add(returnProduct.getDecMoney());
						decableMap.put("decMoney",afterMoney);
						if(breakdownStandardService.getByType(returnProduct.getDamageType())){
							BigDecimal afterBeansMoney = proMap.get(produceId).get("decableBeans").add(returnProduct.getDecMoney());
							decableMap.put("decableBeans",afterBeansMoney);
						}
					}
				}else{
					return false;
				}
				//}

			}else{
				String returnProduceId =returnProduct.getReturnProduce().getId();
				ReturnProduce returnProduce =returnProduceService.get(returnProduceId);
				if(returnProduce != null){
					if(proMap.get(returnProduce.getProduce().getId()) == null){
						decableMap = new HashMap<>();
						decableMap.put("decMoney",BigDecimal.ZERO);
						decableMap.put("decableBeans",BigDecimal.ZERO);
						proMap.put(returnProduce.getProduce().getId(),decableMap);
					}else{
						BigDecimal afterMoney = proMap.get(returnProduce.getProduce().getId()).get("decMoney").add(BigDecimal.ZERO);
						BigDecimal afterBeansMoney = proMap.get(returnProduce.getProduce().getId()).get("decableBeans").add(BigDecimal.ZERO);
						decableMap.put("decMoney",afterMoney);
						decableMap.put("decableBeans",afterBeansMoney);
					}
				}
			}

		}
		//根据来源订单Id和对应产品Id，更新体验产品质检扣减金额
		String orderId = returnOrder.getOrderId();
		Map<String,Object> praMap = new HashMap<>();
		if(orderId != null){
			for (Map.Entry<String, Map<String,BigDecimal>> entry : proMap.entrySet()) {
				praMap.put("produceId",entry.getKey());
				praMap.put("orderId",orderId);
				praMap.put("status", ExperienceProduce.STATUS_TOSETTLEMENT);
				praMap.put("moneyCheckDec",entry.getValue().get("decMoney"));
				praMap.put("decableBeans",entry.getValue().get("decableBeans"));
				experienceProduceDao.updateByExperienceOrderAndProduce(praMap);
			}
		}


		//更新退货单状态
		returnOrder.setStatus(ReturnOrder.STATUS_TOACCOUNT);
		dao.update(returnOrder);

		return true;
	}

	@Transactional(readOnly = false)
	public void  update (ReturnOrder returnOrder){
		//更新退货单状态
		returnOrder.setStatus(ReturnOrder.STATUS_FINISH);
		dao.update(returnOrder);
	}
	@Transactional(readOnly = false)
	public void  updateStatusByorder (ReturnOrder returnOrder){
		//更新退货单状态
		dao.updateStatusByorder(returnOrder);
	}

	/**
	 * 根据ids查询订单集合
	 * @param ids
	 */
	public List<String> getReturnOrderByIds(List<String> ids){
		return dao.getReturnOrderByIds(ids);
	}

	/**
	 * 回货质检
	 * @param
	 * @throws IOException
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false ,propagation = Propagation.NOT_SUPPORTED)
	public boolean qualitySave(ReturnOrder returnOrder) throws ServiceException, IOException{
		//变量的设置
		BigDecimal money= null;
		Member member = null;
		BigDecimal overdueMoney;
		BigDecimal settlementDecMoney;
		Integer settlementDecBeansNum;
		BigDecimal srcReturnMoney;
		BigDecimal settlementDecableBeansMoney;
		BigDecimal settlementDecBeansMoney;
		//把存在影响二次销售的产品存入map中
		Map<String,Integer> breakMap = new HashMap<>();
		Map<String,Integer> changeMap = new HashMap<>();//换新map
		ReturnOrder order = get(returnOrder.getId());
		Boolean isSave = false;
		String isSlightDamage = null;
		String isLightBroken= null;//存在损坏的货品
		List<String> brokenList = new ArrayList<>();
		//自动结算退款金额
		try {
			if(returnOrder!= null && returnOrder.getStatus().equals(ReturnOrder.STATUS_TOCHECK)){
				//自动转购买
				//更新回货货品数据
				isSave = updateStatusAndProduct(returnOrder);
				//判断是否存在影响二次销售的损坏商品，如有，则该货品转自动购买
				List<ReturnProduct> returnProductList = returnOrder.getReturnProductList();
				if (returnProductList.size() == 0) {
					throw new ServiceException("体验单没有关联货品，请核查！");
				}
				for (ReturnProduct returnProduct : returnProductList) {
					brokenList.add(returnProduct.getDamageType());
					/*if(ReturnProduct.Dt_1.equals(returnProduct.getDamageType()) || ReturnProduct.Dt_2.equals(returnProduct.getDamageType())){
						isLightBroken = "true";
					}*/
					if (ReturnProduct.Dt_3.equals(returnProduct.getDamageType()) || ReturnProduct.Dt_5.equals(returnProduct.getDamageType())) {

						//获取应转购买的产品id
						if (breakMap.get(returnProduct.getProduct().getProduce().getId()) == null) {
							breakMap.put(returnProduct.getProduct().getProduce().getId(), 1);
						} else {
							breakMap.put(returnProduct.getProduct().getProduce().getId(), breakMap.get(returnProduct.getProduct().getProduce().getId()) + 1);
						}
						if(changeMap.get(returnProduct.getProduct().getProduce().getId()) == null){
							if(QualityWorkordProduct.Dt_3.equals(returnProduct.getDamageType())){//货品遗失，不计算购买数量
								changeMap.put(returnProduct.getProduct().getProduce().getId(),1);
							}
						}else{
							if(QualityWorkordProduct.Dt_3.equals(returnProduct.getDamageType())){//货品遗失，不计算购买数量
								changeMap.put(returnProduct.getProduct().getProduce().getId(),changeMap.get(returnProduct.getProduct().getProduce().getId())+1);
							}
						}
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
				if(brokenList.contains(QualityWorkordProduct.Dt_5)){
					isLightBroken= QualityWorkordProduct.Dt_5;
				}else if(brokenList.contains(QualityWorkordProduct.Dt_3)){
					isLightBroken= QualityWorkordProduct.Dt_3;
				}else if(brokenList.contains(QualityWorkordProduct.Dt_2)){
					isLightBroken= QualityWorkordProduct.Dt_2;
				}else if(brokenList.contains(QualityWorkordProduct.Dt_1)){
					isLightBroken= QualityWorkordProduct.Dt_1;
				}
				if (breakMap.size() > 0) {
					//先更新体验产品的转自动购买的数量
					for (Map.Entry<String, Integer> entry : breakMap.entrySet()) {
						Integer buyNum = entry.getValue();
						//当回货货品为遗失时，判断货品是否报备过且报备类型为商品错发或者漏发，如是则不算购买，购买数量减
						Map<String,Integer> loseProMap = serviceApplyService.findLoseByOrder(returnOrder.getOrderId());
						if(loseProMap.size() > 0){
							for(Map.Entry<String, Integer> loseMap : loseProMap.entrySet()){
								if(breakMap.get(loseMap.getKey()) !=null){
									//报备且是错发或漏发
									buyNum=buyNum-loseMap.getValue();
								}
							}
						}
						if(buyNum >0){
							Map<String, Object> param = new HashMap<>();
							param.put("produceId", entry.getKey());
							param.put("buyNum", buyNum);
							param.put("orderId", order.getOrderId());
							param.put("decisionType", ExperienceProduce.DECISIONTYPE_BUY);
							experienceProduceDao.updateBuyNumByExperienceOrderAndProduce(param);
						}else{
							//直接走质检，不转购买
							ExperienceOrder experienceOrder = experienceOrderService.getDetail(returnOrder.getOrderId());
							member = experienceOrder.getMember();
							experienceOrder.setIsLightBroken(isLightBroken);
							//没有影响二次销售的产品则自动结算，不转购买
							experienceOrderService.settleExperienceOrderAuto(experienceOrder);
							//更新退货单完成状态
							update(returnOrder);
							break;
						}
					}
					if(changeMap.size() > 0){
						for (Map.Entry<String, Integer> entry : changeMap.entrySet()) {
							//先更新体验产品的换新的数量
							Map<String, Object> param = new HashMap<>();
							param.put("produceId", entry.getKey());
							param.put("changeNewNum", entry.getValue());
							param.put("orderId", order.getOrderId());
							experienceProduceDao.updateChangeNumByExperienceOrderAndProduce(param);
						}
					}
					ExperienceOrder experienceOrder = experienceOrderService.getDetail(returnOrder.getOrderId());
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
					update(returnOrder);
				} else {
					ExperienceOrder experienceOrder = experienceOrderService.getDetail(returnOrder.getOrderId());
					member = experienceOrder.getMember();
					experienceOrder.setIsLightBroken(isLightBroken);
					//没有影响二次销售的产品则自动结算，不转购买
					experienceOrderService.settleExperienceOrderAuto(experienceOrder);
					//更新退货单完成状态
					update(returnOrder);
				}
			}
		}catch (IOException e) {
			e.printStackTrace();
		}catch (NullPointerException e) {
			e.printStackTrace();
		}catch (ServiceException se) {
			String msg = se.getMessage();
			if (msg.startsWith("{")) {
				//更新退货单状态（即使有欠款也更新退货单）
				try {//如果消息异常这也回滚欠款的相关事务
					update(returnOrder);
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

						ExperienceOrder eo = new ExperienceOrder();
						eo.setArrearageAmount(money);
						eo.setStatusSystem(ExperienceOrder.STATUSSYSTEM_DUE);
						eo.setStatusMember(ExperienceOrder.STATUSMEMBER_DUE);
						eo.setId(order.getOrderId());
						eo.setMoneySettOverdue(overdueMoney);
						eo.setMoneySettDec(settlementDecMoney);
						eo.setMoneySettSrcReturn(srcReturnMoney);                    // 结算原始应退金额
						eo.setMoneySettDecableBeans(settlementDecableBeansMoney);    // 结算魅力豆可抵金额
						eo.setMoneySettDecBeans(settlementDecBeansMoney);            // 结算魅力豆抵扣金额
						eo.setNumSettDecBeans(settlementDecBeansNum);                // 结算魅力豆抵扣数量
						eo.setSettlementTime(new Date());
						experienceOrderService.updateDueStatus(eo);
					}
					//欠款消息发送
					Member me =new Member();
					me.setId(temp.getMemberId());
					if (ReturnProduct.Dt_1.equals(temp.getDamageType())) {
						memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_SLIGHT_DAMAGE, me, temp.getOrderNo(), temp.getMoneySettDecBeans() == null ? "0" : temp.getMoneySettDecBeans().toString());
					} else {
						if (temp.getDamageType() != null && ReturnProduct.Dt_2.equals(temp.getDamageType())) {
							memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_BACK, me, temp.getOrderNo());
						} else if(temp.getDamageType() != null && ReturnProduct.Dt_3.equals(temp.getDamageType())){
							memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_BACK_FOR_NEW, me, temp.getOrderNo());
						}
					}
				} catch (ServiceException e) {
					throw new ServiceException(e.getMessage());
				}
			} else {
				throw new ServiceException(se.getMessage());
			}
		}
		return isSave;
	}
	/**
	 * 回货质检时，存在重度损坏换新，回货单挂起
	 * @param
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public void  hang (ReturnOrder returnOrder){
		//生成质检工单
		ReturnOrder re = get(returnOrder.getId());
		ExperienceOrder experienceOrder =experienceOrderService.get(re.getOrderId());
		QualityWorkorder qualityWorkorder = new QualityWorkorder();
		qualityWorkorder.setOrderId(re.getOrderId());
		qualityWorkorder.setOrderNo(re.getOrderNo());
		qualityWorkorder.setWorkorderType(QualityWorkorder.WORKORDER_TYPE_REPLACE);
		qualityWorkorder.setStatus(QualityWorkorder.WORKORDER_STATUS_DEAL);
		qualityWorkorder.setMemberId(experienceOrder.getMember().getId());
		qualityWorkorder.setUsercode(experienceOrder.getMember().getUsercode());
		qualityWorkorder.setOrderType(experienceOrder.getType());
		qualityWorkorder.setAppointedUser(UserUtils.getUser().getId());
		qualityWorkorder.setWorkorderNo(codeGeneratorService.generateCode(QualityWorkorder.SER_AS_QUALITY_ORDERNO));
		qualityWorkorderService.save(qualityWorkorder);

		List<ReturnProduct> returnProductList =  returnOrder.getReturnProductList();
		for(ReturnProduct returnProduct :returnProductList){
			QualityWorkordProduct qualityWorkordProduct = new QualityWorkordProduct();
			qualityWorkordProduct.setDamageType(returnProduct.getDamageType());
			qualityWorkordProduct.setDecMoney(returnProduct.getDecMoney());
			qualityWorkordProduct.setProduct(returnProduct.getProduct());
			qualityWorkordProduct.setResponsibilityType(returnProduct.getResponsibilityType());
			qualityWorkordProduct.setWorkOrderId(qualityWorkorder.getId());
			qualityWorkordProduct.setReturnProduceId(returnProduct.getReturnProduce().getId());
			qualityWorkordProductService.save(qualityWorkordProduct);
		}
		Boolean isSave = updateStatusAndProduct(returnOrder);
		if(!isSave){
			throw new ServiceException("退货单货品更新失败！");
		}
		//更新退货单状态
		returnOrder.setStatus(ReturnOrder.STATUS_HANG);
		dao.update(returnOrder);
	}
	/**
	 * 回货单激活
	 * @param
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public void  active (ReturnOrder returnOrder){
		//修改工单状态
		ReturnOrder re = get(returnOrder.getId());
		Workorder workorder = new Workorder();
		workorder.setOrderId(re.getOrderId());
		workorder.setStatus(Workorder.WORKORDER_STATUS_FINISH);
		workorderService.updateStatusByOrderId(workorder);
		//更新退货单状态
		returnOrder.setStatus(ReturnOrder.STATUS_TOCHECK);
		dao.update(returnOrder);
	}

	public List<ReturnOrder> findReceiptList() {
		return dao.findReceiptList();
	}

	public ReturnOrder getByExpressNo(String expressNo){
		ReturnOrder returnOrder = new ReturnOrder();
		returnOrder.setExpressNo(expressNo);
		returnOrder.setStatus(ReturnOrder.STATUS_TOCHECK);
		return dao.getByExpressNo(returnOrder);
	}
}