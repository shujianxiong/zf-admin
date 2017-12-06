/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.service.at;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.hrm.dao.at.AttendanceDao;
import com.chinazhoufan.admin.modules.hrm.entity.at.Attendance;

/**
 * 员工考勤记录表Service
 * @author 刘晓东
 * @version 2015-11-17
 */
@Service
@Transactional(readOnly = true)
public class AttendanceService extends CrudService<AttendanceDao, Attendance> {

	public Attendance get(String id) {
		return super.get(id);
	}
	
	public List<Attendance> findList(Attendance attendance) {
		return super.findList(attendance);
	}
	
	public Page<Attendance> findPage(Page<Attendance> page, Attendance attendance) {
		return super.findPage(page, attendance);
	}
	
	@Transactional(readOnly = false)
	public void save(Attendance attendance) {
		super.save(attendance);
	}
	
	@Transactional(readOnly = false)
	public void delete(Attendance attendance) {
		super.delete(attendance);
	}
	
}