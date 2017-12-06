/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.ei;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.ei.Resign;

/**
 * 员工离职记录DAO接口
 * @author 陈适
 * @version 2015-12-09
 */
@MyBatisDao
public interface ResignDao extends CrudDao<Resign> {
	
}