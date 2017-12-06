/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceOrderDao;
import com.chinazhoufan.admin.modules.bus.dao.ol.SendOrderDao;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduct;
import com.chinazhoufan.admin.modules.bus.entity.pm.PlateManage;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceProduceService;
import com.chinazhoufan.admin.modules.bus.service.pm.PlateManageService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.crm.service.ns.NotifyService;
import com.chinazhoufan.admin.modules.express.services.SFService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressNoSegment;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressNoSegmentService;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.mobile.wechat.service.pay.config.OrderType;

/**
 * 发货单Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class SendOrderService extends CrudService<SendOrderDao, SendOrder> {

	@Autowired
	private ExperienceOrderDao experienceOrderDao;
	@Autowired
	private ExperienceProduceService experienceProduceService;
	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductWpIoService productWpIoService;
	@Autowired
	private PickOrderService pickOrderService;
	@Autowired
	private SendProduceService sendProduceService;
	@Autowired
	private SendProductService sendProductService;
	@Autowired
	private ExpressNoSegmentService segmentService;
	@Autowired
	private NotifyService notifyService;
	@Autowired
	private MemberNotifyService memberNotifyService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private ServiceApplyService serviceApplyService;
	@Autowired
	private PlateManageService plateManageService;
	@Autowired
	SFService sfService;
	
	public SendOrder get(String id) {
		return super.get(id);
	}
	
	public List<SendOrder> findList(SendOrder sendOrder) {
		return super.findList(sendOrder);
	}
	
	public Page<SendOrder> findPage(Page<SendOrder> page, SendOrder sendOrder) {
		return super.findPage(page, sendOrder);
	}
	
	/**
	 * 查询出待拣货的发货单（发货日期在当前日期或之前，状态为待拣货，删除标记为未删除）
	 * @param page
	 * @param sendOrder
	 * @return
	 */
	public Page<SendOrder> findToPickPage(Page<SendOrder> page, SendOrder sendOrder) {
		sendOrder.setPage(page);
		page.setList(dao.findToPickList(sendOrder));
		return page;
	}

	@Transactional(readOnly = false)
	public void save(SendOrder sendOrder) {
		super.save(sendOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(SendOrder sendOrder) {
		super.delete(sendOrder);
	}
	
	/*************************************生成测试代码****************************************/
	//TODO 待删
	@Transactional(readOnly = false)
	public void createTestData() {
		List<ExperienceOrder> eoList = experienceOrderDao.findList(new ExperienceOrder());
		ExperienceProduce epro = null;
		SendOrder so = null;
		SendProduce sp = null;
		int i = 1;
		for(ExperienceOrder eo : eoList) {
			so = new SendOrder();
			
			so.setSendOrderNo("SO-0000"+i);  // 发货单编号
			so.setOrderType(OrderType.APPOINTEXPERIENCE.getType());			// 来源订单类型（体验/预约/购买/预购）
			so.setOrderId(eo.getId());				// 来源订单ID
			so.setOrderNo(eo.getOrderNo());				// 来源订单编号
			so.setStatus(SendOrder.STATUS_TOPICK);				// 发货状态（待发货/发货中/发货完成）
			so.setReceiveName("小周周");			// 收货人
			so.setReceiveTel("13865659568");			// 收货电话
			so.setReceiveAreaStr("浙江省杭州市西湖区");		// 收货地址省市区
			so.setReceiveAreaDetail("湖滨银泰1楼");	// 收货地址详情
			so.setMemberRemarks("测试发货单数据");		// 用户备注
			so.setPickOrder(null);		// 所属拣货单
			so.setPickNo(null);				// 所属拣货序号
			so.setExpressCompany(SendOrder.EXPRESS_COMPANY_ZJS);		// 快递公司
			so.setExpressNo(null);			// 快递单号
			so.setExpressTime(null);			// 发货时间
			so.setActiveFlag(SendOrder.TRUE_FLAG);
			super.save(so);
			
			epro = new ExperienceProduce();
			epro.setExperienceOrder(eo);
			List<ExperienceProduce> epList = experienceProduceService.findList(epro);
			for(ExperienceProduce ep : epList) {
				sp = new SendProduce();
				sp.setSendOrder(so);
				sp.setOrderProduceId(ep.getId());
				sp.setProduce(ep.getProduce());
				sp.setNum(RandomUtils.nextInt(1, 5));
				sendProduceService.save(sp);
			}
			i++;
		}
	}
	/*************************************生成测试代码****************************************/
	//TODO 根据发货单类型（目前写死成，体验单发货）和订单id获取发货单
	public SendOrder getByOrderId(String orderId) {
		return dao.getByOrderId(orderId);
	}
	
	/**
	 * 接受发货单，生成拣货单
	 * @param ids
	 * @param plateManage
	 */
	@Transactional(readOnly = false)
	public void receiveSendOrder(String ids, String orderIds, PlateManage plateManage, User user) {
		
		//20171015增加是否有取消订单申请校验
		String[] orderIdArr = orderIds.split(",");
		for(String orderId : orderIdArr) {
			if (serviceApplyService.countByOrderId(orderId, ServiceApply.ADT_CANCEL) > 0) {
				throw new ServiceException("失败：该["+getByOrderId(orderId).getSendOrderNo()+"]发货单对应订单存在取消订单的申请，请核对！");
			}
		}
		
		//校验托盘号当前是否有未打包完成的任务
		PickOrder po = new PickOrder();
		po.setPlateNo(plateManage.getPlateNo());
		PickOrder pickOrder = pickOrderService.findPickOrderByPlateNo(po);
		if(pickOrder != null){//存在未打包完成的任务
			throw new ServiceException("失败：该托盘["+ plateManage +"]存在未打包完成的任务，请核对！");
		}
		po.setPickOrderNo(codeGeneratorService.generateCode(PickOrder.GENERATECODE_ORDERNO));	// 生成拣货单编号
		if(user == null) {
			po.setPickBy(UserUtils.getUser());
			po.setCreateBy(UserUtils.getUser());
		} else {
			po.setPickBy(user);
			po.setCreateBy(user);
		}
		po.setPickStartTime(new Date());

		pickOrderService.save(po);
		
		String[] idArr = ids.split(",");
		int i = 1;
		for(String id : idArr) {
			SendOrder so = dao.get(id);
			so.setPickOrder(po);
			so.setPickNo(i+"");//拣货序号
			so.setStatus(SendOrder.STATUS_PICKING);
			i++;
			dao.update(so);
		}
		plateManage.setPlateUsed(BaseEntity.TRUE_FLAG);
		plateManageService.save(plateManage);
	}
	
	/**
	 * 根据快递号获取订单对应的发货单信息
	 * @param expressNo
	 * @return
	 */
	public SendOrder findSendOrderByExpressNo(String expressNo) {
		SendOrder so = new SendOrder();
		so.setExpressNo(expressNo);
		return dao.findSendOrderByExpressNo(so);
	}
	
	/**
	 * 根据拣货单ID，批量更新发货单的状态为打包中
	 * @param sendOrder
	 */
	@Transactional(readOnly = false)
	public void updateStatusByPickOrder(SendOrder sendOrder) {
		dao.updateStatusByPickOrder(sendOrder);
	}

	/**
	 * 根据订单ID，更新发货单的状态为打包中
	 * @param sendOrder
	 */
	@Transactional(readOnly = false)
	public void updateStatusByOrder(SendOrder sendOrder) {
		dao.updateStatusByOrder(sendOrder);
	}

	/**
	 * 根据订单ID，更新发货单的用户信息
	 * @param sendOrder
	 */
	@Transactional(readOnly = false)
	public void updateByOrder(SendOrder sendOrder) {
		dao.updateByOrder(sendOrder);
	}
	
	/**
	 * 根据拣货单ID、托盘编号，获取拣货中或打包中、已激活、拣货序号最小的发货单信息
	 * @param sendOrder
	 * @return
	 */
	public List<SendOrder> findSendOrderWithMinPickNo(SendOrder sendOrder) {
		return dao.findSendOrderWithMinPickNo(sendOrder);
	};
	
	
	/**
	 * 根据ID更新状态和物流单号
	 * @param sendOrder
	 */
	public void updateStatusAndExpressNoById(SendOrder sendOrder) {
		dao.updateStatusAndExpressNoById(sendOrder);
	};
	
	

	/**
	 * 根据拣货单ID获取打包中的发货单数量
	 * @param sendOrder
	 * @return
	 */
	public Integer countPackageingByPickOrder(SendOrder sendOrder) {
		return dao.countPackageingByPickOrder(sendOrder);
	}
	
	
	/**
	 * 根据ID列出发货单详情，包括产品，及商品明细
	 * @param sendOrder
	 * @return
	 */
	public SendOrder findWithDetail(SendOrder sendOrder) {
		return dao.findWithDetail(sendOrder);
	}
	/**
	 * 根据体验单生成发货单（只应用于换新转购买业务）
	 * @param experienceOrder
	 * @return
	 */
	@Transactional(readOnly=false)
	public void createByExperienceOrder(ExperienceOrder experienceOrder) {
		SendOrder sendOrder = new SendOrder();
		sendOrder.setSendOrderNo(codeGeneratorService.generateCode(SendOrder.GENERATECODE_ORDERNO));
		if (ExperienceOrder.TYPE_EXPERIENCE.equals(experienceOrder.getType()) ) {
			sendOrder.setOrderType(SendOrder.ORDERTYPE_EXPERIENCE);
		}else if (ExperienceOrder.TYPE_APPOINTEXPERIENCE.equals(experienceOrder.getType())) {
			sendOrder.setOrderType(SendOrder.ORDERTYPE_FOREEXPERIENCE);
		}
		sendOrder.setOrderId(experienceOrder.getId());
		sendOrder.setOrderNo(experienceOrder.getOrderNo());
		sendOrder.setStatus(SendOrder.STATUS_TOPICK);
		sendOrder.setActiveFlag(SendOrder.TRUE_FLAG);
		sendOrder.setReceiveName(experienceOrder.getReceiveName());
		sendOrder.setReceiveAreaStr(experienceOrder.getReceiveAreaStr());
		sendOrder.setReceiveTel(experienceOrder.getReceiveTel());
		sendOrder.setReceiveAreaDetail(experienceOrder.getReceiveAreaDetail());
		sendOrder.setMemberRemarks(experienceOrder.getMemberRemarks());
		sendOrder.setType(SendOrder.ORDERTYPE_CHANGE);
		if (ExperienceOrder.TYPE_APPOINTEXPERIENCE.equals(experienceOrder.getType())) {
			sendOrder.setSendDate(DateUtils.addDays(experienceOrder.getAppointDate(), experienceOrder.getExpressDays()+1));
		}else {
			sendOrder.setSendDate(new Date());
		}
		save(sendOrder);
		SendProduce sendProduce = null;
		for (ExperienceProduce experienceProduce : experienceProduceService.getByExperienceOrder(experienceOrder.getId())) {
			if("true".equals(experienceOrder.getIsQuality())){
				if(experienceProduce.getChangeNewNum() != null && experienceProduce.getChangeNewNum() > 0 ){
					sendProduce = new SendProduce();
					sendProduce.setSendOrder(sendOrder);
					sendProduce.setOrderProduceId(experienceProduce.getId());
					sendProduce.setProduce(experienceProduce.getProduce());
					sendProduce.setNum(experienceProduce.getChangeNewNum());
					sendProduceService.save(sendProduce);
				}
			}else{
				sendProduce = new SendProduce();
				sendProduce.setSendOrder(sendOrder);
				sendProduce.setOrderProduceId(experienceProduce.getId());
				sendProduce.setProduce(experienceProduce.getProduce());
				sendProduce.setNum(experienceProduce.getNum());
				sendProduceService.save(sendProduce);
			}

		}
	}
	
	/**
	 * 变更发货单激活状态
	 * @param sendOrder
	 */
	@Transactional(readOnly = false)
	public void updateActiveFlagById(SendOrder sendOrder) {
		dao.updateActiveFlagById(sendOrder);
	}
	
	/**
	 * 发货单确认出库
	 * 1.保存发货货品、更新货品,校验发货单是否换新发货
	 * 2.更新发货单
	 * 3.更新当前发货单使用的快递单号
	 * 4.更新对应的订单状态
	 * 5.如果是最后一个发货单，需要更新拣货单
	 * 6.生成发货消息(9.13改：改为确认发货时执行)
	 * @param sendProduct
	 * @return boolean		拣货单完成状态（拣货单下所有发货单都已发货，则拣货单完成）
	 */
	@Transactional(readOnly = false)
	public boolean sendOrderOutConfirm(SendProduct sendProduct) {
		SendOrder so = sendProduct.getSendOrder();
		if (serviceApplyService.countByOrderId(so.getOrderId(), ServiceApply.ADT_CANCEL) > 0) {
			throw new ServiceException("失败：该["+so.getSendOrderNo()+"]发货单对应订单存在取消订单的申请，请核对！");
		}
		SendProduct spt = null;
//		ProductWpIo pwio = null;
		Boolean pickOrderFinishFlag = false;
		
		
		// 1.保存发货货品、更新货品
		List<SendProduce> spList = so.getSendProduceList();
		for(SendProduce sp : spList) {
			List<Product> ptl = sp.getProductList();
			for(Product pt : ptl) {
				// 保存发货货品
				Product product = productService.getByCode(pt.getCode());
				if(!Product.STATUS_NORMAL.equals(product.getStatus()))
					throw new ServiceException("失败：该发货单要发货的货品[code="+product.getCode()+"]不是正常可发货状态，请核对！");
				spt = new SendProduct();
				spt.setSendOrder(so);
				spt.setSendProduce(sp);
				spt.setProduct(product);
				spt.setOutWareplace(product.getWareplace());
				sendProductService.save(spt);
				
				// 更新货品,出库货位不做清除
				product.setStatus(Product.STATUS_LOCKED);
				product.setStatusLogistics(Product.STATUS_LGT_DELIVERING);
				//product.setWareplace(new Wareplace());
				product.setHoldUser(UserUtils.getUser());
				product.setUpdateDate(new Date());
				product.setUpdateBy(UserUtils.getUser());
				product.preUpdate();
				productService.updateSingle(product);

				//检验此发货单的发货单类型，如果是换新发货，则自动执行货品出库
				if(SendOrder.ORDERTYPE_CHANGE.equals(so.getType())){
					ProductWpIo productWpIo = new ProductWpIo();
					productWpIo.setProduct(product);
					productWpIo.setIoType(ProductWpIo.IOTYPE_OUT);
					productWpIo.setIoReasonType(ProductWpIo.IOREASIONTYPE_OUT_SALE);
					productWpIo.setIoUser(UserUtils.getUser());
					productWpIo.setIoTime(new Date());
					productWpIo.setIoBusinessorderId(so.getOrderNo());
					productWpIoService.productOutSave(productWpIo);
				}
//				//统一调用货品出入库Service里面的出库接口
//				pwio = new ProductWpIo();
//				pwio.setProduct(product);
//				pwio.setIoType(ProductWpIo.IOTYPE_OUT);
//				if(OrderType.EXPERIENCE.getType().equals(so.getOrderType())
//						|| OrderType.APPOINTEXPERIENCE.getType().equals(so.getOrderType())) {
//					pwio.setIoReasonType(ProductWpIo.IOREASIONTYPE_OUT_EXPERIENCE);
//				} else if(OrderType.BUY.getType().equals(so.getOrderType())
//						|| OrderType.APPOINTBUY.getType().equals(so.getOrderType())) {
//					pwio.setIoReasonType(ProductWpIo.IOREASIONTYPE_OUT_SALE);
//				}
//				pwio.setIoBusinessorderId(so.getOrderNo());	// 来源业务单号：发货单编号
//				pwio.setIoUser(UserUtils.getUser());
//				pwio.setIoTime(new Date());
//				productWpIoService.productOutSave(pwio);
			}
		}
		
		// 2.更新发货单状态（发货中）、发货时间
		so.setStatus(SendOrder.STATUS_WAITSEND);
//		so.setExpressTime(new Date());
		so.preUpdate();
		this.updateStatusAndExpressNoById(so);
		
		// 3.更新当前发货单使用的快递单号（已使用）
		ExpressNoSegment segment = new ExpressNoSegment();
		segment.setStatus(ExpressNoSegment.TRUE_FLAG);
		segment.setUseTime(new Date());
		segment.setExpressCompany(so.getExpressCompany());
		segment.setExpressNo(so.getExpressNo());
		segment.preUpdate();
		segmentService.updateByExpressNo(segment);
		
		
		Member member = null;
//		String orderNo = null;
		// 4.更新发货单对应的订单状态（待收货）--9.14改：改为确认发货时更改订单状态
		if(OrderType.EXPERIENCE.getType().equals(so.getOrderType())
				|| OrderType.APPOINTEXPERIENCE.getType().equals(so.getOrderType())) {
			ExperienceOrder eo = experienceOrderDao.get(so.getOrderId());
			if(eo == null) {
				throw new ServiceException("失败：该发货单对应的体验单[id="+so.getOrderId()+"]不存在，请核对！");
			}
//			orderNo=  eo.getOrderNo();
			member = eo.getMember();
		} else if(OrderType.BUY.getType().equals(so.getOrderType())
				|| OrderType.APPOINTBUY.getType().equals(so.getOrderType())) {
			BuyOrder bo = buyOrderService.get(so.getOrderId());
			if(bo == null) {
				throw new ServiceException("失败：该发货单对应的购买单[id="+so.getOrderId()+"]不存在，请核对！");
			}
			member = bo.getMember();
		}
		member = memberService.get(member);
		
		// 5.如果发货单是其所属拣货单的最后一个发货单，打包完成后，需要更新拣货单的打包完成时间
		Integer packageingNum = this.countPackageingByPickOrder(so);
		if(packageingNum == 0) {
			PickOrder po = pickOrderService.get(so.getPickOrder());
			po.setPackageEndTime(new Date());
			pickOrderService.save(po);
			// 拣货单完成标记
			pickOrderFinishFlag = true;
			/**更新托盘使用状态**/
			PlateManage plateManage = plateManageService.getByPlateNo(po.getPlateNo(), false);
			plateManage.setPlateUsed(BaseEntity.FALSE_FLAG);
			plateManageService.save(plateManage);
		}
		
		// 6.打包完成，生成发货消息（给会员）
//		try {
//			memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_SENDED, member, new Object[]{orderNo});
//		} catch (ServiceException e) {
//			throw new ServiceException(e.getMessage());
//		}

		return pickOrderFinishFlag;
	}

	/**
	 * 更新发货状态为待发货
	 * 1.更新对应的订单状态
	 * 2.生成发货消息
	 * @param id
	 * @return boolean
	 */
	@Transactional(readOnly = false)
	public boolean confirmSend(String id) {
		SendOrder so = this.get(id);
		if (serviceApplyService.countByOrderId(so.getOrderId(), ServiceApply.ADT_CANCEL) > 0) {
			throw new ServiceException("失败：该["+so.getSendOrderNo()+"]发货单对应订单存在取消订单的申请，请核对！");
		}
		SendProduct spt = null;
//		ProductWpIo pwio = null;
		Boolean pickOrderFinishFlag = false;

		if (SendOrder.STATUS_FINISH.equals(so.getStatus())){
			return pickOrderFinishFlag;
		}

		// 1.更新发货单状态（发货完成）、发货时间
		so.setStatus(SendOrder.STATUS_FINISH);
		so.setExpressTime(new Date());
		so.setUpdateBy(UserUtils.getUser());
		so.preUpdate();
		this.updateStatusAndExpressNoById(so);


		Member member = null;
		String orderNo = null;
		// 4.更新发货单对应的订单状态（待收货）
		if(OrderType.EXPERIENCE.getType().equals(so.getOrderType())
				|| OrderType.APPOINTEXPERIENCE.getType().equals(so.getOrderType())) {
			ExperienceOrder eo = experienceOrderDao.get(so.getOrderId());
			if(eo == null) {
				throw new ServiceException("失败：该发货单对应的体验单[id="+so.getOrderId()+"]不存在，请核对！");
			}
			orderNo=  eo.getOrderNo();
			member = eo.getMember();
			eo.setStatusMember(ExperienceOrder.STATUSMEMBER_TORECEIVE);	// 会员订单状态变更为待收货
			eo.setStatusSystem(ExperienceOrder.STATUSSYSTEM_SENDING);	// 系统订单状态变更为待收货（送货中）
			eo.preUpdate();
			experienceOrderDao.update(eo);
		} else if(OrderType.BUY.getType().equals(so.getOrderType())
				|| OrderType.APPOINTBUY.getType().equals(so.getOrderType())) {
			BuyOrder bo = buyOrderService.get(so.getOrderId());
			if(bo == null) {
				throw new ServiceException("失败：该发货单对应的购买单[id="+so.getOrderId()+"]不存在，请核对！");
			}
			member = bo.getMember();
			bo.setStatusMember(BuyOrder.STATUSMEMBER_TORECEIVE);		// 会员订单状态变更为待收货
			bo.setStatusSystem(BuyOrder.STATUSSYSTEM_SENDING);			// 会员订单状态变更为待收货
			buyOrderService.save(bo);
		}
		member = memberService.get(member);

		// 2.打包完成，生成发货消息（给会员）
		try {
			memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_SENDED, member, new Object[]{orderNo});
		} catch (ServiceException | IOException e) {
			throw new ServiceException(e.getMessage());
		}

		return pickOrderFinishFlag;
	}
	/**
	 * 应用场景：发货前，服务申请取消订单
	 * 1.根据订单获取相应的发货单，发货货品
	 * 2.校验数据以及状态是否正确
	 * 3.更新发货单状态
	 * 4.更新对应的拣货单状态（如果有则更新，没有不做操作）
	 * @param orderId
	 */
		public void refuseSendByOrder(String orderId){
			logger.info("-----------updateSendByOrder----------");
			logger.debug("refuse sendOrder  info:[orderId="+orderId+"]");
			SendOrder sendOrder = getByOrderId(orderId);
			if(sendOrder != null){
				String sendOrderId = sendOrder.getId();
				/**
				 * 1.验证数据
				 */
				//只有发货前的状态可以进行发货单取消
				if(!SendOrder.STATUS_WAITSEND.equals(sendOrder.getStatus()) && !SendOrder.STATUS_PACKAGEING.equals(sendOrder.getStatus())
				&& !SendOrder.STATUS_PICKING.equals(sendOrder.getStatus())&& !SendOrder.STATUS_TOPICK.equals(sendOrder.getStatus()) && !SendOrder.STATUS_CANCEL.equals(sendOrder.getStatus())){
					logger.debug("refuse sendOrder exception:发货单不是“待拣货”或“拣货中”或“打包中”或“待发货”状态，不能取消发货单");
					throw new ServiceException("发货单不是“待拣货”或“拣货中”或“打包中”或“待发货”状态，不能取消发货单");
				}
				//根据发货单获取对应的货品
				List<SendProduct> sendProducts =  sendProductService.findSendProductBySendOrder(sendOrderId);
				/*if(sendProducts == null || sendProducts.size() == 0){
					logger.debug("refuse sendOrder exception:发货单没有找到对应的货品，不能取消发货单");
					throw new ServiceException("发货单没有找到对应的货品，不能取消发货单");
				}*/
				/**
				 * 3.更新发货单状态
				 */
				sendOrder.setStatus(SendOrder.STATUS_CANCEL);
				save(sendOrder);
				/**
				 * 4.更新发货单对应货品的状态
				 */
				if(sendProducts != null && sendProducts.size() > 0){
					for(SendProduct sendProduct :sendProducts){
						if(!Product.STATUS_LOCKED.equals(sendProduct.getProduct().getStatus())){
							logger.debug("refuse sendOrder exception:发货单对应的货品状态不是“锁定”状态，不能取消发货单");
							throw new ServiceException("发货单对应的货品状态不是“锁定”状态，不能取消发货单");
						}
						Product pro = new Product();
						pro.setId(sendProduct.getProduct().getId());
						pro.setStatus(Product.STATUS_NORMAL);
						pro.setUpdateBy(UserUtils.getUser());
						pro.setUpdateDate(new Date());
						productService.updateSingle(pro);
					}
				}
				logger.info("-----------updateSendByOrder:发货单成功取消----------");
			}else{
				throw new ServiceException("警告：不存对应发货单，请联系管理员！");
			}
		}

	public List<SendOrder> findOutboundDetailsList(SendOrder sendOrder) {
			return dao.findOutboundDetailsList(sendOrder);
		}


	/**
	 * 根据拣货单查询发货单
	 * @param pickOrderId
	 * @return
	 */
	public List<SendOrder> findByPickOrder(String pickOrderId) {
		return dao.findByPickOrder(pickOrderId);
	}
	
	public SendOrder getBySendOrderNo(String sendOrderNo) {
		return dao.getBySendOrderNo(sendOrderNo);
	}
}

