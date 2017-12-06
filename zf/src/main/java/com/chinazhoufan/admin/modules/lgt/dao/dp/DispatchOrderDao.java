/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.dp;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchOrder;

/**
 * 调货单DAO接口
 * @author 贾斌
 * @version 2016-03-16
 */
@MyBatisDao
public interface DispatchOrderDao extends CrudDao<DispatchOrder> {
	
	/**
	 * 根据调货单ID获取下面的调货单产品信息集合及对应的货品信息集合
	 * @param dispatchOrder
	 * @return
	 */
	public DispatchOrder getDispatchOrderWithGoodsDetail(DispatchOrder dispatchOrder);
	
	/**
	 * 根据调货单ID获取下面的调货单产品信息集合及对应的货品信息集合
	 * @param dispatchOrder
	 * @return
	 */
	public DispatchOrder getDispatchOrderWithGoodsDetailAll(DispatchOrder dispatchOrder);
	
	/**
	 * 根据任务ID获取未完成的子订单个数
	 * @param dispatchMissionId
	 * @return
	 */
	public int getCompleteDispatchOrderByMissionId(String dispatchMissionId);
	
	/**
	 * 根据调货任务ID删除下面所有相关的调货单记录,物理删除
	 * @param dispatchMissionId
	 */
	public void removeDispatchOrderByMissionId(@Param("delFlag")String delFlag, @Param("dispatchMissionId")String dispatchMissionId);
	
	
	//-----------------我的调拨单查询---------------------
	
	/**
	 * 调入
	 * @param dispatchOrder
	 * @return
	 */
	public List<DispatchOrder> callInList(DispatchOrder dispatchOrder);
	
	/**
	 * 调出
	 * @param dispatchOrder
	 * @return
	 */
	public List<DispatchOrder> callOutList(DispatchOrder dispatchOrder);
	
	/**
	 * 待入库
	 * @param dispatchOrder
	 * @return
	 */
	public List<DispatchOrder> pendingStockList(DispatchOrder dispatchOrder);
	
	//-----------------我的调拨单查询---------------------
}