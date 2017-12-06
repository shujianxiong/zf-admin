/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.or;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.or.RepairOrder;

/**
 * 货品维修单DAO接口
 * @author 张金俊
 * @version 2016-11-19
 */
@MyBatisDao
public interface RepairOrderDao extends CrudDao<RepairOrder> {
	
}