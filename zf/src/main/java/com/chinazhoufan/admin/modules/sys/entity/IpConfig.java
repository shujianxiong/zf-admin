/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * IP白名单管理Entity
 * @author 陈适
 * @version 2015-11-20
 */
public class IpConfig extends DataEntity<IpConfig> {
	
	private static final long serialVersionUID = 1L;
	private String ip;		// 白名单IP
	private String activeFlag;		// 启用标记 1 启用；0 关闭
	
	
	public IpConfig() {
	}

	public IpConfig(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	@Length(min=1, max=100, message="白名单IP长度必须介于 1 和 100 之间")
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
	@Length(min=1, max=1, message="启用标记长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	
}