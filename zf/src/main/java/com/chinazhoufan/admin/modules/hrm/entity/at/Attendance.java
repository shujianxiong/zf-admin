/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.entity.at;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import org.hibernate.validator.constraints.Length;

/**
 * 员工考勤记录表Entity
 * @author 刘晓东
 * @version 2015-11-17
 */
public class Attendance extends DataEntity<Attendance> {
	
	private static final long serialVersionUID = 1L;
	private User sysUser;		// 员工ID
	private Date attendanceDate;		// 考勤日期
	private String attendanceType;		// 考勤类型
	private String attendanceTime;		// 考勤时间
	private String result;		// 考勤结果
	private String sourceType;		// 数据来源类型
	private String sourceDetail;		// 数据来源详情
	private Date beginAttendanceDate;		// 开始 考勤日期
	private Date endAttendanceDate;		// 结束 考勤日期
	
	public Attendance() {
		super();
	}

	public Attendance(String id){
		super(id);
	}

	@NotNull(message="员工ID不能为空")
	public User getSysUser() {
		return sysUser;
	}

	public void setSysUser(User sysUser) {
		this.sysUser = sysUser;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="考勤日期不能为空")
	public Date getAttendanceDate() {
		return attendanceDate;
	}

	public void setAttendanceDate(Date attendanceDate) {
		this.attendanceDate = attendanceDate;
	}
	
	@Length(min=1, max=2, message="考勤类型长度必须介于 1 和 2 之间")
	public String getAttendanceType() {
		return attendanceType;
	}

	public void setAttendanceType(String attendanceType) {
		this.attendanceType = attendanceType;
	}
	
	public String getAttendanceTime() {
		return attendanceTime;
	}

	public void setAttendanceTime(String attendanceTime) {
		this.attendanceTime = attendanceTime;
	}
	
	@Length(min=1, max=2, message="考勤结果长度必须介于 1 和 2 之间")
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	@Length(min=0, max=2, message="数据来源类型长度必须介于 0 和 2 之间")
	public String getSourceType() {
		return sourceType;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	
	@Length(min=0, max=64, message="数据来源详情长度必须介于 0 和 64 之间")
	public String getSourceDetail() {
		return sourceDetail;
	}

	public void setSourceDetail(String sourceDetail) {
		this.sourceDetail = sourceDetail;
	}
	
	public Date getBeginAttendanceDate() {
		return beginAttendanceDate;
	}

	public void setBeginAttendanceDate(Date beginAttendanceDate) {
		this.beginAttendanceDate = beginAttendanceDate;
	}
	
	public Date getEndAttendanceDate() {
		return endAttendanceDate;
	}

	public void setEndAttendanceDate(Date endAttendanceDate) {
		this.endAttendanceDate = endAttendanceDate;
	}
		
}