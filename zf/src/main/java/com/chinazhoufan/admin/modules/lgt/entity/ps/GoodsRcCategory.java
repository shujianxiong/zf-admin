/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品推荐分类表Entity
 * @author 刘晓东
 * @version 2016-05-17
 */
public class GoodsRcCategory extends DataEntity<GoodsRcCategory> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;		// 商品ID
	private Categories rcCategory;		// 推荐分类ID
	
	public GoodsRcCategory() {
		super();
	}

	public GoodsRcCategory(String id){
		super(id);
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Categories getRcCategory() {
		return rcCategory;
	}

	public void setRcCategory(Categories rcCategory) {
		this.rcCategory = rcCategory;
	}

}