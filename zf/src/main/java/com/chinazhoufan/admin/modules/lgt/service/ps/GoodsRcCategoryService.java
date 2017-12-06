/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsRcCategoryDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsRcCategory;

/**
 * 商品推荐分类表Service
 * @author 刘晓东
 * @version 2016-05-17
 */
@Service
@Transactional(readOnly = true)
public class GoodsRcCategoryService extends CrudService<GoodsRcCategoryDao, GoodsRcCategory> {

	public GoodsRcCategory get(String id) {
		return super.get(id);
	}
	
	public List<GoodsRcCategory> findList(GoodsRcCategory goodsRcCategory) {
		return super.findList(goodsRcCategory);
	}
	
	public Page<GoodsRcCategory> findPage(Page<GoodsRcCategory> page, GoodsRcCategory goodsRcCategory) {
		return super.findPage(page, goodsRcCategory);
	}
	
	@Transactional(readOnly = false)
	public void save(GoodsRcCategory goodsRcCategory) {
		super.save(goodsRcCategory);
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsRcCategory goodsRcCategory) {
		super.delete(goodsRcCategory);
	}
	
}