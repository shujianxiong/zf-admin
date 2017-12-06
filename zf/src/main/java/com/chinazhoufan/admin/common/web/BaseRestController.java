/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.web;

import javax.servlet.http.HttpServletRequest;

import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.mobile.admin.modules.sys.dto.UserDTO;


/**
 * Api控制器支持类
 * @author 张金俊
 * @version 2016-10-13
 */
public abstract class BaseRestController extends BaseController{

	/**
	 * 当前登录用户的UserDTO
	 */
	protected UserDTO currentUserDTO;
	
	/**
	 * 当前登录用户User
	 */
	protected User currentUser;
	
	
	// 获取当前登录用户的UserDTO
	protected UserDTO getUserDTO(HttpServletRequest request){
		return (UserDTO)request.getSession().getAttribute("userDTO");
	}

	// 获取当前登录用户User
	protected User getUser(HttpServletRequest request){
		UserDTO userDTO = this.getUserDTO(request);
		return new User(userDTO.getId());
	}
}
