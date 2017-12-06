/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.po;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;

/**
 * 采购产品Service
 * @author 张金俊
 * @version 2015-11-02
 */
@Service
@Transactional(readOnly = true)
public class PurchaseProduceService extends CrudService<PurchaseProduceDao, PurchaseProduce> {

	@Autowired
	private PurchaseProduceDao purchaseProduceDao;
	
	public PurchaseProduce get(String id) {
		return super.get(id);
	}
	
	public PurchaseProduce getPurchaseProduceAndProduce(String id) {
		return purchaseProduceDao.getPurchaseProduceAndProduce(id);
	}
	
	public List<PurchaseProduce> findList(PurchaseProduce purchaseProduce) {
		return super.findList(purchaseProduce);
	}
	
	public Page<PurchaseProduce> findPage(Page<PurchaseProduce> page, PurchaseProduce purchaseProduce) {
		return super.findPage(page, purchaseProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(PurchaseProduce purchaseProduce) {
		super.save(purchaseProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(PurchaseProduce purchaseProduce) {
		super.delete(purchaseProduce);
	}
	
	@Transactional(readOnly = false)
	public void updatePurchaseProduceRealtyNum(PurchaseProduce purchaseProduce) {
		dao.updatePurchaseProduceRealtyNum(purchaseProduce);
	};
}