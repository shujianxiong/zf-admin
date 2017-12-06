/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品推荐属性表Entity
 * @author 刘晓东
 * @version 2016-05-17
 */
public class GoodsRcProp extends DataEntity<GoodsRcProp> {
	
	private static final long serialVersionUID = 1L;
	private GoodsRcCategory goodsRcCategory;		// 商品推荐分类ID
	private Property property;		// 属性ID
	
	public GoodsRcProp() {
		super();
	}

	public GoodsRcProp(String id){
		super(id);
	}

	public GoodsRcCategory getGoodsRcCategory() {
		return goodsRcCategory;
	}

	public void setGoodsRcCategory(GoodsRcCategory goodsRcCategory) {
		this.goodsRcCategory = goodsRcCategory;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

}