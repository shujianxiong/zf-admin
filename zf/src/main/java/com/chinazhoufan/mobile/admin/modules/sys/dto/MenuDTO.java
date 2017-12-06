/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.sys.dto;


/**
 * 菜单Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
public class MenuDTO {

	private String permission;		// 权限标识
	private String permissionType;	// 权限类型（1：菜单 2：功能）
	private Integer todoNum;		// 待完成任务数量
	
	/********************************* 自定义常量  *********************************/
	public static final String PERMISSIONTYPE_MENU		= "1";
	public static final String PERMISSIONTYPE_OPERATION = "2";
	
	
	/** 构造函数 */
	public MenuDTO() {
		super();
	}

	public MenuDTO(String permission) {
		super();
		this.permission = permission;
	}
	
	public MenuDTO(String permission, Integer todoNum) {
		super();
		this.permission = permission;
		this.todoNum = todoNum;
	}
	
	
	/** 方法 */
	public String getPermission() {
		return permission;
	}
	
	public void setPermission(String permission) {
		this.permission = permission;
	}
	
	public String getPermissionType() {
		return permissionType;
	}

	public void setPermissionType(String permissionType) {
		this.permissionType = permissionType;
	}

	public Integer getTodoNum() {
		return todoNum;
	}
	
	public void setTodoNum(Integer todoNum) {
		this.todoNum = todoNum;
	}
	
}