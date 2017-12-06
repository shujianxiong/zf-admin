/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;

/**
 * 产品属性值DAO接口
 * @author 杨晓辉
 * @version 2015-10-14
 */
@MyBatisDao
public interface PropvalueDao extends CrudDao<Propvalue> {
	
	public List<Propvalue> findPropvaluesByPropertyId(Property lgtPsProperty);
	
	/**
	 * 根据属性ID真删除所有属性值
	 * @param pid
	 */
	public void deleteLgtPsPropvalueByPropertyId(String pid);
	
	public Propvalue findPsPropvalueByName(String id,String pvalueName);

	/**
	 * 保存商品属性值列表
	 * @param values	
	 */
	public int saveValues(List<Propvalue> values);
	
}