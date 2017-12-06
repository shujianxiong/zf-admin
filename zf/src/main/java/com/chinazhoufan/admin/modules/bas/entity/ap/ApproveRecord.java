/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity.ap;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 审批记录Entity
 * @author 贾斌
 * @version 2016-03-31
 */
public class ApproveRecord extends DataEntity<ApproveRecord> {
	
	private static final long serialVersionUID = 1L;
	private ApproveConfig approveConfig;		// 审批配置项ID
	private BasMission basMission;		// 任务ID
	private String missionCode;		// 任务编号
	private String businessType;		// 业务类型
	private String preBusinessStatus;		// 审批前业务状态值
	private String postBusinessStatus;		// 审批后业务状态值
	private String preApproveStatus;		// 审批前审批状态值
	private String postApproveStatus;		// 审批后审批状态值
	private User approveUser;		// 审批人
	private String approveRemarks;		// 审批备注
	
	public ApproveRecord() {
		super();
	}

	public ApproveRecord(String id){
		super(id);
	}

	@Length(min=1, max=2, message="业务类型长度必须介于 1 和 2 之间")
	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	
	
	@Length(min=1, max=100, message="任务编号长度必须介于 1 和 100 之间")
	public String getMissionCode() {
		return missionCode;
	}

	public void setMissionCode(String missionCode) {
		this.missionCode = missionCode;
	}
	
	@Length(min=1, max=2, message="审批前业务状态值长度必须介于 1 和 2 之间")
	public String getPreBusinessStatus() {
		return preBusinessStatus;
	}

	public void setPreBusinessStatus(String preBusinessStatus) {
		this.preBusinessStatus = preBusinessStatus;
	}
	
	@Length(min=1, max=2, message="审批后业务状态值长度必须介于 1 和 2 之间")
	public String getPostBusinessStatus() {
		return postBusinessStatus;
	}

	public void setPostBusinessStatus(String postBusinessStatus) {
		this.postBusinessStatus = postBusinessStatus;
	}
	
	@Length(min=1, max=2, message="审批前审批状态值长度必须介于 1 和 2 之间")
	public String getPreApproveStatus() {
		return preApproveStatus;
	}

	public void setPreApproveStatus(String preApproveStatus) {
		this.preApproveStatus = preApproveStatus;
	}
	
	@Length(min=1, max=2, message="审批后审批状态值长度必须介于 1 和 2 之间")
	public String getPostApproveStatus() {
		return postApproveStatus;
	}

	public void setPostApproveStatus(String postApproveStatus) {
		this.postApproveStatus = postApproveStatus;
	}
	
	@Length(min=0, max=255, message="审批备注长度必须介于 0 和 255 之间")
	public String getApproveRemarks() {
		return approveRemarks;
	}

	public void setApproveRemarks(String approveRemarks) {
		this.approveRemarks = approveRemarks;
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

	public BasMission getBasMission() {
		return basMission;
	}

	public void setBasMission(BasMission basMission) {
		this.basMission = basMission;
	}
	
}