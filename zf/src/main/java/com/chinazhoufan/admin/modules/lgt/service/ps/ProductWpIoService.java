/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.dao.UserDao;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductWpIoDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarecounterDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarehouseDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WareplaceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warecounter;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.sys.entity.User;


/**
 * 货品出入库记录Service
 * @author 张金俊
 * @version 2015-11-09
 */
@Service
@Transactional(readOnly = true)
public class ProductWpIoService extends CrudService<ProductWpIoDao, ProductWpIo> {
	
	@Autowired
	private ProduceDao produceDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private WarehouseDao warehouseDao;
	@Autowired
	private WarecounterDao warecounterDao;
	@Autowired
	private WareplaceDao wareplaceDao;
	@Autowired
	private WhProduceService whProduceService;
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private UserDao userDao;
	public ProductWpIo get(String id) {
		return super.get(id);
	}
	
	public List<ProductWpIo> findList(ProductWpIo productWpIo) {
		return super.findList(productWpIo);
	}
	
	public Page<ProductWpIo> findPage(Page<ProductWpIo> page, ProductWpIo productWpIo) {
		return super.findPage(page, productWpIo);
	}
	
	@Transactional(readOnly = false)
	public void save(ProductWpIo productWpIo) {
		super.save(productWpIo);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProductWpIo productWpIo) {
		super.delete(productWpIo);
	}
	
	/**
	 * 货品入库（库存）通用方法
	 * @param productWpIo 货品出入库记录
	 * 步骤：	1.更新/保存货品
	 * 		2.更新库存
	 * 		3.保存货品出入库记录
	 * 
	 * PS：	如果productWpIo.product.id是空，则当前入库为新增货品的入库操作，需要创建货品并保存（需传入新货品相关数据）
	 * 		如果productWpIo.product.id不是空，则当前入库为系统已有货品的入库操作，需要根据入库原因类型，更新货品相关数据（货品状态等）
	 */
	/**
	 * PS：	（已改，改为自动入库到默认仓库，自动设置存放货位）入库所影响的库存变化针对的仓库，取决于货品出入库记录（ProductWpIo）中的出入库货位（ioWareplace）对应的仓库
	 * 		即  入库时入哪个库，对应仓库库存增加；（已改，改为自动入库到默认仓库，自动设置存放货位）
	 * PS：	正常货品入库时，只能存放在空货位上，或已存放该货品对应产品的货位上（一个货位只能存放一个产品下的多个货品）。
	 */
	@Transactional(readOnly = false)
	public ProductWpIo productInSave(ProductWpIo productWpIo) {
		// 默认入库仓库
		Warehouse warehouseDefault = warehouseDao.getDefault();
		
		if(!ProductWpIo.IOTYPE_IN.equals(productWpIo.getIoType()))
			throw new ServiceException("货品入库失败，货品出入库记录中存在不正确的操作类型，请确认！");
		
		Product product = productWpIo.getProduct();		// 入库货品
		
		//给货品赋予所属供应商
		product.setSupplier(productWpIo.getSupplier());
		
		Produce produce = product.getProduce();			// 入库货品对应的产品
		if(produce == null || produce.getId() == null){
			throw new ServiceException("货品入库失败，产品编码不能为空，请确认！");
		}
		produce = produceDao.get(produce.getId());
		int existProductNum = productDao.countByProduce(produce.getId());
		if(StringUtils.isEmpty(product.getId())){
			// 新增货品，设置货品的商品ID
			product.setGoods(produce.getGoods());
			// 设置货品的货品编码
			product.setCode(String.valueOf(Integer.valueOf(produce.getCode()))+(1+existProductNum));
		}
		/**
		 * 设置货品状态
		 * PS：货品入库，货品状态不取决于商品、产品状态。
		 * 		商品、产品状态冻结，只是限制商品、产品功能（比如不能销售等），不影响库存，所以不影响货品状态。
		 * 		货品锁定，是比如维修、调货等产生的库存锁定。
		 */
		product.setStatus(productWpIo.getInStatus());
		// 设置货品物流状态：在库
		product.setStatusLogistics(Product.STATUS_LGT_IN);
		
		/**
		 * 设置货品存放货位
		 * 	正常货品存放规则：
		 * 		当前仓库有该货品对应的存放货位时，存放至该货位
		 * 		当前仓库没有该货品对应的存放货位时，在该货品所属分类下按编码顺序找第一个空货位
		 * 	坏货货品存放规则：
		 * 		采购坏货：在坏货货架中，查找该货品对应供应商、对应分类的货屉，存放到货屉中靠外的货位上（排序第一）
		 * 		退货坏货：在坏货货架中，查找该货品对应供应商、对应分类的货屉，存放到货屉中靠里的货位上（排序第二）
		 */
		Wareplace wareplaceToIn;
		if(ProductWpIo.INTYPE_NORMAL.equals(productWpIo.getInType())){
			// 查找正常货品的存放货位
			wareplaceToIn = wareplaceDao.getNormalByProduceId(warehouseDefault.getId(), produce.getId());
			if(wareplaceToIn != null){
				product.setWareplace(wareplaceToIn);
				product.setHoldUser(new User());
			}else {
				// 查找第一个空货位(货品所属分类下的货架、货位未锁定、货位已启用)
				wareplaceToIn = wareplaceDao.getNormalFirstEmptyForUpdate(warehouseDefault.getId(), produce.getGoods().getCategory().getId());
				if(wareplaceToIn != null){
					// 设置货品货位
					product.setWareplace(wareplaceToIn);
					product.setHoldUser(new User());
					// 更新空货位的存放产品ID
					wareplaceToIn.setProduce(produce);
					wareplaceToIn.preUpdate();
					wareplaceDao.update(wareplaceToIn);
				}else {
					throw new ServiceException("货品入库失败，仓库正常货架区对应分类货架下没有可用空货位！");
				}
			}
		}else {
			// 查找坏货货品的存放货位
			Warecounter warecounterToIn = warecounterDao.getBroken(warehouseDefault.getId(), productWpIo.getSupplier().getId(), produce.getGoods().getCategory().getId());
			if(warecounterToIn != null){
				Wareplace wareplaceParam = new Wareplace();
				wareplaceParam.setWarecounter(warecounterToIn);
				List<Wareplace> wareplaceToInList = wareplaceDao.findList(wareplaceParam);
				if(ProductWpIo.INTYPE_BROKEN_PURCHASE.equals(productWpIo.getInType())){
					// 采购坏货，存放到第一个货位
					if(wareplaceToInList != null 
							&& wareplaceToInList.size()>0 
							&& Wareplace.FALSE_FLAG.equals(wareplaceToInList.get(0).getLockFlag())
							&& Wareplace.TRUE_FLAG.equals(wareplaceToInList.get(0).getUsableFlag())){
						wareplaceToIn = wareplaceToInList.get(0);
						product.setWareplace(wareplaceToIn);
						product.setHoldUser(new User());
					}else {
						throw new ServiceException("货品入库失败，仓库坏货货架区该货品对应抽屉下第一个货位（存放采购坏货）已锁定或未启用！");					
					}
				}else if(ProductWpIo.INTYPE_BROKEN_STOCK.equals(productWpIo.getInType())){
					// 库存坏货，存放到第二个货位
					if(wareplaceToInList != null 
							&& wareplaceToInList.size()>1 
							&& Wareplace.FALSE_FLAG.equals(wareplaceToInList.get(1).getLockFlag())
							&& Wareplace.TRUE_FLAG.equals(wareplaceToInList.get(1).getUsableFlag())){
						wareplaceToIn = wareplaceToInList.get(1);
						product.setWareplace(wareplaceToIn);
						product.setHoldUser(new User());
					}else {
						throw new ServiceException("货品入库失败，仓库坏货货架区该货品对应抽屉下第二个货位（存放库存坏货）已锁定或未启用！");					
					}
				}else {
					throw new ServiceException("货品入库失败，仓库坏货货架区该货品对应抽屉暂只支持采购坏货和库存坏货两种类型货品的入库存放！");			
				}
			}else {
				throw new ServiceException("货品入库失败，仓库坏货货架区无该货品对应的供应商、分类指定抽屉！");
			}
		}
				
		// 保存货品
		if(StringUtils.isBlank(product.getId())){
			product.preInsert();
			try{
				productDao.insert(product);				
			}catch (DuplicateKeyException me){
				throw new ServiceException("货品入库失败，新增货品异常（主键或唯一性约束冲突），请检查！");
			}
		}else{
			product.preUpdate();
			try{
				productDao.updateSingle(product);
			}catch (DuplicateKeyException me){
				throw new ServiceException("货品入库失败，更新货品异常（主键或唯一性约束冲突），请检查！");
			}
		}
		
		// 更新库存（根据不同的货品入库状态，设置对应的入库后库存变化）
		switch (productWpIo.getInStatus()) {
		case ProductWpIo.INSTATUS_NORMAL:
			// 销售货品入库：货品状态正常，正常库存+1，锁定库存不变
			whProduceService.updateWhProduceStock(warehouseDefault.getId(), product.getProduce().getId(), "A", 1, "A", 0, "A", 0);
			break;
		case ProductWpIo.INSTATUS_LOCKED:
			// 销售货品入库：货品状态锁定，正常库存不变，锁定库存+1
			whProduceService.updateWhProduceStock(warehouseDefault.getId(), product.getProduce().getId(), "A", 0, "A", 1, "A", 0);
			break;
		default:
			// 销售货品入库：货品状态为已售出、已移除等，不改变系统库存
			break;
		}
		
		// 保存货品出入库记录
		productWpIo.setIoWareplace(wareplaceToIn);	// 保存入库货位
		productWpIo.setProduct(product);
		super.save(productWpIo);
		
		return productWpIo;
	}
	
	/**
	 * 货品出库（库存）通用方法
	 * @param productWpIo 货品出入库记录
	 * 步骤：	1.更新/保存货品
	 * 		2.更新货位
	 * 		3.更新库存
	 * 		4.更新/保存货品出入库记录
	 * 
	 * PS：	出库所影响的库存变化针对的仓库，取决于货品（Product）中的存放货位（wareplace）对应的仓库
	 * 		即  入库时入哪个库，对应仓库库存增加；出库时，货品原仓库库存减少
	 */
	@Transactional(readOnly = false)
	public ProductWpIo productOutSave(ProductWpIo productWpIo) {
		if(!ProductWpIo.IOTYPE_OUT.equals(productWpIo.getIoType()))
			throw new ServiceException("货品出库失败，货品出库记录中存在不正确的操作类型，请确认！");
		
		Product product = productWpIo.getProduct();
		Wareplace productWareplace = product.getWareplace();	// 货品货位
		String productStatusPre = product.getStatus();			// 出库前货品状态（根据货品出库前状态，变更仓库对应库存）
		// 设置货品状态
		if(ProductWpIo.IOREASIONTYPE_OUT_SALE.equals(productWpIo.getIoReasonType())){
			// 销售出库，货品状态设置为“已售出”
			product.setStatus(Product.STATUS_SOLD);
		} else if(ProductWpIo.IOREASIONTYPE_OUT_INVENTORY.equals(productWpIo.getIoReasonType())) {
			// 盘点出库，货品状态设置为“已移除”
			product.setStatus(Product.STATUS_REMOVED);
		} else if(ProductWpIo.IOREASIONTYPE_OUT_DISPATCH.equals(productWpIo.getIoReasonType())){
			// 调货出库，货品状态设置为“已移除”
			product.setStatus(Product.STATUS_REMOVED);
		} else if(ProductWpIo.IOREASIONTYPE_OUT_REPAIR.equals(productWpIo.getIoReasonType())){
			// 维修出库，货品状态设置为“已移除”
			product.setStatus(Product.STATUS_REMOVED);
		} else if(ProductWpIo.IOREASIONTYPE_OUT_REFUR.equals(productWpIo.getIoReasonType())){
			// 翻新出库，货品状态设置为“已移除”
			product.setStatus(Product.STATUS_REMOVED);
		}
		// 清空货品位置（货位/持有人）
		//product.setWareplace(new Wareplace());
		product.setHoldUser(new User());
		product.preUpdate();
		productDao.updateSingle(product);	// 货品update语句中不更新del_flag字段，该字段使用delete语句更新
		
		/**
		 * 更新货位
		 */
		String whId;			// 仓库ID
		if(productWareplace != null && productWareplace.getId() != null){
			productWpIo.setIoWareplace(productWareplace);	// 出入库记录，保存出库货位
			Wareplace wpTemp = wareplaceDao.getWithWarehouse(productWareplace.getId());
			whId = wpTemp.getWarecounter().getWarearea().getWarehouse().getId();

			/**
			 * Ps：货品出库后，判断出库货位是否还有关联货品并清空没有关联货品的货位的“存放产品”属性
			 * 		因为货品上有电子签，实际场景中如体验中货品回货后，入库人员会根据电子签上货位信息入库货品
			 * 		所以未真正减库存的货品，系统需要保证其一直和电子签上对应的货位关联，保证该货位不可以存放其他产品
			 */
			Integer productsCount = wareplaceDao.findProductsCountByWareplaceId(wpTemp.getId());
			if(productsCount == 0){
				wpTemp.setProduce(new Produce());
				wpTemp.preUpdate();
				wareplaceDao.update(wpTemp);
			}			
		}else {
			throw new ServiceException("货品出库失败，货品的存放货位信息缺失！");
		}
		
		// 更新库存（根据货品出库前状态，变更仓库对应库存）
		switch (productStatusPre) {
		case Product.STATUS_NORMAL:
			// 正常状态货品出库：正常库存-1，锁定库存不变
			whProduceService.updateWhProduceStock(whId, product.getProduce().getId(), "D", 1, "D", 0, "D", 0);
			break;
		case Product.STATUS_LOCKED:
			// 锁定状态货品出库：正常库存不变，锁定库存-1
			whProduceService.updateWhProduceStock(whId, product.getProduce().getId(), "D", 0, "D", 1, "D", 0);
			break;
		case Product.STATUS_HIRING:
			// 体验中状态货品出库：正常库存不变，锁定库存-1
			whProduceService.updateWhProduceStock(whId, product.getProduce().getId(), "D", 0, "D", 1, "D", 0);
			break;
		default:
			throw new ServiceException("货品出库失败，存在货品状态为已售出或者已移除的记录，不能进行出库，请核对！");
		}
		
		// 保存货品出入库记录
		productWpIo.setProduct(product);
		super.save(productWpIo);
		return productWpIo;
	}
	/**
	 * 入库批量数据Excel导入
	 * @param ei
	 * @throws IOException
	 */
	@Transactional(readOnly = false)
	public void importProduct(ImportExcel ei) throws IOException {
		DecimalFormat df = new DecimalFormat("#");
		for (int i = 1; i < ei.getLastDataRowNum(); i++) {
			ProductWpIo productWpIo = new ProductWpIo();
			Row row = ei.getRow(i);
			Object val_0 = ei.getCellValue(row, 0);
			Object val_1 = ei.getCellValue(row, 1);
			Object val_2 = ei.getCellValue(row, 2);
			Object val_3 = ei.getCellValue(row, 3);
			Object val_4 = ei.getCellValue(row, 4);
			Object val_5 = ei.getCellValue(row, 5);
			Object val_6 = ei.getCellValue(row, 6);
			Object val_7 = ei.getCellValue(row, 7);
			Object val_8 = ei.getCellValue(row, 8);
			Object val_9 = ei.getCellValue(row, 9);
			Object val_10 = ei.getCellValue(row, 10);
			try {
				Product product = new Product();
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_0.toString())) {//产品编码S
					String proNo = df.format(val_0);
					Produce produce = produceDao.findByBarCode(proNo);
					product.setProduce(produce);
					productWpIo.setProduct(product);
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_1.toString())) {//操作原因类型
					productWpIo.setIoReasonType(df.format(val_1));
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_2.toString())) {//入库货品类型
					productWpIo.setInType(df.format(val_2));
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_3.toString())) {//入库货品状态
					productWpIo.setInStatus(df.format(val_3));
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_4.toString())) {//货品克重
					String weight = val_4.toString();
					product.setWeight(BigDecimal.valueOf(Double.valueOf(weight)));
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_5.toString())) {//供应商
					Supplier supplier = supplierService.getByName(val_5.toString());
					if(supplier != null){
						productWpIo.setSupplier(supplier);
					}
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_6.toString())) {//采购价
					String price = val_6.toString();
					product.setPricePurchase(BigDecimal.valueOf(Double.valueOf(price)));
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_7.toString())) {//货品原厂编码
					product.setFactoryCode(df.format(val_7));
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_8.toString())) {//货品证书编码
					product.setCertificateNo(df.format(val_8));
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_9.toString())) {//来源业务单号
					if(val_9.toString().matches(".*[a-zA-z].*")){
						productWpIo.setIoBusinessorderId(val_9.toString());
					}else{
						productWpIo.setIoBusinessorderId(df.format(val_9));
					}

				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_10.toString())) {//备注
					productWpIo.setRemarks(val_10.toString());
				}
			} catch (ServiceException e) {
				throw new ServiceException("导入数据格式不正确，请重新导入！");
			}
			productWpIo.setIoUser(UserUtils.getUser());
			productWpIo.setIoTime(new Date());
			productWpIo.setIoType(ProductWpIo.IOTYPE_IN);
			productInSave(productWpIo);
		}
	}
	/**
	 * 出库批量数据Excel导入
	 * @param ei
	 * @throws IOException
	 */
	@Transactional(readOnly = false)
	public void outImportProduct(ImportExcel ei) throws IOException {
		DecimalFormat df = new DecimalFormat("#");
		for (int i = 1; i < ei.getLastDataRowNum(); i++) {
			ProductWpIo productWpIo = new ProductWpIo();
			Row row = ei.getRow(i);
			Object val_0 = ei.getCellValue(row, 0);
			Object val_1 = ei.getCellValue(row, 1);
			Object val_2 = ei.getCellValue(row, 2);
			Object val_3 = ei.getCellValue(row, 3);
			try {
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_0.toString())) {//操作原因类型
					productWpIo.setIoReasonType(df.format(val_0));
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_1.toString())) {//货品编码
					List<Product> productList = productDao.findListByProductCodeWithDel(df.format(val_1));
					Product product = (productList==null || productList.size()==0) ? null : productList.get(0);
					productWpIo.setProduct(product);
				}else{
					//过滤空白行
					continue;
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_2.toString())) {//来源业务单号
					if(val_2.toString().matches(".*[a-zA-z].*")){
						productWpIo.setIoBusinessorderId(val_2.toString());
					}else{
						productWpIo.setIoBusinessorderId(df.format(val_2));
					}
				}
				if (org.apache.commons.lang3.StringUtils.isNotBlank(val_3.toString())) {//备注
					productWpIo.setRemarks(val_3.toString());
				}
			} catch (ServiceException e) {
				throw new ServiceException("导入数据格式不正确，请重新导入！");
			}
			productWpIo.setIoUser(UserUtils.getUser());
			productWpIo.setIoTime(new Date());
			productWpIo.setIoType(ProductWpIo.IOTYPE_OUT);
            productOutSave(productWpIo);
		}
	}
}
