/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveConfig;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 任务表Entity
 * @author 刘晓东
 * @version 2015-10-22
 */
public class BasMission<T> extends DataEntity<T> {
	
	private static final long serialVersionUID = 1L;
	private String missionCode;
	private String businessType;	// 任务类型（物流调货/采购下单）bas_mission_business_type
	private String approveStatus;	// 审批状态(待审核,审核通过,审核拒绝)
	private ApproveConfig approveConfig;	// 审批配置项
	private User approveUser;	//审批人
	private User startBy;		// 发起人
	private Date startTime;		// 发起时间
	private Date limitTime;		// 要求完成时限
	private Integer delayCount; // 延期次数
	private Date endTime;		// 完成时间
	
	
	/*******************************************************/
	public static final String APPROVESTATUS_WAIT 	= "1"; 	// 待审核
	public static final String APPROVESTATUS_SUCCESS = "2"; 	// 审核通过
	public static final String APPROVESTATUS_REFUSE 	= "3"; 	// 审核拒绝
	
	public static final String APPROVESTATUS_PASS = "1";//已审核（包括申通通过，和审核拒绝）
	
	//已审核标志，添加此字段的原因是为了避免in查询, 默认为0，当为1时，代表启动此条件
	public String approveStatusPassFlag =  "0";
	
	
	//任务类型
	public static final String TYPE_DISPATCH="1"; //物流调货
	public static final String TYPE_PURCHASE="2"; //采购下单
	
	private T childMission;		// 子任务
	
	
	public BasMission() {
		super();
	}

	public BasMission(String id){
		super(id);
	}

	public String getMissionCode() {
		return missionCode;
	}

	public void setMissionCode(String missionCode) {
		this.missionCode = missionCode;
	}
	
	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}

	public String getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
	}

	public ApproveConfig getApproveConfig() {
		return approveConfig;
	}

	public void setApproveConfig(ApproveConfig approveConfig) {
		this.approveConfig = approveConfig;
	}

	public User getApproveUser() {
		return approveUser;
	}

	public void setApproveUser(User approveUser) {
		this.approveUser = approveUser;
	}

	public BasMission(User startBy) {
		this.startBy = startBy;
	}

	public T getChildMission() {
		return childMission;
	}

	public void setChildMission(T childMission) {
		this.childMission = childMission;
	}
	
	public Integer getDelayCount() {
		return delayCount;
	}

	public void setDelayCount(Integer delayCount) {
		this.delayCount = delayCount;
	}

	public User getStartBy() {
		return startBy;
	}

	public void setStartBy(User startBy) {
		this.startBy = startBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="发起时间不能为空")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}


	public Date getLimitTime() {
		return limitTime;
	}

	public void setLimitTime(Date limitTime) {
		this.limitTime = limitTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getApproveStatusPassFlag() {
		return approveStatusPassFlag;
	}

	public void setApproveStatusPassFlag(String approveStatusPassFlag) {
		this.approveStatusPassFlag = approveStatusPassFlag;
	}

	
}