/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.service.sa;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceProduceService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.ser.dao.sa.ServiceApplyDao;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 服务申请Service
 * @author 张金俊
 * @version 2017-08-14
 */
@Service
@Transactional(readOnly = true)
public class ServiceApplyService extends CrudService<ServiceApplyDao, ServiceApply> {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private ExperienceOrderService experienceOrderService;

	@Autowired
	private ExperienceProduceService experienceProduceService;

    @Autowired
    private ProduceService produceService;

	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	private MemberNotifyService memberNotifyService;

	public ServiceApply get(String id) {
		return super.get(id);
	}
	
	public List<ServiceApply> findList(ServiceApply serviceApply) {
		return super.findList(serviceApply);
	}
	
	
	public int countByOrderId(String orderId, String applyDealType) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("applyDealType", applyDealType);
		map.put("orderId", orderId);
		map.put("DRT_REFUSE", ServiceApply.DRT_REFUSE);
		return dao.countByOrderId(map);
	}
	
	/**
	 * 查询某类型订单对应的所有可免责的服务申请
	 * @param orderType	订单类型
	 * @param orderId	订单ID
	 * @return
	 */
	public List<ServiceApply> findReliefList(String orderType, String orderId) {
		ServiceApply serviceApplyParam = new ServiceApply();
		serviceApplyParam.setOrderType(orderType);
		serviceApplyParam.setOrderId(orderId);
		serviceApplyParam.setStatus(ServiceApply.STATUS_DEALED);				// 已处理
		serviceApplyParam.setApplyByType(ServiceApply.ABT_MEMBER);				// 申请人类型：会员
		serviceApplyParam.setApplyTimeType(ServiceApply.ATT_BEFORE_RECEIVE);	// 申请时机类型：收货前
		serviceApplyParam.setApplyDealType(ServiceApply.ADT_RELIEF);			// 申请处理类型：免责
		serviceApplyParam.setDealResultType(ServiceApply.DRT_PASS);				// 处理结果类型：通过
		return super.findList(serviceApplyParam);
	}
	
	public Page<ServiceApply> findPage(Page<ServiceApply> page, ServiceApply serviceApply) {
		return super.findPage(page, serviceApply);
	}

	public void getExperienceOrder(ServiceApply serviceApply){
		String orderId = serviceApply.getOrderId();
		if(orderId == null){
			throw new ServiceException("警告：对应订单不存在");
		}
		ExperienceOrder experienceOrder =experienceOrderService.get(orderId);
		serviceApply.setExperienceOrder(experienceOrder);
	}
	/**
	 * 获取用户的历史交易信息
	 * @param serviceApply
	 */
	public void getMemBus(ServiceApply serviceApply){

		String oldApplyTimeType = serviceApply.getApplyTimeType();
		String orderId = serviceApply.getOrderId();
		if(orderId == null){
			throw new ServiceException("警告：对应订单不存在");
		}
		ExperienceOrder experienceOrder =experienceOrderService.get(orderId);
		//获取用户体验的次数
		Integer experienceNum = experienceOrderService.getCountByMem(experienceOrder);
		serviceApply.setExperienceNum(experienceNum);

		//获取用户购买的次数
		BuyOrder buyOrder = new BuyOrder();
		buyOrder.setMember(experienceOrder.getMember());
		Integer buyNum = buyOrderService.getCountByMem(buyOrder);
		serviceApply.setBuyNum(buyNum);
		//获取用户售后次数（待收货状态下申请售后的订单数）
		serviceApply.setApplyById(experienceOrder.getMember().getId());
		serviceApply.setApplyTimeType(ServiceApply.ATT_BEFORE_RECEIVE);
		Integer applyNum = dao.getCountByMemAndType(serviceApply);
		serviceApply.setApplyNum(applyNum==null?0:applyNum);
		serviceApply.setExperienceOrder(experienceOrder);

		//获取订单取消次数（待发货状态下申请售后的订单数）
		serviceApply.setApplyTimeType(ServiceApply.ATT_BEFORE_SEND);
		Integer applyCancelNum = dao.getCountByMemAndType(serviceApply);
		serviceApply.setApplyCancelNum(applyCancelNum==null?0:applyCancelNum);
		//回货损坏次数
		Map<String, Integer> damageTypeNumMap = new HashMap<>();
		ReturnProduct returnProduct = new ReturnProduct();
		returnProduct.setResponsibilityType(ReturnProduct.RT_MEMBER);
		returnProduct.setDamageType(ReturnProduct.Dt_1);
		Integer Dt_1 = experienceOrderService.getDamageCount(returnProduct,experienceOrder.getMember().getId());
		damageTypeNumMap.put(ReturnProduct.Dt_1,Dt_1);

		returnProduct.setDamageType(ReturnProduct.Dt_2);
		Integer Dt_2 = experienceOrderService.getDamageCount(returnProduct,experienceOrder.getMember().getId());
		damageTypeNumMap.put(ReturnProduct.Dt_2,Dt_2);

		returnProduct.setDamageType(ReturnProduct.Dt_4);
		Integer Dt_4 = experienceOrderService.getDamageCount(returnProduct,experienceOrder.getMember().getId());
		damageTypeNumMap.put(ReturnProduct.Dt_4,Dt_4);

		returnProduct.setDamageType(ReturnProduct.Dt_5);
		Integer Dt_5 = experienceOrderService.getDamageCount(returnProduct,experienceOrder.getMember().getId());
		damageTypeNumMap.put(ReturnProduct.Dt_5,Dt_5);

		returnProduct.setDamageType(ReturnProduct.Dt_3);
		Integer Dt_3 = experienceOrderService.getDamageCount(returnProduct,experienceOrder.getMember().getId());
		damageTypeNumMap.put(ReturnProduct.Dt_3,Dt_3);
		serviceApply.setDamageTypeNumMap(damageTypeNumMap);
		serviceApply.setApplyTimeType(oldApplyTimeType);
	}
	/**
	 * 服务申请通过（执行订单取消）
	 * 1.更新体验单
	 * 2.更新体验产品
	 * 3.执行退款
	 * 4.更新库存
	 * 5.如果发货前，更新发货单
	 * 6.更新服务申请
	 * 7.发送会员消息
	 * @param serviceApply
	 * @throws IOException 
	 * @throws ServiceException 
	 */
	@Transactional(readOnly = false)
	public synchronized void  orderPass(ServiceApply serviceApply) throws ServiceException, IOException {
		String orderId = serviceApply.getOrderId();
		if(orderId == null){
			throw new ServiceException("警告：对应订单不存在");
		}
		if(!ServiceApply.STATUS_TO_DEAL.equals(serviceApply.getStatus())){
			throw new ServiceException("警告：申请单状态不正常，请联系管理员！");
		}
		//用户在发货前申请售后才能取消订单
		if(!ServiceApply.ATT_BEFORE_SEND.equals(serviceApply.getApplyTimeType())){
			//用户商品遗失申请售后（条件用户只体验了一个商品，才能自动结算转为购买）
			if(ServiceApply.ART_ALL_LOST.equals(serviceApply.getApplyReasonType())){
				experienceOrderService.experConvertBuy(orderId);
			}
			serviceApply.setStatus(ServiceApply.STATUS_DEALED);
			serviceApply.setDealBy(UserUtils.getUser());
			serviceApply.setDealTime(new Date());
			serviceApply.setDealResultType(ServiceApply.DRT_PASS);
			super.save(serviceApply);
			return;
		}
		ExperienceOrder experienceOrder = experienceOrderService.get(orderId);
		//如果存在预约订单延期未付尾款，则自动取消订单
		if(ExperienceOrder.TYPE_APPOINTEXPERIENCE.equals(experienceOrder.getType()) && ExperienceOrder.STATUSPAY_TOPAY_FINAL.equals(experienceOrder.getStatusPay()) && ServiceApply.ORDER_NO_PAY.equals(serviceApply.getApplyReasonType())){
			ExperienceOrder eoParam = new ExperienceOrder();
			eoParam.setId(orderId);
			eoParam.setCloseTime(new Date());
			eoParam.setUpdateDate(new Date());
			experienceOrderService.updateAppointToClose(eoParam);
			//更新服务申请状态
			serviceApply.setStatus(ServiceApply.STATUS_DEALED);
			serviceApply.setDealBy(UserUtils.getUser());
			serviceApply.setDealTime(new Date());
			serviceApply.setDealResultType(ServiceApply.DRT_PASS);
			super.save(serviceApply);
			// 新增会员消息
			try {
				memberNotifyService.createByNotifyCode(Notify.MSG_APPOINTORDER_CLOSE_AUTO, experienceOrder.getMember(),experienceOrder.getOrderNo());
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			ExperienceOrder eo = experienceOrderService.orderPass(orderId);
			serviceApply.setStatus(ServiceApply.STATUS_DEALED);
			serviceApply.setDealBy(UserUtils.getUser());
			serviceApply.setDealTime(new Date());
			serviceApply.setDealResultType(ServiceApply.DRT_PASS);
			super.save(serviceApply);

			// 新增会员消息
			if(ServiceApply.ABT_MEMBER.equals(serviceApply.getApplyByType())){
				memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_CANCEL_MEMBER, eo.getMember(), eo.getOrderNo());
			}else {
				memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_CANCEL_USER, eo.getMember(), eo.getOrderNo());
			}
		}

	}
	
	/**
	 * 服务申请拒绝
	 * 1.会员的服务申请，仅更新服务申请
	 * 2.打包员工的服务申请，更新服务申请，同时更新出库单
	 * 3.发送会员消息
	 * @param serviceApply
	 * @throws IOException 
	 * @throws ServiceException 
	 */
	@Transactional(readOnly = false)
	public void refuse(ServiceApply serviceApply) throws ServiceException, IOException {
		String orderId = serviceApply.getOrderId();
		if(orderId == null){
			throw new ServiceException("警告：对应订单不存在");
		}
		serviceApply.setStatus(ServiceApply.STATUS_DEALED);
		serviceApply.setDealBy(UserUtils.getUser());
		serviceApply.setDealTime(new Date());
		serviceApply.setDealResultType(ServiceApply.DRT_REFUSE);
		dao.update(serviceApply);
		ExperienceOrder experienceOrder = experienceOrderService.get(orderId);
		//如果存在预约订单延期未付尾款，则系统不受理
		if(ExperienceOrder.TYPE_APPOINTEXPERIENCE.equals(experienceOrder.getType()) && ExperienceOrder.STATUSPAY_TOPAY_FINAL.equals(experienceOrder.getStatusPay()) && ServiceApply.ORDER_NO_PAY.equals(serviceApply.getApplyReasonType())){
		logger.info("-------------------存在预约订单延期未付尾款，系统不受理---------");
		}else {
			if(ServiceApply.ABT_USER.equals(serviceApply.getApplyByType())){
				//变更发货单状态
				SendOrder sendOrder = new SendOrder();
				sendOrder.setStatus(SendOrder.STATUS_PACKAGEING);
				sendOrder.setOrderId(orderId);
				sendOrderService.updateStatusByOrder(sendOrder);
			}
			// 新增会员消息
			if(ServiceApply.ABT_MEMBER.equals(serviceApply.getApplyByType())){
				memberNotifyService.createByNotifyCode(Notify.MSG_SERVICEAPPLY_REFUSE_MEMBER, new Member(serviceApply.getApplyById()));
			}
		}

	}
	
	@Transactional(readOnly = false)
	public void delete(ServiceApply serviceApply) {
		super.delete(serviceApply);
	}
	
	/**
	 * 当前员工根据退货单生成（取消订单的）服务申请记录
	 * @param sendOrder
	 */
	@Transactional(readOnly = false)
	public void createBySendOrder(SendOrder sendOrder) {
		ServiceApply serviceApply = new ServiceApply();
		serviceApply.setNo(codeGeneratorService.generateCode(ServiceApply.GENERATECODE_NO));
		serviceApply.setOrderType(sendOrder.getOrderType());
		serviceApply.setOrderId(sendOrder.getOrderId());
		serviceApply.setStatus(ServiceApply.STATUS_TO_DEAL);			// 状态：待处理
		serviceApply.setApplyByType(ServiceApply.ABT_USER);				// 申请人类型：员工
		serviceApply.setApplyById(UserUtils.getUser().getId());			// 申请人
		serviceApply.setApplyTimeType(ServiceApply.ATT_BEFORE_SEND);	// 申请时机类型：发货前
		serviceApply.setApplyDealType(ServiceApply.ADT_CANCEL);			// 申请处理类型：取消订单
		serviceApply.setApplyReasonType(ServiceApply.ART_PRODUCT_LACK);	// 申请原因类型：库存缺货
		super.save(serviceApply);
	}
	/**
	 * 根据订单查询有产品遗失的且通过的服务单
	 * @param orderId
	 */
	public List<ServiceApply> findByOrder(String orderId){
		ServiceApply serviceApply = new ServiceApply();
		serviceApply.setOrderId(orderId);
		serviceApply.setDealResultType(ServiceApply.DRT_PASS);
		List<ServiceApply> serviceApplyList = super.findList(serviceApply);

		List<ServiceApply> applyList = new ArrayList<>();
		for(ServiceApply apply : serviceApplyList){
			if(ServiceApply.ART_ALL_LOST.equals(apply.getDealReasonType()) || ServiceApply.ART_PART_LOST.equals(apply.getDealReasonType())){
				applyList.add(apply);
			}
		}
		return applyList;
	}

	/**
	 * 根据订单查询有产品漏发或者错发的且通过的服务单
	 * @param orderId
	 */
	public Map<String,Integer>  findLoseByOrder(String orderId){
		ServiceApply serviceApply = new ServiceApply();
		serviceApply.setOrderId(orderId);
		serviceApply.setDealResultType(ServiceApply.DRT_PASS);
		List<ServiceApply> serviceApplyList = super.findList(serviceApply);
		Map<String,Integer> loseProMap =  new HashMap<>();
		for(ServiceApply apply : serviceApplyList){
			//根据订单产品id查询产品id
			ExperienceProduce experienceProduce = experienceProduceService.get(apply.getOrderProduceId());
			if(ServiceApply.ART_PRODUCE_LEAK.equals(apply.getDealReasonType()) || ServiceApply.ART_PRODUCE_WRONG.equals(apply.getDealReasonType())){
				if(loseProMap.get(experienceProduce.getProduce().getId())==null){
					loseProMap.put(experienceProduce.getProduce().getId(),1);
				}else{
					loseProMap.put(experienceProduce.getProduce().getId(),loseProMap.get(experienceProduce.getProduce().getId())+1);
				}
			}
		}
		return loseProMap;
	}

	/**
	 * 查询售后申请数
	 * @param memberId
	 * @param applyTimeType
	 * @return
	 */
	public int countByApplyBy(String memberId, String applyTimeType){
		Map<String, Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("applyTimeType", applyTimeType);
		return dao.countByApplyBy(map);
	}

    /**
     * 根据订单产品ID查询产品
     * @param orderProduceId
     * @return
     */
    public Produce findProduceByOrderProduceId(String orderProduceId){
        Produce produce = null;
        ExperienceProduce experienceProduce = experienceProduceService.get(orderProduceId);
        if(experienceProduce != null){
            produce = produceService.get(experienceProduce.getProduce().getId());
        }
        return produce;
    }

    public void getProduce(ServiceApply serviceApply){
    	String orderProduceId = serviceApply.getOrderProduceId();
    	if(orderProduceId == null){
			throw new ServiceException("警告：对应订单不存在");
		}
        Produce produce = findProduceByOrderProduceId(orderProduceId);
		serviceApply.setProduce(produce);
    }
}