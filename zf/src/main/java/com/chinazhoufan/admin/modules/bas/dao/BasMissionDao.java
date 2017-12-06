/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;

/**
 * 任务表DAO接口
 * @author 刘晓东
 * @version 2015-10-22
 */
@MyBatisDao
public interface BasMissionDao<T> extends CrudDao<T> {
	
	public Integer findCount();
	
	public BasMission findByBarCode(String barCode);
}