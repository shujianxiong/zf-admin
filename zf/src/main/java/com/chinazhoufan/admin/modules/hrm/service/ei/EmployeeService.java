/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.service.ei;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.hrm.dao.ei.EmployeeDao;
import com.chinazhoufan.admin.modules.hrm.entity.ei.Employee;

/**
 * 员工信息表Service
 * @author 陈适
 * @version 2015-12-08
 */
@Service
@Transactional(readOnly = true)
public class EmployeeService extends CrudService<EmployeeDao, Employee> {

	public Employee get(String id) {
		return super.get(id);
	}
	
	public List<Employee> findList(Employee userInfo) {
		return super.findList(userInfo);
	}
	
	public Page<Employee> findPage(Page<Employee> page, Employee userInfo) {
		return super.findPage(page, userInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(Employee userInfo) {
		super.save(userInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Employee userInfo) {
		super.delete(userInfo);
	}

	public Employee findUserInfoByUserId(Employee userInfo) {
		return dao.findEmployeeByUserId(userInfo);
	}
	
}