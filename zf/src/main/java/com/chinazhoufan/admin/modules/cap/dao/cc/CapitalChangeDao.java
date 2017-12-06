/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.cap.dao.cc;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.cap.entity.cc.CapitalChange;

/**
 * 资产设备变动记录DAO接口
 * @author 贾斌
 * @version 2015-12-08
 */
@MyBatisDao
public interface CapitalChangeDao extends CrudDao<CapitalChange> {
	
}