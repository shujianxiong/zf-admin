/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ol;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;

/**
 * 发货单DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface SendOrderDao extends CrudDao<SendOrder> {
	
	/**
	 * 根据拣货单ID获取打包中的发货单数量
	 * @param sendOrder
	 * @return
	 */
	public Integer countPackageingByPickOrder(SendOrder sendOrder);

	/**
	 * 根据快递号获取订单对应的发货单信息
	 * @param sendOrder
	 * @return
	 */
	public SendOrder findSendOrderByExpressNo(SendOrder sendOrder);
	
	/**
	 * 根据拣货单ID，批量更新发货单的状态为打包中
	 * @param sendOrder
	 */
	public void updateStatusByPickOrder(SendOrder sendOrder);
	/**
	 * 根据订单ID，更新发货单的状态为打包中
	 * @param sendOrder
	 */
	public void updateStatusByOrder(SendOrder sendOrder);
	/**
	 * 根据订单ID，更新发货单用户信息
	 * @param sendOrder
	 */
	public void updateByOrder(SendOrder sendOrder);
	
	/**
	 * 根据拣货单ID，托盘编号，获取拣货按序号从小到大排序的且状态为打包中的发货单信息
	 * @param sendOrder
	 * @return
	 */
	public List<SendOrder> findSendOrderWithMinPickNo(SendOrder sendOrder);
	
	
	/**
	 * 根据ID更新状态和物流单号
	 * @param sendOrder
	 */
	public void updateStatusAndExpressNoById(SendOrder sendOrder);
	
	/**
	 * 根据ID列出发货单详情，包括产品，及商品
	 * @param sendOrder
	 * @return
	 */
	public SendOrder findWithDetail(SendOrder sendOrder);
	
	
	/**
	 * 查询出待拣货的发货单（发货日期在当前日期或之前，状态为待拣货，删除标记为未删除）
	 * @param sendOrder
	 * @return
	 */
	public List<SendOrder> findToPickList(SendOrder sendOrder);
	
	/**
	 * 变更发货单激活状态
	 * @param sendOrder
	 */
	public void updateActiveFlagById(SendOrder sendOrder);

	/**
	 * 批量更新发货状态为“发货中”4
	 * @param list
	 */
	public void batchUpdateStatus(List list);
	
	/**
	 * 根据订单Id查询发货单
	 * @param orderId
	 * @return
	 */
	public SendOrder getByOrderId(@Param("orderId")String orderId);
	
	public List<SendOrder> findOutboundDetailsList(SendOrder sendOrder);

    List<SendOrder> findByPickOrder(@Param("pickOrderId") String pickOrderId);

	public SendOrder getBySendOrderNo(String sendOrderNo);
}