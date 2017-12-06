/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsResource;

/**
 * 商品资源DAO接口
 * @author 陈适
 * @version 2015-10-27
 */
@MyBatisDao
public interface GoodsResourceDao extends CrudDao<GoodsResource> {
	
	public List<GoodsResource> findByGoodsId(String goodsId);
	
	public void remove(String goodsId);

	public List<GoodsResource> findListByGoodsId(GoodsResource resource);
}