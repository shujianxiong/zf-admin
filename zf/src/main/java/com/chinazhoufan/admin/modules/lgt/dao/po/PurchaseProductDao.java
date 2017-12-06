/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.po;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;

/**
 * 采购货品表DAO接口
 * @author 张金俊
 * @version 2015-11-02
 */
@MyBatisDao
public interface PurchaseProductDao extends CrudDao<PurchaseProduct> {

	/**
	 * 根据采购产品记录Id，删除采购产品下所有的采购货品记录
	 * @param purchaseProduceId	采购产品记录Id
	 */
	public void removeByPurchaseProduceId(String purchaseProduceId);

	
	public String getLatestInBatchNo(String purchaseOrderId);

	public void updateSingleByProduct(PurchaseProduct purchaseProduct);

	public PurchaseProduct getByProductId(String productId);

}