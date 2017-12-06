/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.entity.ei;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 员工离职记录Entity
 * @author 陈适
 * @version 2015-12-09
 */
public class Resign extends DataEntity<Resign> {
	
	private static final long serialVersionUID = 1L;
	private Employee employee;		// 员工
	private Date applyDate;		// 离职申请日期
	private String status;		// 离职状态
	private String reason;		// 离职原因
	private String approvalMsgZg;		// 主管领导审批意见
	private String approvalMsgBm;		// 部门领导审批意见
	private String approvalMsgZjl;		// 总经理审批意见
	private String approvalMsgDsz;		// 董事长审批意见
	private Date resignDate;		// 正式离职日期
	private String workRelayStatus;		// 工作交接状态
	private String suppliesRelayStatus;		// 办公用品交接状态
	private String salaryPayStatus;		// 薪资结算状态
	private String resignFileUrl1;		// 离职文件URL1
	private String resignFileUrl2;		// 离职文件URL2
	private String resignFileUrl3;		// 离职文件URL3
	
	public Resign() {
	}

	public Resign(String id){
		super(id);
	}
	
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="离职申请日期不能为空")
	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	
	@Length(min=1, max=2, message="离职状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=255, message="离职原因长度必须介于 1 和 255 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@Length(min=0, max=255, message="主管领导审批意见长度必须介于 0 和 255 之间")
	public String getApprovalMsgZg() {
		return approvalMsgZg;
	}

	public void setApprovalMsgZg(String approvalMsgZg) {
		this.approvalMsgZg = approvalMsgZg;
	}
	
	@Length(min=0, max=255, message="部门领导审批意见长度必须介于 0 和 255 之间")
	public String getApprovalMsgBm() {
		return approvalMsgBm;
	}

	public void setApprovalMsgBm(String approvalMsgBm) {
		this.approvalMsgBm = approvalMsgBm;
	}
	
	@Length(min=0, max=255, message="总经理审批意见长度必须介于 0 和 255 之间")
	public String getApprovalMsgZjl() {
		return approvalMsgZjl;
	}

	public void setApprovalMsgZjl(String approvalMsgZjl) {
		this.approvalMsgZjl = approvalMsgZjl;
	}
	
	@Length(min=0, max=255, message="董事长审批意见长度必须介于 0 和 255 之间")
	public String getApprovalMsgDsz() {
		return approvalMsgDsz;
	}

	public void setApprovalMsgDsz(String approvalMsgDsz) {
		this.approvalMsgDsz = approvalMsgDsz;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getResignDate() {
		return resignDate;
	}

	public void setResignDate(Date resignDate) {
		this.resignDate = resignDate;
	}
	
	@Length(min=0, max=2, message="工作交接状态长度必须介于 0 和 2 之间")
	public String getWorkRelayStatus() {
		return workRelayStatus;
	}

	public void setWorkRelayStatus(String workRelayStatus) {
		this.workRelayStatus = workRelayStatus;
	}
	
	@Length(min=0, max=2, message="办公用品交接状态长度必须介于 0 和 2 之间")
	public String getSuppliesRelayStatus() {
		return suppliesRelayStatus;
	}

	public void setSuppliesRelayStatus(String suppliesRelayStatus) {
		this.suppliesRelayStatus = suppliesRelayStatus;
	}
	
	@Length(min=0, max=2, message="薪资结算状态长度必须介于 0 和 2 之间")
	public String getSalaryPayStatus() {
		return salaryPayStatus;
	}

	public void setSalaryPayStatus(String salaryPayStatus) {
		this.salaryPayStatus = salaryPayStatus;
	}
	
	@Length(min=0, max=255, message="离职文件URL1长度必须介于 0 和 255 之间")
	public String getResignFileUrl1() {
		return resignFileUrl1;
	}

	public void setResignFileUrl1(String resignFileUrl1) {
		this.resignFileUrl1 = resignFileUrl1;
	}
	
	@Length(min=0, max=255, message="离职文件URL2长度必须介于 0 和 255 之间")
	public String getResignFileUrl2() {
		return resignFileUrl2;
	}

	public void setResignFileUrl2(String resignFileUrl2) {
		this.resignFileUrl2 = resignFileUrl2;
	}
	
	@Length(min=0, max=255, message="离职文件URL3长度必须介于 0 和 255 之间")
	public String getResignFileUrl3() {
		return resignFileUrl3;
	}

	public void setResignFileUrl3(String resignFileUrl3) {
		this.resignFileUrl3 = resignFileUrl3;
	}
	
}