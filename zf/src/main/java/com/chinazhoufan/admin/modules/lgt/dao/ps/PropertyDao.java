/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;

/**
 * 属性表DAO接口
 * @author 杨晓辉
 * @version 2015-10-13
 */
@MyBatisDao
public interface PropertyDao extends CrudDao<Property> {
	
	/**
	 * 保存属性和分类的关联关系
	 * @param cid
	 * @param pid
	 */
	public void insertCategoryProp(String cid,String pid);
	
	/**
	 * 真删除分类关系
	 * @param pid
	 */
	public void deleteCategoryProp(String pid);
	
	public List<Property> findPropertyAll(String propertyDelFlag, String propvalueDelFlag);
	
	/**
	 * 查询所有属性（根据条件）for Api
	 * @param property
	 * @return
	 */
	public List<Property> findListData(Property property);
	
	/**
	 * 根据是否筛选可用状态  列出所有属性及对应的属性值
	 * @param property
	 * @return
	 */
	public List<Property> listAllPropertyWithPropValueByFilterFlag(Property property);
	
}