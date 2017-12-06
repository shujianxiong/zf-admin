/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.sys.dao;


import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 采购单DAO接口
 * @author 张金俊
 * @version 2015-10-16
 */
@MyBatisDao
public interface WapUserDao extends CrudDao<User> {
	
	/**
	 * 根据登录名获取用户
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(String loginName);
	
	/**
	 * 获取全部用户包含角色信息
	 * @return    设定文件
	 * @throws
	 */
	public List<User> listAllUser();
	
	
	/**
	 * 根据角色查询用户列表
	 * @return
	 */
	public List<User> listUserByRole(Role role);
	
}