/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.at;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.at.Attendance;

/**
 * 员工考勤记录表DAO接口
 * @author 刘晓东
 * @version 2015-11-17
 */
@MyBatisDao
public interface AttendanceDao extends CrudDao<Attendance> {
	
}