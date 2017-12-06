/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.dao.uw;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;

/**
 * 报警发送设置DAO接口
 * @author 刘晓东
 * @version 2015-12-11
 */
@MyBatisDao
public interface WarningConfigDao extends CrudDao<WarningConfig> {

	public WarningConfig findByWarningConfigType(WarningConfig warningConfig);
	public void updateUsableFlag(WarningConfig warningConfig);
	public void updateMonitorFlag(WarningConfig warningConfig);
	
	public WarningConfig getByType(@Param("category")String category, @Param("type")String type);
	
}