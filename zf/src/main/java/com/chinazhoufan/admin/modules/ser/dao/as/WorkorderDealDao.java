/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.dao.as;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.ser.entity.as.WorkorderDeal;

/**
 * 售后工单处理DAO接口
 * @author liut
 * @version 2017-05-18
 */
@MyBatisDao
public interface WorkorderDealDao extends CrudDao<WorkorderDeal> {
	
	public WorkorderDeal findLatestByWorkOrder(WorkorderDeal workorderDeal);
	
}