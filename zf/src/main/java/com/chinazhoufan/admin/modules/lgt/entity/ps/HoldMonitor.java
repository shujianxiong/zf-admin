/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import java.util.List;

import com.google.common.collect.Lists;

/**
 * 货品持有监控管理Entity
 * @author 刘晓东
 * @version 2015-10-15
 */
public class HoldMonitor extends DataEntity<HoldMonitor> {
	
	private static final long serialVersionUID = 1L;
	private User responsibleBy;		// 责任员工
	private String resourceType;		// 来源类型（员工/仓库）
	private String resourceIdStr;		// 来源编号
	private Date receiveTime;		// 货品接收时间
	private Date limitTime;		// 要求移交时间
	private Date devolveTime;		// 实际移交时间
	private String holdStatus;		// 持货状态
	private Date beginReceiveTime;		// 开始 货品接收时间
	private Date endReceiveTime;		// 结束 货品接收时间
	private List<HoldMonitorDetail> holdMonitorDetailList = Lists.newArrayList();		// 子表列表
	
	public HoldMonitor() {
		super();
	}

	public HoldMonitor(String id){
		super(id);
	}

	public User getResponsibleBy() {
		return responsibleBy;
	}

	public void setResponsibleBy(User responsibleBy) {
		this.responsibleBy = responsibleBy;
	}

	@Length(min=1, max=2, message="来源类型（员工/仓库）长度必须介于 1 和 2 之间")
	public String getResourceType() {
		return resourceType;
	}

	public void setResourceType(String resourceType) {
		this.resourceType = resourceType;
	}
	
	public String getResourceIdStr() {
		return resourceIdStr;
	}

	public void setResourceIdStr(String resourceIdStr) {
		this.resourceIdStr = resourceIdStr;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="货品接收时间不能为空")
	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	
	public Date getLimitTime() {
		return limitTime;
	}

	public void setLimitTime(Date limitTime) {
		this.limitTime = limitTime;
	}

	public Date getDevolveTime() {
		return devolveTime;
	}

	public void setDevolveTime(Date devolveTime) {
		this.devolveTime = devolveTime;
	}

	@Length(min=1, max=2, message="持货状态长度必须介于 1 和 2 之间")
	public String getHoldStatus() {
		return holdStatus;
	}

	public void setHoldStatus(String holdStatus) {
		this.holdStatus = holdStatus;
	}
	
	public Date getBeginReceiveTime() {
		return beginReceiveTime;
	}

	public void setBeginReceiveTime(Date beginReceiveTime) {
		this.beginReceiveTime = beginReceiveTime;
	}
	
	public Date getEndReceiveTime() {
		return endReceiveTime;
	}

	public void setEndReceiveTime(Date endReceiveTime) {
		this.endReceiveTime = endReceiveTime;
	}

	public List<HoldMonitorDetail> getHoldMonitorDetailList() {
		return holdMonitorDetailList;
	}

	public void setHoldMonitorDetailList(
			List<HoldMonitorDetail> holdMonitorDetailList) {
		this.holdMonitorDetailList = holdMonitorDetailList;
	}
		
}