/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.mobile.admin.modules.sys.dao.WapUserDao;

/**
 * 移动端用户Service
 * @author 张金俊
 * @version 2016-10-14
 */
@Service
@Transactional(readOnly = true)
public class WapUserService extends CrudService<WapUserDao, User> {

	/**
	 * 根据登录名获取用户
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(String loginName) {
		return dao.getByLoginName(loginName);
	}
	
	/**
	 * 获取全部用户包含角色信息
	 * @return    设定文件
	 * @throws
	 */
	public List<User> listAllUser() {
		return dao.listAllUser();
	}
	
	/**
	 * 根据角色查询用户列表
	 * @return
	 */
	public List<User> listUserByRole(Role role) {
		return dao.listUserByRole(role);
	}
	
}