/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.dp;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduce;

/**
 * 调货任务DAO接口
 * @author 刘晓东
 * @version 2015-10-20
 */
@MyBatisDao
public interface DispatchProduceDao extends CrudDao<DispatchProduce> {
	public List<DispatchProduce> getOrderId(String id);
	
	/**
	 * 根据调货单ID获取对应的调货货品信息，附加货品对应的产品信息
	 * @param dispatchOrderId
	 * @return
	 */
	public List<DispatchProduce> listProductWithProduceByDispatchOrderId(String dispatchOrderId);
	
	/**
	 * 根据调货单ID删除和和他相关的调货产品记录,物理删除
	 * @param dispatchOrderId
	 */
	public void removeDispatchProduceByDispatchOrderId(@Param("delFlag")String delFlag, @Param("dispatchOrderIds")List<String> dispatchOrderIds);
}