/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseProductService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductWpChangeDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 货品明细管理Service
 * @author 陈适
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class ProductService extends CrudService<ProductDao, Product> {

	@Autowired
	private PurchaseProductService purchaseProductService;

	public Product get(String id) {
		return super.get(id);
	}
	
	/**
	 * 根据货品编码查询出某个货品（包含伪删状态，如果编码重复则返回第一个）
	 * @param productCode 货品编码
	 * @return
	 */
	public Product getByCode(String productCode) {
		List<Product> productList = dao.findListByProductCodeWithDel(productCode);
		return (productList==null || productList.size()==0) ? null : productList.get(0);
	}
	
	/**
	 * 根据货品电子码查询货品（包含伪删状态）
	 * @param scanCode 货品电子码
	 * @return
	 */
	public Product getByScanCode(String scanCode) {
		return dao.getByScanCode(scanCode);
	}
	
	public List<Product> findList(Product product) {
		return super.findList(product);
	}
	
	public Page<Product> findPage(Page<Product> page, Product product) {
		return super.findPage(page, product);
	}
	
	@Transactional(readOnly = false)
	public void save(Product product) {
		if(Product.STATUS_UPDATE_YES.equals(product.getUpdateStatus())){
			PurchaseProduct purchaseProduct = purchaseProductService.getByProductId(product.getId());
			purchaseProduct.setProduct(product);
			purchaseProduct.setWeight(product.getWeight());
			purchaseProduct.setRemarks(product.getRemarks());
			purchaseProduct.setPricePurchase(product.getPricePurchase());
			purchaseProduct.setCertificateNo(product.getCertificateNo());
			purchaseProduct.setUpdateDate(new Date());
			purchaseProduct.setUpdateBy(UserUtils.getUser());
			purchaseProductService.save(purchaseProduct);
		}
		super.save(product);
	}
	
	@Transactional(readOnly = false)
	public void update(Product product) {
		dao.update(product);
	}
	
	/**
	 * 根据ID独立更新货品属性（有值的才会更新）
	 * @param product
	 */
	@Transactional(readOnly = false)
	public void updateSingle(Product product) {
		dao.updateSingle(product);
	}
	
	/**
	 * 更新货品电子码
	 * @param product
	 */
	@Transactional(readOnly = false)
	public void updateScanCode(Product product) {
		dao.updateScanCode(product);
	}
	
	/**
	 * 根据产品ID更新所有货品状态
	 * @param ProduceId
	 */
	@Transactional(readOnly = false)
	public void updateStatusByProduceId(String ProduceId, String status){
		dao.lockByProduceId(ProduceId, status);
		//TODO 生成货品状态变更记录
	}
	
	@Transactional(readOnly = false)
	public void delete(Product product) {
		super.delete(product);
	}
	
	public Product findByBarCode(String barCode){
		return dao.findByBarCode(barCode);
	}
	
	public List<Product> printPreview(Product product) {
		return dao.printPreview(product);
	};
	
	
	//==================Syn Mobile Operator Interface START===============
	/**
	 * 根据货品编码查询货品（不包含伪删状态）
	 * @param code 货品编码
	 * @param code
	 * @return
	 */
	public Product getByCodeWithOutDel(String code) {
		if(StringUtils.isBlank(code)) return null;
		return dao.getByCodeWithOutDel(code);
	}
	
	/**
	 * 根据产品ID查询某仓库中所有存货货位（PS：需满足 货品未删、货品可租、状态正常、物流状态在库、货位非锁定、仓库是出库仓、仓库启用）
	 * @param produceId		产品ID
	 * @param warehouseId	仓库ID
	 * @return
	 */
	public List<Wareplace> getWareplacesForProduce(String produceId, String warehouseId){
		return dao.getWareplacesForProduce(produceId, warehouseId);
	}
	
	//==================Syn Mobile Operator Interface END===============
	public int countByProduce(String produceId) {
		return dao.countByProduce(produceId);
	}


	/**
	 * 自动更新货品修改状态,修改状态=>禁止修改
	 */
	@Transactional(readOnly = false)
	public void updateStatusByAuto(){
		dao.updateStatusByAuto();
	}
}