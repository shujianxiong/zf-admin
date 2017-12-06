/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;

/**
 * 商品分类管理DAO接口
 * @author 杨晓辉
 * @version 2015-10-12
 */
@MyBatisDao
public interface CategoriesDao extends CrudDao<Categories> {
	
	public List<Categories> findByParentIdsLike(Categories category);
	
	public int updateParentIds(Categories category);
	
	public List<Categories> findListBySearch(Categories category);
	
	public List<Categories> findListByPropertyId(Property property);

	public List<Categories> findListBySearchKeyWorld(Map<String, Object> map);

	public List<Categories> findChildListById(Categories category);

	public List<Categories> findCategiryByIds(@Param(value = "ids")Set<String> ids, @Param(value = "delFlag")String delFlag);
	
}