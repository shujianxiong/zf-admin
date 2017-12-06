/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.dao;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.Menu;

/**
 * 菜单DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);
	
	public List<Menu> findByPermission(String permission);
	
	
	public List<Menu> findByUserIdForWapLogin(Menu menu);
	
	public List<Menu> findByPermissionForWapLogin(String permission);
	
	
	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
	/**
	 * 根据上级菜单ID获取子集菜单
	 * @param menu
	 * @return
	 */
	public List<Menu> findByParentId(Menu menu);
	
	
}
