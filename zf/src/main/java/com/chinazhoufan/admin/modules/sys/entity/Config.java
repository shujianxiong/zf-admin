/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 系统业务参数表Entity
 * @author 刘晓东
 * @version 2015-12-21
 */
public class Config extends DataEntity<Config> {
	
	private static final long serialVersionUID = 1L;
	private String code;			// 参数编码
	private String configType;		// 参数类型（1系统/2业务）
	private String configValue;		// 参数值
	private String description;		// 参数说明
	
	public Config() {
		super();
	}

	public Config(String id){
		super(id);
	}

	@Length(min=1, max=50, message="参数编码长度必须介于 1 和 50 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=1, max=2, message="参数类型（1系统/2业务）长度必须介于 1 和 2 之间")
	public String getConfigType() {
		return configType;
	}

	public void setConfigType(String configType) {
		this.configType = configType;
	}
	
	@Length(min=1, max=100, message="参数值长度必须介于 1 和 100 之间")
	public String getConfigValue() {
		return configValue;
	}

	public void setConfigValue(String configValue) {
		this.configValue = configValue;
	}
	
	@Length(min=0, max=200, message="参数说明长度必须介于 0 和 200 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}