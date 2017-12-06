/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.cap.entity.cc;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 资产设备变动记录Entity
 * @author 贾斌
 * @version 2015-12-08
 */
public class CapitalChange extends DataEntity<CapitalChange> {
	
	private static final long serialVersionUID = 1L;
	private Capital capital;			// 资产ID
	private String changeType;			// 变动类型（领取/收回）
	private String changeReasonType;	// 变动原因类型（入职/损坏/业务等）
	private String oldCapitalNo;		// 原固定资产编号
	private String oldNum;				// 原数量
	private User oldUseOffice;			// 原使用部门
	private String oldUsePlace;			// 原使用地点
	private User oldUseUser;			// 原使用员工ID
	private String oldCapitalStatus;	// 原资产状态
	private String oldUseStatus;		// 原使用状态
	private String newCapitalNo;		// 新固定资产编号
	private String newNum;				// 新数量
	private User newUseOffice;			// 新使用部门
	private String newUsePlace;			// 新使用地点
	private User newUseUser;			// 新使用员工ID
	private String newCapitalStatus;	// 新资产状态
	private String newUseStatus;		// 新使用状态
	
	public CapitalChange() {
		super();
	}

	public CapitalChange(String id){
		super(id);
	}

	public Capital getCapital() {
		return capital;
	}

	public void setCapital(Capital capital) {
		this.capital = capital;
	}

	@Length(min=1, max=2, message="变动类型长度必须介于 1 和 2 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	@Length(min=1, max=2, message="变动原因类型长度必须介于 1 和 2 之间")
	public String getChangeReasonType() {
		return changeReasonType;
	}

	public void setChangeReasonType(String changeReasonType) {
		this.changeReasonType = changeReasonType;
	}

	@Length(min=1, max=50, message="原固定资产编号长度必须介于 1 和 50 之间")
	public String getOldCapitalNo() {
		return oldCapitalNo;
	}

	public void setOldCapitalNo(String oldCapitalNo) {
		this.oldCapitalNo = oldCapitalNo;
	}

	@Length(min=1, max=11, message="原数量长度必须介于 1 和 11 之间")
	public String getOldNum() {
		return oldNum;
	}

	public void setOldNum(String oldNum) {
		this.oldNum = oldNum;
	}

	public User getOldUseOffice() {
		return oldUseOffice;
	}

	public void setOldUseOffice(User oldUseOffice) {
		this.oldUseOffice = oldUseOffice;
	}

	@Length(min=1, max=50, message="原使用地点长度必须介于 1 和 50 之间")
	public String getOldUsePlace() {
		return oldUsePlace;
	}

	public void setOldUsePlace(String oldUsePlace) {
		this.oldUsePlace = oldUsePlace;
	}

	public User getOldUseUser() {
		return oldUseUser;
	}

	public void setOldUseUser(User oldUseUser) {
		this.oldUseUser = oldUseUser;
	}

	@Length(min=1, max=2, message="原资产状态长度必须介于 1 和 2 之间")
	public String getOldCapitalStatus() {
		return oldCapitalStatus;
	}

	public void setOldCapitalStatus(String oldCapitalStatus) {
		this.oldCapitalStatus = oldCapitalStatus;
	}

	@Length(min=1, max=2, message="原使用状态长度必须介于 1 和 2 之间")
	public String getOldUseStatus() {
		return oldUseStatus;
	}

	public void setOldUseStatus(String oldUseStatus) {
		this.oldUseStatus = oldUseStatus;
	}

	@Length(min=1, max=50, message="新固定资产编号长度必须介于 1 和 50 之间")
	public String getNewCapitalNo() {
		return newCapitalNo;
	}

	public void setNewCapitalNo(String newCapitalNo) {
		this.newCapitalNo = newCapitalNo;
	}

	@Length(min=1, max=11, message="新数量长度必须介于 1 和 11 之间")
	public String getNewNum() {
		return newNum;
	}

	public void setNewNum(String newNum) {
		this.newNum = newNum;
	}

	public User getNewUseOffice() {
		return newUseOffice;
	}

	public void setNewUseOffice(User newUseOffice) {
		this.newUseOffice = newUseOffice;
	}
	
	@Length(min=1, max=50, message="新使用地点长度必须介于 1 和 50 之间")
	public String getNewUsePlace() {
		return newUsePlace;
	}

	public void setNewUsePlace(String newUsePlace) {
		this.newUsePlace = newUsePlace;
	}

	public User getNewUseUser() {
		return newUseUser;
	}

	public void setNewUseUser(User newUseUser) {
		this.newUseUser = newUseUser;
	}

	@Length(min=1, max=2, message="新资产状态长度必须介于 1 和 2 之间")
	public String getNewCapitalStatus() {
		return newCapitalStatus;
	}

	public void setNewCapitalStatus(String newCapitalStatus) {
		this.newCapitalStatus = newCapitalStatus;
	}

	@Length(min=1, max=2, message="新使用状态长度必须介于 1 和 2 之间")
	public String getNewUseStatus() {
		return newUseStatus;
	}

	public void setNewUseStatus(String newUseStatus) {
		this.newUseStatus = newUseStatus;
	}

	
	
}