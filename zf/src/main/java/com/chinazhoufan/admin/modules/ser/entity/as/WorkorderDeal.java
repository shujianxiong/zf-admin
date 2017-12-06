/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.as;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 售后工单处理Entity
 * @author liut
 * @version 2017-05-18
 */
public class WorkorderDeal extends DataEntity<WorkorderDeal> {
	
	private static final long serialVersionUID = 1L;
	private Workorder workorder;		// 工单ID
	private User appointedUser;		// 被指派人
	private Date requiredTime;		// 要求完成时间
	private String requiredDealtype;		// 要求处理方式
	
	//ser_as_workorder_deal_RequiredDealtype 售后工单处理要求处理方式
	public static final String  DEAL_TYPE_REISSUE = "1";   //补发货品
	
	
	//==========传递字段
	private User nextDealUser; //下一处理人
	
	
	public WorkorderDeal() {
		super();
	}

	public WorkorderDeal(String id){
		super(id);
	}

	@Length(min=1, max=64, message="工单ID长度必须介于 1 和 64 之间")
	public Workorder getWorkorder() {
		return workorder;
	}

	public void setWorkorder(Workorder workorder) {
		this.workorder = workorder;
	}
	
	@Length(min=1, max=64, message="被指派人长度必须介于 1 和 64 之间")
	public User getAppointedUser() {
		return appointedUser;
	}

	public void setAppointedUser(User appointedUser) {
		this.appointedUser = appointedUser;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="要求完成时间不能为空")
	public Date getRequiredTime() {
		return requiredTime;
	}

	public void setRequiredTime(Date requiredTime) {
		this.requiredTime = requiredTime;
	}
	
	@Length(min=1, max=200, message="要求处理方式长度必须介于 1 和 200 之间")
	public String getRequiredDealtype() {
		return requiredDealtype;
	}

	public void setRequiredDealtype(String requiredDealtype) {
		this.requiredDealtype = requiredDealtype;
	}

	public User getNextDealUser() {
		return nextDealUser;
	}

	public void setNextDealUser(User nextDealUser) {
		this.nextDealUser = nextDealUser;
	}
	
	
	
}