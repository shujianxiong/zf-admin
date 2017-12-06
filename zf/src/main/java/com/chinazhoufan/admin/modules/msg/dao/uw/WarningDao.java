/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.dao.uw;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;

/**
 * 员工报警中心DAO接口
 * @author 刘晓东
 * @version 2015-12-10
 */
@MyBatisDao
public interface WarningDao extends CrudDao<Warning> {
	
	public List<Warning> findMyPageByUser(Map<String, Object> map);
	
}