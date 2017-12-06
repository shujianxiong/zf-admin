/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 用户DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {
	
	/**
	 * 根据登录名称查询用户
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(User user);
	/**
	 * 根据工号查询用户
	 * @param no
	 * @return
	 */
	public User getByNo(@Param("no") String no);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 * @param user
	 * @return
	 */
	public List<User> findUserByOfficeId(User user);
	
	/**
	 * 获取所有用户
	 * @param user
	 * @return
	 */
	public List<User> findUserAll(User user);
	
	/**
	 * 查询全部用户数目
	 * @return
	 */
	public long findAllCount(User user);
	
	/**
	 * 根据角色集合获取拥有其中一个角色的所有用户
	 * @param roles	角色集合
	 * @return
	 */
	public List<User> findByRoles(@Param("roles") List<Role> roles);
	
	/**
	 * 更新用户密码
	 * @param user
	 * @return
	 */
	public int updatePasswordById(User user);
	
	/**
	 * 更新登录信息，如：登录IP、登录时间
	 * @param user
	 * @return
	 */
	public int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 * @param user
	 * @return
	 */
	public int deleteUserRole(User user);
	
	/**
	 * 插入用户角色关联数据
	 * @param user
	 * @return
	 */
	public int insertUserRole(User user);
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	public int updateUserInfo(User user);
	
	/**
	 * 根据供应商登录界面提供的账号和密码来判断是否登录成功
	 * @param user
	 * @return
	 */
	public User getByLoginNameForSupplier(User user);
	
	/**
	 * 获取最近一个用户，得到最新的用户工号
	 * @return
	 */
	public User getLatestUser();
	
	/**
	 * 根据登录账号名称，来判断，是否唯一（不区分系统用户或者供应商用户）
	 * @param loginName
	 * @return
	 */
	public User getUniqueUserByLoginName(String loginName);
	
	/**
	 * 获取供应商账号时，同时抓取出账号管理的供应商名称
	 * @return
	 */
	public List<User> findUserWithSupplier(User user);
	
	/**
	 * 更新用户的登录后台或者APP权限flag状态
	 * @param user
	 * @return
	 */
	public int changeFlag(User user);
	
	/**
	 * 根据指定角色的英文名称获取该角色下的人员列表
	 * @param role
	 * @return
	 */
	public List<User> listUserByRole(Role role);
	
	
	
	
	
}
