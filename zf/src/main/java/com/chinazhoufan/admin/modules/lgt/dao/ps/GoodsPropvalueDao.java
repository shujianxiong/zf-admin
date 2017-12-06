/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;

/**
 * 商品属性值表管理DAO接口
 * @author 陈适
 * @version 2015-10-20
 */
@MyBatisDao
public interface GoodsPropvalueDao extends CrudDao<GoodsPropvalue> {
	
	
	public void save(List<GoodsPropvalue> goodsPropvalue);
	
	/**
	 * 根据商品属性id  查询该属性下的所有
	 * @param map
	 */
	public List<GoodsPropvalue> findGoodsPropVal(Map<String, Object> map);

	public void remove(String goodsPropId);
	
}