/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.Role;

/**
 * 角色DAO接口
 * @author ThinkGem
 * @version 2013-12-05
 */
@MyBatisDao
public interface RoleDao extends CrudDao<Role> {

	public Role getByName(Role role);
	
	public Role getByEnname(Role role);

	/**
	 * 通过权限标识，查找拥有某权限的所有角色
	 * @param permission
	 * @return
	 */
	public List<Role> findByPermission(String permission);
	
	/**
	 * 维护角色与菜单权限关系
	 * @param role
	 * @return
	 */
	public int deleteRoleMenu(Role role);

	public int insertRoleMenu(Role role);
	
	/**
	 * 维护角色与公司部门关系
	 * @param role
	 * @return
	 */
	public int deleteRoleOffice(Role role);

	public int insertRoleOffice(Role role);

	/**
	 * 根据用户ID和角色英文名称来判断改用户是否拥有该角色的权限
	 * @param usreId
	 * @param enName
	 * @return
	 */
	public Role getRoleByUserIdAndRoleEnName(String usreId);
	
	/**
	 * 更新角色启用状态
	 * @param role  
	 * @throws
	 */
	public void updateUseableByRole(Role role);
	
	/**
	 * 根据角色判断是否有指定权限的访问权限
	 * @param roleId
	 * @param permission
	 * @return    设定文件
	 * @throws
	 */
	public int isApprovePermission(@Param("roleId")String roleId, @Param("permission")String permission);
}
