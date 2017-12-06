/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.po;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;

/**
 * 采购单DAO接口
 * @author 张金俊
 * @version 2015-10-16
 */
@MyBatisDao
public interface PurchaseOrderDao extends CrudDao<PurchaseOrder> {
	
	public Integer findCount();
	
	/**
	 * 统计任务下除某订单外，其他某状态的订单数量
	 * @param purchaseMissionId		被统计采购任务ID
	 * @param purchaseOrderId		不纳入统计的采购订单ID
	 * @param purchaseOrderStatus	不纳入统计的采购订单状态
	 * @return
	 */
	public Integer findUnfinishOrderCount(@Param("mid")String purchaseMissionId, @Param("oid")String purchaseOrderId, @Param("ostatus")String purchaseOrderStatus);
	
	/**
	 * 查询采购订单以及包含的采购产品
	 * @param entity
	 * @return
	 */
	public PurchaseOrder getWithPurchaseProduces(String id);
	
	/**
	 * 查询采购订单以及包含的采购产品、采购货品信息
	 * @param entity
	 * @return
	 */
	public PurchaseOrder getWithPurchaseProducesAndPurchaseProducts(String id);
	
	/**
	 * 批量插入采购订单
	 * @param list
	 * @return
	 */
	public int insertList(List<PurchaseOrder> list);
	
	/**
	 * 物理删除采购订单（只能删除新建状态的）
	 * @param purchaseOrder
	 */
	public void remove(PurchaseOrder purchaseOrder);

	
	/**
	 * 根据供应商登录账号的ID获取和他相关的采购订单
	 * @param userId
	 * @return
	 */
	public List<PurchaseOrder> listPurchaseOrderForSupplier(@Param("page")Page page, @Param("purchaseOrder")PurchaseOrder purchaseOrder, @Param("sysUserId")String sysUserId);

	/**
	 * 保存审批结果
	 * @param purchaseOrder    设定文件
	 * @throws
	 */
	public void saveCheckResult(PurchaseOrder purchaseOrder);
	
	/**
	 * 更新采购单实际采购金额
	 * @param purchaseOrder    设定文件
	 * @throws
	 */
	public void updatePayableAmount(PurchaseOrder purchaseOrder);
	
	
	public List<PurchaseOrder> export(PurchaseOrder purchaseOrder);

	public List<PurchaseOrder> findProductList(PurchaseOrder purchaseOrder);
}