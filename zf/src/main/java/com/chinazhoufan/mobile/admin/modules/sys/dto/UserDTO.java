/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.sys.dto;

import java.io.Serializable;


/**
 * 用户DTO
 * @author 张金俊
 * @version 2016-10-13
 */
public class UserDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String id;			// ID
	private String loginName;	// 登录名
	private String name;		// 姓名
	
	
	public UserDTO() {
		super();
	}

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}