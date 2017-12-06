/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity.ap;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 审批设置Entity
 * @author 贾斌
 * @version 2016-03-31
 */
public class ApproveConfig extends DataEntity<ApproveConfig> {
	
	private static final long serialVersionUID = 1L;
	private String approveName;		// 审批流程别名
	private String businessType;		// 审批业务类型     bas_ap_approve_businessType 
	private String businessStatus;		// 审批业务状态节点    bas_ap_approve_businessStatus
	private User approveUser;		// 审批人
	private String usableFlag;		// 是否开启
	
	// 审批业务类型     bas_ap_approve_businessType 
	public static final String BUSINESSTYPE_PURCHASE = "0";//采购审批
	public static final String BUSINESSTYPE_DISPATCH = "1";//调拨审批
	
	// 审批业务状态节点    bas_ap_approve_businessStatus
	public static final String BUSINESSSTATUS_PURCHASE_NEW = "11";//采购新建
	public static final String BUSINESSSTATUS_PURCHASE_EXECUTE = "12";//采购执行
	
	public static final String BUSINESSSTATUS_DISPATCH_NEW = "21";//调拨新建
	public static final String BUSINESSSTATUS_DISPATCH_EXECUTE = "22";//调拨执行
	
	
	public ApproveConfig() {
		super();
	}

	public ApproveConfig(String id){
		super(id);
	}

	@Length(min=1, max=50, message="审批流程别名长度必须介于 1 和 50 之间")
	public String getApproveName() {
		return approveName;
	}

	public void setApproveName(String approveName) {
		this.approveName = approveName;
	}
	
	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	
	public String getBusinessStatus() {
		return businessStatus;
	}

	public void setBusinessStatus(String businessStatus) {
		this.businessStatus = businessStatus;
	}
	
	public User getApproveUser() {
		return approveUser;
	}

	public void setApproveUser(User approveUser) {
		this.approveUser = approveUser;
	}

	@Length(min=1, max=1, message="是否开启长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}