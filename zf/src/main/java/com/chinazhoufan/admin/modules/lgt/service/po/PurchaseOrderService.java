/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.po;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceOrderDao;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceProduceDao;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.crm.service.ns.NotifyService;
import com.chinazhoufan.admin.modules.crm.service.ns.SubscribeService;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseMissionDao;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseOrderDao;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMission;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warearea;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.lgt.entity.si.CreditPointDetail;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;
import com.chinazhoufan.admin.modules.lgt.service.si.CreditPointDetailService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierProduceService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 采购单Service
 * @author 张金俊
 * @version 2015-10-16
 */
@Service
@Transactional(readOnly = true)
public class PurchaseOrderService extends CrudService<PurchaseOrderDao, PurchaseOrder> {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private PurchaseOrderDao purchaseOrderDao;
	@Autowired
	private PurchaseProduceDao purchaseProduceDao;
	@Autowired
	private PurchaseProduceService purchaseProduceService;
	@Autowired
	private PurchaseProductDao purchaseProductDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ProductWpIoService productWpIoService;
	@Autowired
	private PurchaseMissionDao purchaseMissionDao;
	@Autowired
	private SupplierProduceDao supplierProduceDao;
	@Autowired
	private SupplierProduceService supplierProduceService;
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private CreditPointDetailService creditPointDetailService;
	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private WareplaceService wareplaceService;
	@Autowired
	private ScanCodeService scanCodeService;

	@Autowired
	private ExperienceOrderDao experienceOrderDao;

	@Autowired
	private ExperienceProduceDao experienceProduceDao;

	@Autowired
	private SubscribeService subscribeService;
	@Autowired
	private NotifyService notifyService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberNotifyService memberNotifyService;
	
	public PurchaseOrder get(String id) {
		PurchaseOrder purchaseOrder = super.get(id);
		purchaseOrder.setPurchaseProduceList(purchaseProduceDao.findList(new PurchaseProduce(purchaseOrder)));
		return purchaseOrder;
	}
	
	/**
	 * 查询采购订单以及包含的采购产品
	 * @return
	 */
	public PurchaseOrder getWithPurchaseProduces(String id) {
		PurchaseOrder purchaseCurr = purchaseOrderDao.getWithPurchaseProduces(id);
		List<PurchaseProduce> list = purchaseCurr.getPurchaseProduceList();
		
		if(list != null && list.size() > 0) {
			List<SupplierProduce> spList = supplierProduceDao.listSupplierProduceBySupplier(purchaseCurr.getSupplier().getId());
			if(spList != null && spList.size() > 0) {
				for(PurchaseProduce pp : list) {
					for(SupplierProduce sp : spList) {
						if(pp.getProduce().getId().equals(sp.getProduce().getId())) {
							if(pp.getGoldPrice() == null) {
								pp.setGoldPrice(sp.getGoldPrice());
							}
							if(pp.getLossFee() == null) {
								pp.setLossFee(sp.getLossFee());
							}
							/*if(pp.getGoldWeight() == null) {
								pp.setGoldWeight(sp.getGoldWeight());
							}*/
							if(pp.getMainStoneWeight() == null) {
								pp.setMainStoneWeight(sp.getMainStoneWeight());
							}
							if(pp.getMainStonePrice() == null) {
								pp.setMainStonePrice(sp.getMainStonePrice());
							}
							if(pp.getSubsidiaryStoneWeight() == null) {
								pp.setSubsidiaryStoneWeight(sp.getSubsidiaryStoneWeight());
							}
							if(pp.getSubsidiaryStonePrice() == null) {
								pp.setSubsidiaryStonePrice(sp.getSubsidiaryStonePrice());
							}
							if(pp.getWorkFee() == null) {
								pp.setWorkFee(sp.getWorkFee());
							}
							if(pp.getInlayFee() == null) {
								pp.setInlayFee(sp.getInlayFee());
							}
							if(pp.getInlayNum() == null) {
								pp.setInlayNum(sp.getInlayNum());
							}
							if(pp.getTempletFee() == null) {
								pp.setTempletFee(sp.getTempletFee());
							}
							
							if(pp.getElectrolyticGoldColour() == null) {
								pp.setElectrolyticGoldColour(sp.getElectrolyticGoldColour());
							}
							
							if(pp.getElectrolyticGoldCrafts() == null) {
								pp.setElectrolyticGoldCrafts(sp.getElectrolyticGoldCrafts());
							}
							
							if(pp.getElectrolyticGoldPrice() == null) {
								pp.setElectrolyticGoldPrice(sp.getElectrolyticGoldPrice());
							}
							
							if(pp.getElectrolyticGoldThickness() == null) {
								pp.setElectrolyticGoldThickness(sp.getElectrolyticGoldThickness());
							}
							
						}
					}
				}
			}
		}
		return purchaseCurr;
	}
	
	/**
	 * 查询采购订单以及包含的采购产品、采购货品信息
	 * @return
	 */
	public PurchaseOrder getWithPurchaseProducesAndPurchaseProducts(String id) {
		PurchaseOrder purchaseCurr = purchaseOrderDao.getWithPurchaseProducesAndPurchaseProducts(id);
		if(purchaseCurr != null) {
			List<PurchaseProduce> list = purchaseCurr.getPurchaseProduceList();
			
			if(list != null && list.size() > 0) {
				List<SupplierProduce> spList = supplierProduceDao.listSupplierProduceBySupplier(purchaseCurr.getSupplier().getId());
				if(spList != null && spList.size() > 0) {
					for(PurchaseProduce pp : list) {
						for(SupplierProduce sp : spList) {
							if(pp.getProduce().getId().equals(sp.getProduce().getId())) {
								if(pp.getGoldPrice() == null) {
									pp.setGoldPrice(sp.getGoldPrice());
								}
								if(pp.getLossFee() == null) {
									pp.setLossFee(sp.getLossFee());
								}
								/*if(pp.getGoldWeight() == null) {
									pp.setGoldWeight(sp.getGoldWeight());
								}*/
								if(pp.getMainStoneWeight() == null) {
									pp.setMainStoneWeight(sp.getMainStoneWeight());
								}
								if(pp.getMainStonePrice() == null) {
									pp.setMainStonePrice(sp.getMainStonePrice());
								}
								if(pp.getSubsidiaryStoneWeight() == null) {
									pp.setSubsidiaryStoneWeight(sp.getSubsidiaryStoneWeight());
								}
								if(pp.getSubsidiaryStonePrice() == null) {
									pp.setSubsidiaryStonePrice(sp.getSubsidiaryStonePrice());
								}
								if(pp.getWorkFee() == null) {
									pp.setWorkFee(sp.getWorkFee());
								}
								if(pp.getInlayFee() == null) {
									pp.setInlayFee(sp.getInlayFee());
								}
								if(pp.getInlayNum() == null) {
									pp.setInlayNum(sp.getInlayNum());
								}
								if(pp.getTempletFee() == null) {
									pp.setTempletFee(sp.getTempletFee());
								}
								
								if(pp.getElectrolyticGoldColour() == null) {
									pp.setElectrolyticGoldColour(sp.getElectrolyticGoldColour());
								}
								
								if(pp.getElectrolyticGoldCrafts() == null) {
									pp.setElectrolyticGoldCrafts(sp.getElectrolyticGoldCrafts());
								}
								
								if(pp.getElectrolyticGoldPrice() == null) {
									pp.setElectrolyticGoldPrice(sp.getElectrolyticGoldPrice());
								}
								
								if(pp.getElectrolyticGoldThickness() == null) {
									pp.setElectrolyticGoldThickness(sp.getElectrolyticGoldThickness());
								}
							}
						}
					}
				}
			}
			return purchaseCurr;
		}
		return new PurchaseOrder();
	}
	
	public List<PurchaseOrder> findList(PurchaseOrder purchase) {
		return super.findList(purchase);
	}
	
	public Page<PurchaseOrder> findPage(Page<PurchaseOrder> page, PurchaseOrder purchase) {
		return super.findPage(page, purchase);
	}
	
	/**
	 * 保存采购单
	 */
	@Transactional(readOnly = false)
	public void save(PurchaseOrder purchaseOrder) {
		super.save(purchaseOrder);
	}
	
	
	/**
	 * （采购订单执行）仅针对货品
	 * 改版后， 采购订单、采购产品信息补全，采购货品信息录入
	 * @param purchaseOrderParam
	 * @throws IOException 
	 */
	@Transactional(readOnly = false)
	public void saveForm(PurchaseOrder purchaseOrderParam) throws IOException {
		
		Integer inBatchNo = geneInBatchNo(purchaseOrderParam.getId());
		//采购产品id集合
		List<String> ids =  Lists.newArrayList();
		// 更新采购产品（实际采购数量、实际采购价格）
		List<PurchaseProduce> purchaseProduceList = purchaseOrderParam.getPurchaseProduceList();
		
		// 更新采购货品（1.删除采购产品下原所有采购货品记录  2.新增采购货品记录）
		for(PurchaseProduce purchaseProduceTemp : purchaseProduceList){
			if(purchaseOrderParam.getPurchaseProduceList().size() > 0){
				//需要更新的采购产品
				ids.add(purchaseProduceTemp.getProduce().getId());
			}
			// 新增采购货品记录（暂只新增采购货品记录，待采购单完成时，创建对应货品并将货品Id保存至对应采购货品记录）
			List<PurchaseProduct> purchaseProductList = purchaseProduceTemp.getPurchaseProductList();
			
			int inNum = 0;
			int backNum = 0;
			
			for(PurchaseProduct purchaseProduct : purchaseProductList){
				// 给货品赋货位信息
				
				// 设置货品出入库记录
				ProductWpIo productWpIo = new ProductWpIo();
				
				if(PurchaseProduct.TRUE_FLAG.equals(purchaseProduct.getRegularFlag())) {//统计合格与不合格数
					inNum++;
					productWpIo.setInStatus(ProductWpIo.INSTATUS_NORMAL);//合格的，货品状态为正常
					productWpIo.setInType(Warearea.TYPE_NORMAL);
				} else {
					backNum++;
					productWpIo.setInStatus(ProductWpIo.INSTATUS_LOCKED);//不合格的，货品状态为锁定
					productWpIo.setInType(Warearea.TYPE_BROKEN);
				}
				
				purchaseProduct.setPurchaseProduce(purchaseProduceTemp);
				
				//设置入库批次编号
				purchaseProduct.setInBatchNo(inBatchNo);
				
				BigDecimal pricePurchase = purchaseProduceTemp.getProduce().getPricePurchase();
				//货品先入库
				// 设置要入库的货品
				Product product = new Product();
				product.setProduce(purchaseProduceTemp.getProduce());
				product.setWeight(purchaseProduct.getWeight());
				product.setFactoryCode(purchaseProduct.getFactoryCode());
				product.setCertificateNo(purchaseProduct.getCertificateNo());
				product.setScanCode(purchaseProduct.getScanCode());
				product.setWareplace(purchaseProduct.getWareplace());
				product.setSupplier(purchaseOrderParam.getSupplier());
				product.setPricePurchase(pricePurchase);
				product.setUpdateStatus(Product.STATUS_UPDATE_YES);
				product.setRemarks(purchaseProduct.getRemarks());
				productWpIo.setProduct(product);
				productWpIo.setIoType(ProductWpIo.IOTYPE_IN);
				//货品所属供应商
				productWpIo.setSupplier(purchaseOrderParam.getSupplier());
				
				// 设置入库类型为“采购入库”
				productWpIo.setIoReasonType(ProductWpIo.IOREASIONTYPE_IN_PURCHASE);
				productWpIo.setIoUser(UserUtils.getUser());
				productWpIo.setIoTime(new Date());
				productWpIo.setIoBusinessorderId(purchaseOrderParam.getOrderNo());
				// 货品入库代码已调整，已去掉入库时更新“预约单”的“预约到货状态”的操作
				productWpIo = productWpIoService.productInSave(productWpIo);
				
				purchaseProduct.setProduct(productWpIo.getProduct());
				purchaseProduct.setScanCode(productWpIo.getProduct().getScanCode());
				purchaseProduct.setWareplace(productWpIo.getIoWareplace());
				purchaseProduct.setEnterPerson(UserUtils.getUser().getId());
				purchaseProduct.setEnterTime(new Date());
				purchaseProduct.preInsert();
				purchaseProductDao.insert(purchaseProduct);
				
			}
			//录入合格数，总量=合格数+产品那边录入的不合格数
			purchaseProduceTemp.setInNum(inNum);
			purchaseProduceTemp.setBackNum(backNum);
			purchaseProduceTemp.setRealityNum(inNum+backNum);
			purchaseProduceService.updatePurchaseProduceRealtyNum(purchaseProduceTemp);
		}
		
		/**所有货品入库完成，执行预约订单的到货操作
		 * 1.扫描采购产品关联的预约订单，对满足条件的预约订单执行到货操作（同时更新预约单下相关产品的库存信息）
		 * 2.调用信息接口，发送预约单到货通知，通知用户付尾款
		 */
		//检查本批次正常入库的关联预约单的产品库存
		Map<String, Object> whPromap = getWhPromap(ids);

		//获取所有本批次采购产品关联的预约订单（按支付时间排序，升序）
		List<ExperienceOrder> experienceOrderList = this.findListByIds(ids);

		List<ExperienceProduce> experienceProduces = Lists.newArrayList();//记录需要更新库存的体验产品
		Boolean isBreak = false;
		Boolean isNum = false;
		for(ExperienceOrder experienceOrder : experienceOrderList){
			List<ExperienceProduce> proList = experienceProduceDao.getByExperienceOrder(experienceOrder.getId());
			if(proList != null){
				experienceOrder.setEpList(proList);
				//校验用户体验多种产品
				if(proList.size()>0){

					isNum=checkWhProduce(proList,whPromap,isBreak,isNum,experienceProduces);
					//库存数量满足体验数量
					if(isNum){
						//更新库存
						updateWhProduceStock(whPromap,experienceProduces);
						//更新体验单
						updateExperienceOrder(experienceOrder);
						//调用信息接口，发送预约单到货通知，通知用户付尾款
						Member m = memberService.get(experienceOrder.getMember());
						try {
							memberNotifyService.createByNotifyCode(Notify.MSG_APPOINTORDER_GET_STOCK, m, experienceOrder.getOrderNo());
						} catch (ServiceException e) {
							throw new ServiceException(e.getMessage());
						}
					}
				}
			}
		}
		/**
		 * 
		 * 执行预约订单的到货操作之后，根据正常库存剩余数量，判断是否执行到货提醒（更新相关订阅表的状态为 “待提醒”）
		 */
//		List<WhProduce> whProduceList =whProduceService.findListByProduceIdArr(null,ids);
//		for(WhProduce whProduce :whProduceList){
//			if(whProduce.getStockNormal() > 0){
//				subscribeService.updateWhenPurchaseFinish(whProduce.getProduce());
//			}
//		}
	}
	/**
	 * 获取本批次正常入库的关联预约单的产品库存
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> getWhPromap(List<String> ids){
		Map<String, Object> whPromap = Maps.newHashMap();
		List<WhProduce> whProduceList =whProduceService.findListByProduceIdArr(null,ids);
		if(whProduceList != null && whProduceList.size()>0 ){
			for(WhProduce produce:whProduceList){
				whPromap.put(produce.getProduce().getId(),produce);
			}
		}
		return whPromap;
	}
	/**
	 * 获取所有本批次采购产品关联的预约订单（按支付时间排序，升序）
	 */
	@Transactional(readOnly = false)
	public List<ExperienceOrder> findListByIds(List<String> ids){
		Map<String, Object> map = Maps.newHashMap();
		map.put("ids", ids);
		map.put("statusPay", ExperienceOrder.STATUSPAY_TOPAY_FINAL);//过滤支付状态
		map.put("type", ExperienceOrder.TYPE_APPOINTEXPERIENCE);//过滤不是预约体验的类型
		//map.put("appointStockStatus", ExperienceOrder.APPOINTSTOCKSTATUS_DOING);//过滤不是采购中的体验单

		List<ExperienceOrder> experienceOrderList = experienceOrderDao.findListByProduceIds(map);
		return experienceOrderList;
	}
	/**
	 * 校验产品库存和体验单是否满足更新条件
	 */
	public  Boolean checkWhProduce(List<ExperienceProduce> proList,Map<String, Object> whPromap,Boolean isBreak,Boolean isNum,List<ExperienceProduce> experienceProduces){
		for(ExperienceProduce pro:proList){
			if(whPromap.get(pro.getProduce().getId()) == null){
				//不满足体验单对应用户体验了多种产品，跳出循环
				isBreak =true;
				break;
			}
			if(!isBreak){
				//正常库存都在该用户体验的多种产品，检验产品数量是否满足
				WhProduce whPro  =(WhProduce)whPromap.get(pro.getProduce().getId());
				if(whPro.getStockNormal()<pro.getNum()){
					isNum = false;
					break;
				}
				isNum = true;
				experienceProduces.add(pro);
			}
		}
		return isNum;
	}
	/**
	 * 库存数量满足体验数量,更新库存
	 */
	@Transactional(readOnly = false)
	public Boolean updateWhProduceStock(Map<String, Object> whPromap,List<ExperienceProduce> experienceProduces){
		if(experienceProduces.size()>0){
			for(ExperienceProduce pro:experienceProduces){
				WhProduce whPro = (WhProduce)whPromap.get(pro.getProduce().getId());
				whProduceService.updateWhProduceStock(whPro.getWarehouse().getId(),whPro.getProduce().getId(),"D",pro.getNum(),"A",pro.getNum(), "D", pro.getNum());
			}
		}
		return true;
	}
	/**
	 * 库存数量满足体验数量,更新体验单
	 */
	@Transactional(readOnly = false)
	public void  updateExperienceOrder(ExperienceOrder experienceOrder){
		//更新体验单
		if(ExperienceOrder.STATUSPAY_TOPAY_FINAL.equals(experienceOrder.getStatusPay())){
			experienceOrder.setAppointStockStatus(ExperienceOrder.APPOINTSTOCKSTATUS_FINISH);
			experienceOrderDao.update(experienceOrder);
		}else{
			//不正常体验单
		}
	}

	@Transactional(readOnly = false)
	public Integer geneInBatchNo(String purchaseOrderId){
		Integer startCode = 1;
		String lastScanCode = purchaseProductDao.getLatestInBatchNo(purchaseOrderId);
		if(lastScanCode != null){
			startCode = Integer.valueOf(lastScanCode) + 1;
		}
		return startCode;
	}
	
	
	
	/**
	 * （采购订单执行）
	 * 采购单完成（更新采购单信息、新增货品数据<货品入库>、更新采购货品信息<关联到货品记录>）
	 * @param purchaseOrderParam
	 */
	@Transactional(readOnly = false)
	public void finish(PurchaseOrder purchaseOrderParam) throws Exception{
		// 更新采购任务状态
		PurchaseMission purchaseMission = purchaseOrderParam.getPurchaseMission();
		Integer unfinishOrderCount = purchaseOrderDao.findUnfinishOrderCount(purchaseMission.getId(), purchaseOrderParam.getId(), PurchaseOrder.ORDERSTATUS_FINISHED);
		if(unfinishOrderCount == 0){
			// 该采购单对应的任务没有其他未完成采购单，更新任务为完成状态
			purchaseMission.setMissionStatus(PurchaseMission.MISSIONSTATUS_FINISH);
			purchaseMission.preUpdate();
			purchaseMissionDao.updateMissionStatus(purchaseMission);
		}
		
		// 更新采购单状态、实际完成时间
		purchaseOrderParam.setOrderStatus(PurchaseOrder.ORDERSTATUS_FINISHED);
//		purchaseOrderParam.setFinishTime(new Date());//采购单实际完成时间改成在采购产品表单人工录入
		purchaseOrderParam.preUpdate();
		
		
		// 创建货品
		int inTotalNum = 0;
		int totalNum = 0;
		
		// 采购单应付采购金额
		BigDecimal countPayableAmount = new BigDecimal("0");
		
		for(PurchaseProduce purchaseProduce : purchaseOrderParam.getPurchaseProduceList()){
			for(PurchaseProduct purchaseProduct : purchaseProduce.getPurchaseProductList()){
				if(purchaseProduct.getWareplace() == null )//预防界面上传过来的参数有空货品值
					continue;
				// 设置要入库的货品
				Product product = new Product();
				product.setProduce(purchaseProduce.getProduce());
				product.setWeight(purchaseProduct.getWeight());
				product.setFactoryCode(purchaseProduct.getFactoryCode());
				product.setCertificateNo(purchaseProduct.getCertificateNo());
				// 设置货品出入库记录
				ProductWpIo productWpIo = new ProductWpIo();
				productWpIo.setProduct(product);
				productWpIo.setIoType(ProductWpIo.IOTYPE_IN);
				productWpIo.setIoReasonType(ProductWpIo.IOREASIONTYPE_IN_PURCHASE);
				productWpIo.setIoWareplace(purchaseProduct.getWareplace());
				if(PurchaseProduct.TRUE_FLAG.equals(purchaseProduct.getRegularFlag())){
					productWpIo.setInType(ProductWpIo.INTYPE_NORMAL);					
					productWpIo.setInStatus(ProductWpIo.INSTATUS_NORMAL);
				}else {
					productWpIo.setInType(ProductWpIo.INTYPE_BROKEN_PURCHASE);
					productWpIo.setInStatus(ProductWpIo.INSTATUS_LOCKED);
				}
				productWpIo.setIoUser(UserUtils.getUser());
				productWpIo.setIoTime(new Date());
				productWpIo.setIoBusinessorderId(purchaseOrderParam.getOrderNo());
				productWpIo.setSupplier(purchaseOrderParam.getSupplier());
				productWpIo = productWpIoService.productInSave(productWpIo);
				
				// 更新采购货品记录
				purchaseProduct.setProduct(productWpIo.getProduct());
				purchaseProduct.preUpdate();
				purchaseProductDao.update(purchaseProduct);
				
				// 根据采购货品价格，设置总的应付采购金额
				countPayableAmount = countPayableAmount.add(purchaseProduct.getPricePurchase());
			}
			inTotalNum += purchaseProduce.getInNum();
			totalNum += purchaseProduce.getRealityNum();
			
//			//计算实付价格
//			countPayableAmount = countPayableAmount.add(purchaseProduce.getRealityPrice().multiply(new BigDecimal(purchaseProduce.getRealityNum())));
			
		}
		
		purchaseOrderParam.setPayableAmount(countPayableAmount);
		dao.update(purchaseOrderParam);
		
		//增减供应商信誉分
		//1.采购订单  所有合格数/实际采购总数 = 合格率，当合格率 < 业务参数配置项，扣减, 当合格率 >= 业务参数配置项，增加
		BigDecimal c1 = new BigDecimal(inTotalNum);
        BigDecimal c2 = new BigDecimal(totalNum);
        BigDecimal qualifiedScale = c1.divide(c2, 2, BigDecimal.ROUND_HALF_UP);
		
        //读取供应商信誉合格率， 信誉积分扣减值字典项
        /*
           supplierStandardQualifiedScale 供应商标准合格率
		   supplierReturnOntimeAddPoint 供应商按时回货增加信誉分
		   supplierReturnLaterDecPoint 供应商延迟回货扣减信誉分

		   supplierQualifiedHighAddPoint 供应商合格率达标增加信誉分
		   supplierQualifiedLowDecPoint 供应商合格率过低扣减信誉分 
         */
        
        Supplier supplier = supplierService.get(purchaseOrderParam.getSupplier());
        
        //生成供应商信誉积分流水记录
      	CreditPointDetail cpd = new CreditPointDetail();
        cpd.setSupplier(supplier);
        cpd.setChangeTime(new Date());
        cpd.setOperaterType(CreditPointDetail.OPERATER_TYPE_SYS);
        cpd.setOperateSourceNo(purchaseOrderParam.getOrderNo());//采购单ID
      	
        
        Config standardQualifiedScale = ConfigUtils.getConfig("supplierStandardQualifiedScale");
        BigDecimal standQScale = new BigDecimal(standardQualifiedScale.getConfigValue());
        
        Config qualifiedHighAddPoint = ConfigUtils.getConfig("supplierQualifiedHighAddPoint");
        Config qualifiedLowDecPoint = ConfigUtils.getConfig("supplierQualifiedLowDecPoint");
        
        if(qualifiedScale.compareTo(standQScale) <= -1) { //A.compareTo(B) < -1 ,说明A比B小， 扣减
        	int decreaseNum = Integer.valueOf(qualifiedLowDecPoint.getConfigValue());
        	supplier.setCreditPoint(supplier.getCreditPoint() - decreaseNum);
        	
        	cpd.setChangeType(CreditPointDetail.CHANGE_TYPE_DECREASE);
            cpd.setChangeCreditPoint(decreaseNum);
            cpd.setLastCreditPoint(supplier.getCreditPoint());
            cpd.setChangeReasonType(CreditPointDetail.CRT_SUPPLIER_UNQUALIFIED);
            //保存供应商信誉积分变更流水
    		creditPointDetailService.save(cpd);
        	
        } else {
        	int addNum = Integer.valueOf(qualifiedHighAddPoint.getConfigValue());
        	
        	supplier.setCreditPoint(supplier.getCreditPoint() + addNum);
        	
        	cpd.setChangeType(CreditPointDetail.CHANGE_TYPE_ADD);
            cpd.setChangeCreditPoint(addNum);
            cpd.setLastCreditPoint(supplier.getCreditPoint());
            cpd.setChangeReasonType(CreditPointDetail.CRT_SUPPLIER_QUALIFIED);
            
            //保存供应商信誉积分变更流水
    		creditPointDetailService.save(cpd);
        }
        
        Config returnOnTimeAddPoint = ConfigUtils.getConfig("supplierReturnOntimeAddPoint");
        Config returnLaterDecPoint = ConfigUtils.getConfig("supplierReturnLaterDecPoint");
        
        cpd.setId("");
		//2.实际完成实际 < 要求完成时间 ，增加，实际完成时间 > 要求完成时间，扣减
		if(purchaseOrderParam.getFinishTime() != null 
				&& purchaseOrderParam.getRequiredTime() != null
				&& purchaseOrderParam.getFinishTime().getTime() <=  purchaseOrderParam.getRequiredTime().getTime()) {
			//增加
			int addNum = Integer.valueOf(returnLaterDecPoint.getConfigValue());
			
			supplier.setCreditPoint(supplier.getCreditPoint() + addNum);
			
			cpd.setChangeType(CreditPointDetail.CHANGE_TYPE_ADD);
            cpd.setChangeCreditPoint(addNum);
            cpd.setLastCreditPoint(supplier.getCreditPoint());
            cpd.setChangeReasonType(CreditPointDetail.CRT_SUPPLIER_ONTIME);
            
            //保存供应商信誉积分变更流水
    		creditPointDetailService.save(cpd);
	        
		} else {
			//扣减
			int descreseNum = Integer.valueOf(returnOnTimeAddPoint.getConfigValue());
			
			supplier.setCreditPoint(supplier.getCreditPoint() - descreseNum);
			
			cpd.setChangeType(CreditPointDetail.CHANGE_TYPE_DECREASE);
            cpd.setChangeCreditPoint(descreseNum);
            cpd.setLastCreditPoint(supplier.getCreditPoint());
            cpd.setChangeReasonType(CreditPointDetail.CRT_SUPPLIER_LATER);
            
            //保存供应商信誉积分变更流水
    		creditPointDetailService.save(cpd);
		}
		
		//更新供应商的合格率
		supplier.setQualifiedScale(qualifiedScale);
		supplierService.save(supplier);
	}
	
	@Transactional(readOnly = false)
	public void delete(PurchaseOrder purchaseOrder) {
		dao.remove(purchaseOrder);
		purchaseProduceDao.removeByPurchaseOrder(purchaseOrder.getId());
	}

	
	public Page<PurchaseOrder> listPurchaseOrderForSupplier(Page<PurchaseOrder> page, PurchaseOrder purchaseOrder, String sysUserId) {
		List<PurchaseOrder> list = purchaseOrderDao.listPurchaseOrderForSupplier(page, purchaseOrder, sysUserId);
		purchaseOrder.setPage(page);
		page.setList(list);
		return page;
	}
	
	
	/**
	 * 保存审批结果
	 * @throws
	 */
	@Transactional(readOnly = false)
	public void saveCheckResult(PurchaseOrder purchaseOrder) {
		if("1".equals(purchaseOrder.getOrderStatus())) {//审批通过
			purchaseOrder.setOrderStatus(PurchaseOrder.ORDERSTATUS_SUBMITED);//已发布
		} else if("0".equals(purchaseOrder.getOrderStatus())) {//审批拒绝
			purchaseOrder.setOrderStatus(PurchaseOrder.ORDERSTATUS_CLOSE);//关闭
		}
		purchaseOrder.preUpdate();
		purchaseOrder.setCheckBy(UserUtils.getUser());
		purchaseOrder.setCheckTime(new Date());
		dao.saveCheckResult(purchaseOrder);
	}
	
	/**
	 * 导出
	 * @param purchaseOrder
	 * @return
	 */
	public List<PurchaseOrder> export(PurchaseOrder purchaseOrder) {
		return dao.export(purchaseOrder);
	}

	/**
	 * 按批次导出采购货品
	 * @param Order
	 * @return
	 */
	public PurchaseOrder exportByInBatchNo(PurchaseOrder Order, String[] inBatchNos) {
		PurchaseOrder purchaseOrder = getWithPurchaseProducesAndPurchaseProducts(Order.getId());
//		purchaseOrder.setInBatchNo(Order.getInBatchNo());
		/*for (int i = 0; i < inBatchNos.length(); i++) {
		 int inBatchNo  = inBatchNos.indexOf(i);
		 purchaseOrder.setInBatchNo(inBatchNo);
		}*/
		List<PurchaseProduce> purchaseProduceList=purchaseOrder.getPurchaseProduceList();
		for(PurchaseProduce purchaseProduce :purchaseProduceList){
			List<PurchaseProduct> purchaseProductList = purchaseProduce.getPurchaseProductList();
			List<PurchaseProduct> newProductList =new ArrayList<>();
			for(PurchaseProduct purchaseProduct :purchaseProductList){
				if(purchaseProduct.getInBatchNo() != null && inBatchNos.length > 0){
					for (String inBatchNo : inBatchNos) {
						if(purchaseProduct.getInBatchNo()==Integer.valueOf(inBatchNo)){
							newProductList.add(purchaseProduct);
						}
					}
				}
			}
			purchaseProduce.setPurchaseProductList(newProductList);
		}
		return purchaseOrder;
	}

	/**
	 * 货品采购批量数据Excel导入
	 * @param ei
	 * @throws IOException 
	 */
	@Transactional(readOnly = false)
	public void importProduct(String purchaseOrderId , String produceId,ImportExcel ei) throws IOException {
		PurchaseOrder purchaseOrderParam = dao.get(purchaseOrderId);
		if(purchaseOrderParam == null ){
			throw new ServiceException("采购单不存在！");
		}
		PurchaseProduce purchaseProduceTemp = purchaseProduceService.get(produceId);
		if(purchaseProduceTemp == null ){
			throw new ServiceException("采购单对应的产品不存在！");
		}
		List<PurchaseProduce> purchaseProduceList = new ArrayList<>();
		purchaseProduceList.add(purchaseProduceTemp);
		purchaseOrderParam.setPurchaseProduceList(purchaseProduceList);

		List<PurchaseProduct> purchaseProductList = new ArrayList<>();
		purchaseProduceTemp.setPurchaseProductList(purchaseProductList);
		for (int i = 0; i < ei.getLastDataRowNum(); i++) {
			PurchaseProduct purchaseProduct = new PurchaseProduct();
			Row row = ei.getRow(i);
			Object val_0 = ei.getCellValue(row, 0);
			Object val_1 = ei.getCellValue(row, 1);
			Object val_2 = ei.getCellValue(row, 2);
			Object val_3 = ei.getCellValue(row, 3);
			Object val_4 = ei.getCellValue(row, 4);
			try {
				if (StringUtils.isNotBlank(val_0.toString())) {//货品克重
					String weight = val_0.toString();
					purchaseProduct.setWeight(BigDecimal.valueOf(Double.valueOf(weight)));
				}else{
					//过滤空白行
					continue;
				}
				if (StringUtils.isNotBlank(val_1.toString())) {//货品采购价
					String pricePurchase = val_1.toString();
					purchaseProduct.setPricePurchase(BigDecimal.valueOf(Double.valueOf(pricePurchase)));

				}else{
					purchaseProduct.setPricePurchase(purchaseProduceTemp.getProduce().getPricePurchase());
					//continue;
				}
				if (StringUtils.isNotBlank(val_2.toString())) {//货品证书编号
					String certificateNo = val_2.toString();
					purchaseProduct.setCertificateNo(certificateNo);
				}
				if (StringUtils.isNotBlank(val_3.toString())) {//货品合格状态
					String regularFlag = val_3.toString();
					purchaseProduct.setRegularFlag(regularFlag.substring(0,1));
				}
				if (StringUtils.isNotBlank(val_4.toString())) {//备注
					String remarks = val_4.toString();
					purchaseProduct.setRemarks(remarks);
				}
			} catch (ServiceException e) {
				throw new ServiceException("导入数据格式不正确，请重新导入！");
			}
			purchaseProductList.add(purchaseProduct);
		}
		saveForm(purchaseOrderParam);
	}

	
	public List<PurchaseOrder> findProductList(PurchaseOrder purchaseOrder) {
		return dao.findProductList(purchaseOrder);
	}
	
}


