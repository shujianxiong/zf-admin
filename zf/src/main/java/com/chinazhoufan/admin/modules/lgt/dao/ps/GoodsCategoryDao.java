/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsCategory;

/**
 * 商品分类管理DAO接口
 * @author 陈适
 * @version 2015-10-14
 */
@MyBatisDao
public interface GoodsCategoryDao extends CrudDao<GoodsCategory> {
	
	public int insertList(List<GoodsCategory> categoryList);
	
	public void deleteGoodsId(String gid);
}