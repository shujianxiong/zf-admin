/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.entity.su;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 公众号订阅记录Entity
 * @author 张金俊
 * @version 2016-05-24
 */
public class SubscribeRecord extends DataEntity<SubscribeRecord> {
	
	private static final long serialVersionUID = 1L;
	private String publicid;		// 公众号id
	private String openid;			// 订阅用户openid
	private Date subscribeTime;		// 订阅时间
	private Date cancelTime;		// 退订时间
	
	public SubscribeRecord() {
		super();
	}

	public SubscribeRecord(String id){
		super(id);
	}

	@Length(min=1, max=100, message="公众号id长度必须介于 1 和 100 之间")
	public String getPublicid() {
		return publicid;
	}

	public void setPublicid(String publicid) {
		this.publicid = publicid;
	}
	
	@Length(min=1, max=100, message="订阅用户openid长度必须介于 1 和 100 之间")
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="订阅时间不能为空")
	public Date getSubscribeTime() {
		return subscribeTime;
	}

	public void setSubscribeTime(Date subscribeTime) {
		this.subscribeTime = subscribeTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCancelTime() {
		return cancelTime;
	}

	public void setCancelTime(Date cancelTime) {
		this.cancelTime = cancelTime;
	}
	
}