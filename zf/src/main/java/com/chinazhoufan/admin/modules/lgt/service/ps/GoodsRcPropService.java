/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsRcPropDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsRcProp;

/**
 * 商品推荐属性表Service
 * @author 刘晓东
 * @version 2016-05-17
 */
@Service
@Transactional(readOnly = true)
public class GoodsRcPropService extends CrudService<GoodsRcPropDao, GoodsRcProp> {

	public GoodsRcProp get(String id) {
		return super.get(id);
	}
	
	public List<GoodsRcProp> findList(GoodsRcProp goodsRcProp) {
		return super.findList(goodsRcProp);
	}
	
	public Page<GoodsRcProp> findPage(Page<GoodsRcProp> page, GoodsRcProp goodsRcProp) {
		return super.findPage(page, goodsRcProp);
	}
	
	@Transactional(readOnly = false)
	public void save(GoodsRcProp goodsRcProp) {
		super.save(goodsRcProp);
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsRcProp goodsRcProp) {
		super.delete(goodsRcProp);
	}
	
}