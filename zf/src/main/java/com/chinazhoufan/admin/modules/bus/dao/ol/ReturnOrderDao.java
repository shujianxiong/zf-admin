/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ol;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;

/**
 * 退货单DAO接口
 * @author 张金俊
 * @version 2017-04-19
 */
@MyBatisDao
public interface ReturnOrderDao extends CrudDao<ReturnOrder> {
	
	/**
	 * 通过订单类型、订单ID查询对应退货单
	 * @param orderType	订单类型
	 * @param orderId	订单ID
	 * @return
	 */
	public ReturnOrder getByOrder(@Param("orderType") String orderType, @Param("orderId") String orderId);

	/**
	 * 通过物流单号查询对应退货单
	 * @return
	 */
	public ReturnOrder getByExpressNo(ReturnOrder returnOrder);
	
	/**
	 * 根据物流单号获取退货单信息
	 * @param returnOrder
	 * @return
	 */
	public List<ReturnOrder> findReturnOrderByExpressNo(ReturnOrder returnOrder);
	
	
	/**
	 * 根据物流单号获取退货单明细，包括产品对应的货位及库存
	 * @param returnOrder
	 * @return
	 */
	public List<ReturnOrder> findWithProduceAndWareplaceByExpressNo(ReturnOrder returnOrder);
	
	
	/**
	 * 根据物流单号获取退货单，退货货品明细
	 * @param returnOrder
	 * @return
	 */
	public ReturnOrder findWithProductByExpressNo(ReturnOrder returnOrder);
	
	
	/**
	 * 根据ID变更退货单状态
	 * @param returnOrder
	 */
	public void updateStatusById(ReturnOrder returnOrder);
	/**
	 * 根据orderID变更退货单状态
	 * @param returnOrder
	 */
	public void updateStatusByorder(ReturnOrder returnOrder);

	/**
	 * 根据ids查询订单集合
	 * @param ids
	 */
	public List<String> getReturnOrderByIds(@Param("ids") List<String> ids);

	public List<ReturnOrder> findReceiptList();


	/**
	 * 通过订单类型、订单ID查询对应退货单以及明细
	 * @param orderType	订单类型
	 * @param orderId	订单ID
	 * @return
	 */
	public ReturnOrder getDetail(@Param("orderType") String orderType, @Param("orderId") String orderId);
}