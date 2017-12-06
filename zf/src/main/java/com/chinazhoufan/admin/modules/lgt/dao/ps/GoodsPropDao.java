/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;

/**
 * 商品属性表DAO接口
 * @author 陈适
 * @version 2015-10-20
 */
@MyBatisDao
public interface GoodsPropDao extends CrudDao<GoodsProp> {

	/***
	 * 保存商品属性集合
	 * @param lgtPsGoodsProp
	 */
	public void save(List<GoodsProp> goodsProp);

	public List<GoodsProp> getGoodsId(String goodsId);
	
	public List<GoodsProp> findByGoodsId(String goodsId,String delFlag);
	
	/**
	 *  编辑商品时
	 * 新增商品属性
	 * @param goodsPropvalue
	 */
	public void saveGoodsProp(GoodsPropvalue goodsPropvalue);
	
	/**
	 * 获取唯一商品属性
	 * @param goodsId  商品id
	 * @param pid
	 * @return  唯一 商品属性
	 */
	public GoodsProp getGoodsPropByGoodIdAnPid(Map<String, Object>  map);

	public void updateDelFlag(Map<String, Object>  map);

	public List<GoodsProp> findByGoodsProp(GoodsProp goodsProp);
	
	public void remove(String goodsId);
	
	/**
	 * 根据商品属性主键ID真删除属性记录
	 * @param goodsProp
	 */
	public void removeById(GoodsProp goodsProp);
	
}