/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.ei;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.ei.Employee;

/**
 * 员工信息表DAO接口
 * @author 陈适
 * @version 2015-12-08
 */
@MyBatisDao
public interface EmployeeDao extends CrudDao<Employee> {

	public Employee findEmployeeByUserId(Employee userInfo);
	
}