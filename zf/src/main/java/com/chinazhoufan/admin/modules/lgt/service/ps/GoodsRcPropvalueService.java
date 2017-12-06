/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsRcPropvalueDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsRcPropvalue;

/**
 * 商品推荐属性值表Service
 * @author 刘晓东
 * @version 2016-05-17
 */
@Service
@Transactional(readOnly = true)
public class GoodsRcPropvalueService extends CrudService<GoodsRcPropvalueDao, GoodsRcPropvalue> {

	public GoodsRcPropvalue get(String id) {
		return super.get(id);
	}
	
	public List<GoodsRcPropvalue> findList(GoodsRcPropvalue goodsRcPropvalue) {
		return super.findList(goodsRcPropvalue);
	}
	
	public Page<GoodsRcPropvalue> findPage(Page<GoodsRcPropvalue> page, GoodsRcPropvalue goodsRcPropvalue) {
		return super.findPage(page, goodsRcPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void save(GoodsRcPropvalue goodsRcPropvalue) {
		super.save(goodsRcPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsRcPropvalue goodsRcPropvalue) {
		super.delete(goodsRcPropvalue);
	}
	
}