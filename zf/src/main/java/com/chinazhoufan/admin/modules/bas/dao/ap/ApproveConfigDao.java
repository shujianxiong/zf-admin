/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao.ap;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveConfig;

/**
 * 审批设置DAO接口
 * @author 贾斌
 * @version 2016-03-31
 */
@MyBatisDao
public interface ApproveConfigDao extends CrudDao<ApproveConfig> {
	
	public void updateFlag(ApproveConfig approveConfig);
	
	public ApproveConfig getByType(String businessType,String businessStatus);
}