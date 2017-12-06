/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ss;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

public class SendSms extends DataEntity<SendSms> {
	
	private static final long serialVersionUID = 1L;
	private String phone;		// 名称
	private String context;		// 简介
	private Date sendTime;		// 开始时间
	private String link;		// 链接
	private String parameter;		// 参数
	private Integer clickRate;		// 点击率
	private String status;      // 发送状态(0、成功 1、失败)
	
	private Date beginTime;			// 开始发送时间
	private Date endTime;			// 结束发送时间
	
	private String[] sendUserCodes ;
	public SendSms() {
		super();
	}

	public SendSms(String id){
		super(id);
	}

	@Length(min=1, max=32, message="名称长度必须介于 1 和 32 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Length(min=1, max=500, message="简介长度必须介于 1 和 500 之间")
	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开始时间不能为空")
	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getParameter() {
		return parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public Integer getClickRate() {
		return clickRate;
	}

	public void setClickRate(Integer clickRate) {
		this.clickRate = clickRate;
	}

	public String[] getSendUserCodes() {
		return sendUserCodes;
	}

	public void setSendUserCodes(String[] sendUserCodes) {
		this.sendUserCodes = sendUserCodes;
	}
	
}