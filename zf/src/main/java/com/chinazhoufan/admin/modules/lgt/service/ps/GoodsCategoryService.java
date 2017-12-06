/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsCategoryDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsCategory;

/**
 * 商品表Service
 * @author 张金俊
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class GoodsCategoryService extends CrudService<GoodsCategoryDao, GoodsCategory> {

	@Autowired
	private GoodsCategoryDao cateGoryDao;
	
	
	@Transactional(readOnly = false)
	public void save(List<GoodsCategory> categoryList) {
		cateGoryDao.insertList(categoryList);
	}
	
	@Transactional(readOnly = false)
	public void deleteGoodsId(String gId){
		cateGoryDao.deleteGoodsId(gId);
	}
}