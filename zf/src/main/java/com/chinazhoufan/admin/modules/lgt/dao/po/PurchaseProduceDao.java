/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.po;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;

/**
 * 采购单DAO接口
 * @author 张金俊
 * @version 2015-10-16
 */
@MyBatisDao
public interface PurchaseProduceDao extends CrudDao<PurchaseProduce> {
	
	public PurchaseProduce getPurchaseProduceAndProduce(String id);
	
	public int insertList(List<PurchaseProduce> list);

	/**
	 * （物理）删除采购产品
	 * @param id 采购产品Id
	 */
	public void remove(String id);
	/**
	 * （物理）删除采购产品
	 * @param id 采购订单Id
	 */
	public void removeByPurchaseOrder(String id);
	
	/**
	 * 根据录入的货品数量，来更新采购产品的实际数量
	 * @param purchaseProduce    设定文件
	 * @throws
	 */
	public void updatePurchaseProduceRealtyNum(PurchaseProduce purchaseProduce);
	
}