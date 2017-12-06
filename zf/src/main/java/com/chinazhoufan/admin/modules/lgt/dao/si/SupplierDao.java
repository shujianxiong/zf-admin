/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.si;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;

/**
 * 供应商通讯录DAO接口
 * @author 张金俊
 * @version 2015-10-15
 */
@MyBatisDao
public interface SupplierDao extends CrudDao<Supplier> {
	/**
	 * 根据“是否启用”、“是否删除”的条件查询供应商
	 * @param activeFlag
	 * @return
	 */
	public List<Supplier> findListByActiveFlag(String activeFlag, String delFlag);
	
	/**
	 * 根据供应商是否启用，以及是否删除为条件来获取有效的且未绑定周范账号的供应商列表信息
	 * @param sysUserId
	 * @param activeFlag
	 * @param delFlag
	 * @return
	 */
	public List<Supplier> findActivitySupplierList(String activeFlag, String delFlag);
	
	/**
	 * 根据供应商关联的用户ID，获取对应的供应商信息
	 * @param userId
	 * @return
	 */
	public Supplier getSupplierByUserId(String userId);
	
	/**
	 * 更改供应商的启用状态
	 * @param supplier
	 */
	public void changeActiveFlag(Supplier supplier);

	/**
	 * 根据名称条件查询供应商
	 * @param name
	 * @return
	 */
	public Supplier getByName(String name);
}