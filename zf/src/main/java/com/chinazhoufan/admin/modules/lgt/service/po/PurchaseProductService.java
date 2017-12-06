/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.po;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseProductDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;

/**
 * 采购货品表Service
 * @author 张金俊
 * @version 2015-11-02
 */
@Service
@Transactional(readOnly = true)
public class PurchaseProductService extends CrudService<PurchaseProductDao, PurchaseProduct> {
	
	public PurchaseProduct get(String id) {
		return super.get(id);
	}
	
	public List<PurchaseProduct> findList(PurchaseProduct purchaseProduct) {
		return super.findList(purchaseProduct);
	}
	
	public Page<PurchaseProduct> findPage(Page<PurchaseProduct> page, PurchaseProduct purchaseProduct) {
		return super.findPage(page, purchaseProduct);
	}
	
	@Transactional(readOnly = false)
	public void save(PurchaseProduct purchaseProduct) {
		super.save(purchaseProduct);
	}
	@Transactional(readOnly = false)
	public void updateSingleByProduct(PurchaseProduct purchaseProduct) {
		dao.updateSingleByProduct(purchaseProduct);
	}

	@Transactional(readOnly = false)
	public void delete(PurchaseProduct purchaseProduct) {
		super.delete(purchaseProduct);
	}

	public PurchaseProduct getByProductId(String productId) {
		return dao.getByProductId(productId);
	}
	
}