/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.dao.as;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.ser.entity.as.Workorder;
import org.apache.ibatis.annotations.Param;

/**
 * 售后工单DAO接口
 * @author liut
 * @version 2017-05-18
 */
@MyBatisDao
public interface WorkorderDao extends CrudDao<Workorder> {

	/**
	 * 根据ID获取工单明细，包括处理任务
	 * @param workOrder
	 * @return
	 */
	public Workorder find(Workorder workOrder);
	
	
	/**
	 * 根据ID变更工单状态
	 * @param workOrder
	 */
	public void updateStatusById(Workorder workOrder);
	
	/**
	 * 根据ID变更下一步处理人和工单状态
	 * @param workOrder
	 */
	public void updateDealUserAndStatusById(Workorder workOrder);

	/**
	 * 根据ORDERID变更工单状态
	 * @param workOrder
	 */
	public void updateStatusByOrderId(Workorder workOrder);
	
	
}