/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.dp;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.BarCodeService;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.dao.BasMissionDao;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.bas.service.BasMissionService;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchMissionDao;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchOrderDao;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductWpChangeDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductWpIoDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.QualitycheckDetailDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.QualitycheckOrderDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarehouseDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WhProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchOrder;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduce;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduct;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckDetail;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.sys.dao.UserDao;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;

/**
 * 调货任务Service
 * @author 刘晓东
 * @version 2015-10-20
 */
@Service
@Transactional(readOnly = true)
public class DispatchMissionService extends BasMissionService<DispatchMissionDao,DispatchMission> {

	@Autowired
	private DispatchProduceDao dispatchProduceDao;
	@Autowired
	private WarehouseDao warehouseDao;
	@Autowired
	private BasMissionDao basMissionDao;	
	@Autowired
	private UserDao userDao;
	@Autowired
	private DispatchProductDao dispatchProductDao;
	@Autowired
	private DispatchOrderDao dispatchOrderDao;
	@Autowired
	private BarCodeService barCodeService;
	@Autowired
	private WarehouseService warehouseService;
	@Autowired
	private BasMissionService basMissionService;
	@Autowired
	private DispatchOrderService dispatchOrderService;
	@Autowired
	private WhProduceDao whProduceDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ProductWpIoDao productWpIoDao;
	@Autowired
	private ProductWpChangeDao productWpChangeDao;
	
	@Autowired
	private QualitycheckOrderDao qualitycheckOrderDao;
	@Autowired
	private QualitycheckDetailDao qualitycheckDetailDao;
	@Autowired
	private ProductWpIoService productWpIoService;
	
	public DispatchMission get(String id) {
		
		return super.get(id);
	}
	
	
	public DispatchMission getByChildId(String id) {
		return dao.getByChildId(id);
	}
	
	public DispatchMission getMissonWithProduceAndProductById(DispatchMission dispatchMission) {
		return dao.getMissionWithProductAndProduceById(dispatchMission);
	}
	
	public List<DispatchMission> findList(DispatchMission dispatchMission) {
		return super.findList(dispatchMission);
	}
	
	/**
	 * 发布任务查询
	 * @param DispatchMission
	 * @return
	 */
	public List<DispatchMission> findListByStartBy(DispatchMission dispatchMission) {
		return super.findList(dispatchMission);
	}
	/**
	 * 查询所有发布任务
	 * @param DispatchMission
	 * @return
	 */
	public Page<DispatchMission> findPage(Page<DispatchMission> page, DispatchMission dispatchMission) {
		return super.findPage(page, dispatchMission);
	}
	/**
	 * 调货出库责任人，确认出库
	 * @param DispatchMission
	 * @return
	 */
	public Page<DispatchMission> findPageoutUser(Page<DispatchMission> page, DispatchMission dispatchMission) {
		//接收任务人只能查看任务属于已确认审核通过状态的数据
//		if(StringUtils.isBlank(dispatchMission.getMissionStatus())) {//初始化默认为已确认数据
//			dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCALLOUT);
//		} else if("-1".equals(dispatchMission.getMissionStatus())) {//查询所有
//			dispatchMission.setMissionStatus("");
//		}
		dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCALLOUT);
		dispatchMission.setOutUser(UserUtils.getUser());
		
		dispatchMission.setPage(page);
		page.setList(dao.findPageOutUserList(dispatchMission));
		return page;
//		return super.findPage(page, dispatchMission);
	}
	
	/**
	 * 接收责任人确认到货
	 * @param DispatchMission
	 * @return
	 */
	public Page<DispatchMission> findPageinUser(Page<DispatchMission> page, DispatchMission dispatchMission) {
		//确认到货只查询调货单状态为派送中的数据
		dispatchMission.setDispatchOrder(new DispatchOrder(null,DispatchOrder.ORDERSTATUS_WAITCALLIN));
		dispatchMission.setInUser(UserUtils.getUser());
		return super.findPage(page, dispatchMission);
	}
	
	/**
	 * 接收责任人确认到货
	 * @param DispatchMission
	 * @return
	 */
	public Page<DispatchMission> pendingStockList(Page<DispatchMission> page, DispatchMission dispatchMission) {
		//确认到货只查询调货单状态为派送中的数据
		dispatchMission.setDispatchOrder(new DispatchOrder(null,DispatchOrder.ORDERSTATUS_PENDINGSTOCK));
		dispatchMission.setInUser(UserUtils.getUser());
		return super.findPage(page, dispatchMission);
	}
	
	/**
	 * 发布任务查询 只查询发起的人任务
	 * @param DispatchMission
	 * @return
	 */
	public Page<DispatchMission> findPageByStartBy(Page<DispatchMission> page, DispatchMission dispatchMission) {
		dispatchMission.setStartBy(UserUtils.getUser());
		return super.findPage(page, dispatchMission);
	}
	
	/**
	 * 调出仓库管理员确认调货数量和调货货品信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Transactional(readOnly = false)
	public void confirmTheLibrary(DispatchMission dispatchMission) {
		//更新总任务
		//备注：选择需要调货的货品，确认调货产品货品信息，需要锁定仓库调货产品的数量，在库库存需要减去调货的数量
		//调货货品信息确认需要锁定该货品，同时清空该货品的货位信息，货品的持有员工为当前的操作人员
		//信息确认成功，调货单的状态变为调货中,添加一条出库记录，添加货品状态变更记录,货品货位调整记录
		//更改调货单状态为派送中
		//修改任务状态为执行中
		
		dispatchMission.preUpdate();
		basMissionDao.update(dispatchMission);
		
		DispatchOrder dorder = dispatchMission.getDispatchOrder();
		dorder.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITSEND);//状态待派送
		dorder.preUpdate();
		dispatchOrderDao.update(dorder);
		
		//更新调货产品表调货数量
		for (DispatchProduce dispatchProduce : dorder.getDispatchProduceList()) {
			if(dispatchProduce.getActualNum() != null){
				//先删除调货产品关联的货品数据，然后将最新的数据插入
				dispatchProductDao.removeDispatchProductByDispatchProduceId(dispatchProduce.getId());

				for(DispatchProduct dispatchProduct:dispatchProduce.getDispatchProductList()){
					if(dispatchProduct.getProduct() != null && !StringUtils.isBlank(dispatchProduct.getProduct().getId())) {
						Product product = productDao.get(dispatchProduct.getProduct().getId());
						
						//插播
						dispatchProduct.setOutWareplace(product.getWareplace());
						
						//添加调货货品信息
						dispatchProduct.setStatus(DispatchProduce.STATUS_WAITCONFIRMED);
						dispatchProduct.setDispatchProduce(dispatchProduce);
						dispatchProduct.setProduct(dispatchProduct.getProduct());
						//出库质检待实现 TODO 
						//dispatchProduct.setProductCheckOrder(null);
						dispatchProduct.preInsert();
						dispatchProductDao.insert(dispatchProduct);
					}
				}
				//更新调货产品的实调数量
				dispatchProduce.setActualNum(dispatchProduce.getActualNum());
				dispatchProduce.setRemarks(dispatchProduce.getRemarks());
				dispatchProduce.setActualNum(dispatchProduce.getDispatchProductList().size());
				dispatchProduce.preUpdate();
				dispatchProduceDao.update(dispatchProduce);
			}
		}
	}
	
	/**
	 * 接收仓库管理员确认到货货品信息
	 */
	@Transactional(readOnly = false)
	public void ConfirmArrival(DispatchMission dispatchMission) {
		//备注：确认调货单到货状态改变为调货完成，出库仓库更新在库库存信息,入库仓库更新在库库存信息，锁定的货品需要解锁改变状态为出售中，调货货品的持有人变更为当前入库的库存管理员
		//出库仓库和入库仓库在更新产品库存时需要检测仓库是否到达警戒库存值，如果到达需要生成相应的报警信息给库管
		//根据仓库Id和产品id查询仓库库存信息
//		WhProduce whProduce = whProduceDao.getWhProduceById(dispatchProduce.getOutWarehouse().getId(),dispatchProduce.getProduce().getId());
		
		DispatchOrder dispatchOrder = new DispatchOrder();
		dispatchOrder.setDispatchMission(dispatchMission);
		List<DispatchOrder> dispatchOrderLists = dispatchOrderDao.findList(dispatchOrder);
		for(DispatchOrder dispatchOrderList:dispatchOrderLists){
			//调入仓库
			WhProduce inwhProduce = whProduceDao.getWhProduceByWidAndPid(dispatchMission.getInWarehouse().getId(),dispatchOrderList.getDispatchProduce().getId());
			//调出仓库
			WhProduce outwhProduce = whProduceDao.getWhProduceByWidAndPid(dispatchOrderList.getOutWarehouse().getId(),dispatchOrderList.getDispatchProduce().getId());
			//TODO 需要调整
			//调入仓库库存数量增加实际调货入库数量
			inwhProduce.preUpdate();
			whProduceDao.update(inwhProduce);
			//调出仓库库存数量减去实际调货的数量，锁定库存数量减去实际调货数量
//			outwhProduce.setStockWarehouseLocked(outwhProduce.getStockWarehouseLocked() - dispatchOrderList.getDispatchProduce().getActualNum());
			outwhProduce.preUpdate();
			whProduceDao.update(outwhProduce);
			
		}
		dispatchOrder.setDispatchMission(dispatchMission);
		dispatchOrder.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITCALLIN);
		List<DispatchOrder> dispatchOrders = dispatchOrderDao.findAllList(dispatchOrder);
		//查询子任务里面是否还有在派送中的数据，否就执行改变主任务的执行状态为已完成
		if(dispatchOrders.size() == 0){
			dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCAFOUR);
			dispatchMission.preUpdate();
			dao.update(dispatchMission);
		}
		
	}
	/**
	 * 修改任务单
	 * @param dispatchMission
	 */
	@Transactional(readOnly = false)
	public void Update(DispatchMission dispatchMission){
		dispatchMission.preUpdate();
		dao.update(dispatchMission);
		
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = false)
	public void save(DispatchMission dispatchMission) {
		/**
		 * 保存任务及总任务
		 */
		//调入责任人为仓库负责人
//		Warehouse inWarehouse = warehouseService.get(dispatchMission.getInWarehouse().getId());//调入仓库责任人
//		dispatchMission.setInUser(inWarehouse.getResponsibleUser());
		if (StringUtils.isBlank(dispatchMission.getId())) {//添加
			String codeString = barCodeService.createMmissionBarCode(dispatchMission, basMissionDao);//生成任务批次编码
			dispatchMission.setMissionCode(codeString);
			dispatchMission.setBatchNo(codeString);
//			dispatchMission.setBusinessId(DispatchMission.TYPE_DISPATCH);
//			dispatchMission.setApproveStatus(DispatchMission.APPROVESTATUS_WAIT);
			dispatchMission.setBusinessType(DispatchMission.TYPE_DISPATCH);
			User inUser = dispatchMission.getInUser();
			String inUserId = inUser.getId();
//			inUser.setId(inUserId.substring(inUserId.length()-2, inUserId.length()-1));//这一步是为了把逗号去掉，因为人员选择器返回的数据是以a,b,c这种格式的
			inUser.setId(inUserId);
			dispatchMission.setInUser(inUser);
			dispatchMission.preInsert();
			dispatchMission.setDelayCount(0);
			basMissionDao.insert(dispatchMission);
			dao.insert(dispatchMission);
		}else {//修改
			//调货任务状态为新建
			User inUser = dispatchMission.getInUser();
			String inUserId = inUser.getId();
			inUser.setId(inUserId);
			dispatchMission.setInUser(inUser);
			dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCONFIRMED);
			dispatchMission.preUpdate();
			dao.update(dispatchMission);
			basMissionDao.update(dispatchMission);
		}
		
		//处理同一个仓库调拨多种产品的情况，针对仓库来说，只有一个调货单，一个调货单对应多个调货产品记录
		List<DispatchOrder> doList = dispatchMission.getDispatchOrderList();
		Map<Warehouse, List<DispatchOrder>> maps = new HashMap<Warehouse, List<DispatchOrder>>();
		Set<String> warehouseKeys = new HashSet<String>();
		List<DispatchOrder> disOrderList = null;
		Warehouse wh = null;
		List<String> oids = Lists.newArrayList();
		for(DispatchOrder dor : doList) {
			oids.add(dor.getId());
			//过滤界面上已删除的仓库，（因为界面上不是按照从下往上删除的方式，导致传过来的集合下标不是连续的，这样取数有些问题）
			if(dor != null && dor.getOutWarehouse() != null && !StringUtils.isBlank(dor.getOutWarehouse().getId())) {
				String outwareHouseId = dor.getOutWarehouse().getId();
				if(!warehouseKeys.contains(outwareHouseId)) {
					warehouseKeys.add(outwareHouseId);
					disOrderList = new ArrayList<DispatchOrder>();
					disOrderList.add(dor);
					wh = warehouseDao.get(outwareHouseId);
					maps.put(wh, disOrderList);
				} else {
					List<DispatchOrder> oldDoList = maps.get(wh);
					oldDoList.add(dor);
				}
			}
		}
		
		//修改时候，需要删除该任务下面所有的调货单和调货产品记录
		dispatchOrderDao.removeDispatchOrderByMissionId(DispatchOrder.DEL_FLAG_DELETE, dispatchMission.getId());
		dispatchProduceDao.removeDispatchProduceByDispatchOrderId(DispatchProduce.DEL_FLAG_DELETE, oids);
		
		
		//组装完毕，一个仓库对应多条调货产品记录
		Set<Warehouse> whKeys = maps.keySet();
		//主要用于新建时，循环创建
		DispatchOrder doonly = null;
		DispatchProduce dispatchProduce = null;
		for(Warehouse whKey : whKeys) {//循环仓库，一个仓库只有一次调货只有一条调货记录，对应的调货产品允许有N个
			/**
			 * 新增：
			 * 循环仓库，循环一次，生成一条仓库对应的调货单
			 * 同时，将仓库对应的调货产品循环保存
			 * 更新：
			 * 主要更新的是调拨产品的数量
			 */
			List<DispatchOrder> dispatchOrderList = maps.get(whKey);
			doonly = dispatchOrderList.get(0);
			if(StringUtils.isBlank(doonly.getId())) {
				doonly.setDispatchMission(dispatchMission);
				doonly.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITCONFIRMED);
				doonly.setOutUser(whKey.getResponsibleUser());
				doonly.preInsert();
				dispatchOrderDao.insert(doonly);
				
				for(DispatchOrder o: dispatchOrderList) {
					dispatchProduce = new DispatchProduce();
					dispatchProduce.preInsert();
					dispatchProduce.setDispatchOrder(doonly);
					dispatchProduce.setProduce(o.getDispatchProduce().getProduce());
					dispatchProduce.setPlanNum(o.getDispatchProduce().getPlanNum());
					dispatchProduceDao.insert(dispatchProduce);
				}
		   } else {
			    for(DispatchOrder editDo : dispatchOrderList) {
			    	List<DispatchProduce> dproduceList = dispatchProduceDao.getOrderId(editDo.getId());
			    	for(DispatchProduce dp : dproduceList) {
			    		dp.preUpdate();
			    		dp.setPlanNum(editDo.getDispatchProduce().getPlanNum());
			    		dispatchProduceDao.update(dp);
			    	}
			    }
			}
		}
		
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = false)
	public void delete(DispatchMission dispatchMission) {
		basMissionDao.delete(dispatchMission);
		super.delete(dispatchMission);
	}
	
	//仓库管理者接受派单
	@Transactional(readOnly = false)
	public void saveReceiveDispatchMission(DispatchMission dispatchMission,String dispatchOrderId) {
		DispatchOrder dispatchOrder = dispatchOrderService.get(dispatchOrderId);
		//修改调货单状态为派送中
		dispatchOrder.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITCALLOUT);//设置状态已接受
		//同时，记录物流到达接受时间
//		dispatchOrder.setPostEndTime(new Date());
		dispatchOrderService.save(dispatchOrder);
	}
	
	//仓库管理者接受派单
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional(readOnly = false)
	public void sendDispatchMission(DispatchMission dispatchMission) {
		
		//TODO 货品状态调整 待定版  2016-09-26
		if(true) return;
		
		DispatchOrder dispatchOrder = dispatchMission.getDispatchOrder();
		DispatchOrder dorder = dispatchOrderService.getDispatchOrderWithGoodsDetail(dispatchOrder);
		
		dispatchMission.setMissionStatus(DispatchMission.MISSION_WAITCALLIN);
		dispatchMission.preUpdate();
		dao.update(dispatchMission);
		
		//更新父任务的实际要求完成时间
		BasMission basMission = basMissionDao.findByBarCode(dispatchMission.getBatchNo());
		if(basMission != null) {
			basMission.setEndTime(dispatchMission.getEndTime());
			basMissionDao.update(basMission);
		}
		
		//更新调货产品表调货数量
		for (DispatchProduce dispatchProduce : dorder.getDispatchProduceList()) {
			if(dispatchProduce.getActualNum() != null){
				
//				//先删除调货产品关联的货品数据，然后将最新的数据插入
//				dispatchProductDao.removeDispatchProductByDispatchProduceId(dispatchProduce.getId());
//				List<DispatchProduct> productList = dorder.getDispatchProductList();
//				if(productList.size() < 1) continue;
//				List<String> dptIDList = Lists.newArrayList();
//				for(DispatchProduct dpt : productList) {
//					dptIDList.add(dpt.getId());
//					Product pt = dpt.getProduct();
//					pt.setStatus(Product.STATUS_SELLING);//
//					pt.setWareplace(pt.getWareplace());
//					pt.setHoldUser(new User());
//					pt.preUpdate();
//					productDao.update(pt);//变更货品状态
//				}
//				//删除对应的货品出库记录，及货品状态变更记录
//				productStatusItemDao.removeProductStatusItemByBusinessId(dispatchProduce.getId());
				
				for(DispatchProduct dispatchProduct:dispatchProduce.getDispatchProductList()){
					Product product = productDao.get(dispatchProduct.getProduct().getId());
					
					/***  2016-09-26
					
					//判断该货品状态，是否是“上架”,"下架"可用状态，如果不是，给予提示，并回滚事务
					if(!Product.STATUS_UP.equals(product.getStatus()) && !Product.STATUS_DOWN.equals(product.getStatus())) 
						throw new ServiceException("您调拨的货品中，有一部分已经被他人抢先一步调拨走了，请重新选择调拨货品，^_^");
					
					**/
					
					//添加货品货位调整记录
					ProductWpChange productWpChange = new ProductWpChange();
					productWpChange.setProduct(product);
					productWpChange.setPreWareplace(product.getWareplace());
					//派送的时候，需要将货品的持有位置变更为派送的快递员持有
//					productWpChange.setPostWareplace(product.getWareplace());
					productWpChange.setPostHoldUser(dorder.getPostUserId());
					productWpChange.preInsert();
					productWpChangeDao.insert(productWpChange);
					
					//修改货品状态
					product.setStatus(Product.STATUS_LOCKED);
					product.setWareplace(new Wareplace());
					product.setHoldUser(UserUtils.getUser());
					product.preUpdate();
					productDao.updateSingle(product);
					
				}
			}
		}
		
		//修改调货单状态为派送中
		dispatchOrder.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITCALLIN);//设置状态已接受
		dispatchOrder.setPostStartTime(new Date());
		dispatchOrderService.save(dispatchOrder);
	}
	
	/**
	 * 调入方，确认收货，同时生成对应的质检信息待质检
	 * @param dispatchMission
	 */
	@Transactional(readOnly = false)
	public void saveCallIn(DispatchMission dispatchMission) {
		Date opDate = new Date();
		
		//更新调货单DispatchOrder里面的送货结束时间，同时更新送货状态missionStatus为已收货，待质检
		DispatchOrder dorder = dispatchMission.getDispatchOrder();
		dorder.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITQC);
		dorder.setPostEndTime(opDate);
		dorder.preUpdate();
		dispatchOrderDao.update(dorder);
		
		//同时生成质检单和质检明细信息
		QualitycheckOrder qco = new QualitycheckOrder();
		qco.setQcBusinessType(QualitycheckOrder.QCBUSINESSTYPE_IN);//交货质检
		qco.setQcBusinessId(dorder.getId());
		qco.setQcStatus(QualitycheckOrder.QCSTATUS_WAIT);//待质检
		qco.setWeighFlag("1");
		qco.setSurfacecheckFlag("1");
		qco.setCodecheckFlag("1");
		qco.setDelFlag(QualitycheckOrder.DEL_FLAG_NORMAL);
		qco.setQcUser(dorder.getQcUser());
		qco.setRemarks("入库方确认到货时，自动生成质检单信息");
		qco.preInsert();
		qualitycheckOrderDao.insert(qco);
		
		//生成对应的质检单明细信息
		DispatchMission mission = this.getMissonWithProduceAndProductById(dispatchMission);
		if(mission == null || mission.getDispatchProductList() == null) return;
		QualitycheckDetail qcd = null;
		
		for(DispatchProduct dp : mission.getDispatchProductList()) {
			qcd = new QualitycheckDetail();
			Product product = dp.getProduct();
			qcd.setQualitycheckOrder(qco);
			qcd.setProduct(dp.getProduct());//对应货品ID
			qcd.setDelFlag(QualitycheckDetail.DEL_FLAG_NORMAL);
			qcd.preInsert();
			qcd.setRemarks("入库方确认到货时，自动生成质检单明细");
			BigDecimal bd = product.getWeight();
			
			qcd.setWeightOriginal(bd != null ? bd.floatValue() : null);
			qcd.setCodeOriginal(product.getCode());
			qualitycheckDetailDao.insert(qcd);
			
			dp.setProductCheckOrder(qco);
			dp.preUpdate();
			dispatchProductDao.update(dp);
		}
	}

	/**
	 * 调入方，入库成功，同时调货单状态变更为已完成
	 * 入库需要选择仓库，货架，货位的，同时变更货品持有人，同时状态变更为已完成
	 * @param dispatchMission
	 */
	@Transactional(readOnly = false)
	public void saveProductStock(DispatchMission dispatchMission) {
		
		//TODO 货品状态调整 待定版  2016-09-26
		if(true) return;
		
		DispatchOrder dorder = dispatchMission.getDispatchOrder();
		
		dorder.setOrderStatus(DispatchOrder.ORDERSTATUS_COMPLETE);
		dorder.preUpdate();
		dispatchOrderDao.update(dorder);		
		
		List<DispatchProduce> disProduceList = dorder.getDispatchProduceList();
		for(DispatchProduce dispatchProduce : disProduceList) {
			List<DispatchProduct> dispatchProductList = dispatchProduce.getDispatchProductList();
			Product product = null;
			for(DispatchProduct dp : dispatchProductList) {
				//调货货品表记录的状态需要变更成调货完成
				product = dp.getProduct();
				
				//货品一定是关联产品的，切记
				product.setProduce(dispatchProduce.getProduce());
				
				//界面上传过来的新的货位值
				/*Warehouse whIn = warehouseDao.findWareHouseByWareplaceId(product.getWareplace().getId());
				System.out.println("入仓库名称："+whIn.getName());
				//a.从数据库中查询的，货品原来的货位
				Product oldProduct = productDao.get(product.getId());
				Warehouse whOut = warehouseDao.findWareHouseByWareplaceId(oldProduct.getWareplace().getId());
				System.out.println("出仓库名称："+whOut.getName());*/
				
				//操作库存
				//货品入库出入库记录
				
				//出库操作----添加货品出库记录
				ProductWpIo productWpIoOut = new ProductWpIo();
				//出库记录时，派送人归属到调出仓库负责人上面去。
				Product oldProduct = productDao.get(product.getId());
				productWpIoOut.setIoWareplace(oldProduct.getWareplace());
				//b.记录货品的持有人，变成派送人
				productWpIoOut.setIoUser(dorder.getOutUser());
				productWpIoOut.setProduct(oldProduct);
				productWpIoOut.setIoType(ProductWpIo.IOTYPE_OUT);
				productWpIoOut.setIoTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
				productWpIoOut.setIoReasonType(ProductWpIo.IOREASIONTYPE_OUT_DISPATCH);
				productWpIoOut.preInsert();
				productWpIoDao.insert(productWpIoOut);
				productWpIoService.productOutSave(productWpIoOut);
				
				//货品入库，添加货品入库记录
				//货品入库需要添加一条货品入库记录,备注：需要生成来源业务编号
				ProductWpIo productWpIoIn = new ProductWpIo();
				productWpIoIn.setProduct(product);
				productWpIoIn.setIoType(ProductWpIo.IOTYPE_IN);
				productWpIoIn.setIoWareplace(product.getWareplace());
				productWpIoIn.setIoUser(UserUtils.getUser());
				productWpIoIn.setIoTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
				productWpIoIn.setIoReasonType(ProductWpIo.IOREASIONTYPE_IN_DISPATCH);
				productWpIoIn.preInsert();
				productWpIoDao.insert(productWpIoIn);
				productWpIoService.productInSave(productWpIoIn);
				
				//1.这里会变更货品的货位，信息来源页面选择的货位
				/*product.preUpdate();
				productDao.updateSingle(product);*/
				
				//添加货品货位调整记录
				ProductWpChange productWpChange = new ProductWpChange();
				productWpChange.setProduct(product);
//				productWpChange.setPreWareplace(product.getWareplace());
				productWpChange.setPreHoldUser(dorder.getPostUserId());
				//派送的时候，需要将货品的持有位置变更为目标仓库的具体货位
				productWpChange.setPostWareplace(product.getWareplace());
				productWpChange.preInsert();
				productWpChangeDao.insert(productWpChange);
				
				//修改货品状态
				
				/** 2016-09-26
				product.setStatus(Product.STATUS_UP);
				**/
				
				product.setWareplace(new Wareplace());
				product.setHoldUser(UserUtils.getUser());
				product.preUpdate();
				productDao.updateSingle(product);
				
				dp.setStatus(DispatchProduct.STATUS_END);
				dp.preUpdate();
				dp.setInWareplace(product.getWareplace());
				dp.setProductWpIoIn(productWpIoIn);
				dispatchProductDao.update(dp);
				
			}
		}
		
		//如果该调货任务的所有调货单都已是完成状态，需要把父任务的状态变更为完成
		int c = dispatchOrderService.getCompleteDispatchOrderByMissionId(dispatchMission.getId());
		if(c == 0) {
			DispatchMission dm = dao.get(dispatchMission.getId());
			if(dm != null) {
				dm.setMissionStatus(DispatchMission.MISSION_WAITCAFOUR);
				dm.preUpdate();
				dao.update(dm);
			}
		}
		
		
	}
	
	/**
	 * 根据调货单任务ID获取当前登录者需要入库的货品信息数据
	 * @param dispatchMission
	 * @return
	 */
	public DispatchMission findMissionWithProductAndProduceBySearchParam(DispatchMission dispatchMission) {
		return dao.findMissionWithProductAndProduceBySearchParam(dispatchMission);
	}
	
	public DispatchMission getDispatchMissionWithDetailAll(DispatchMission dispatchMission) {
		return dao.getDispatchMissionWithDetailAll(dispatchMission);
	}
}