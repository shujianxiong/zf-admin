/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 商品属性表Entity
 * @author 陈适
 * @version 2015-10-20
 */
public class GoodsProp extends DataEntity<GoodsProp> {
	
	private static final long serialVersionUID = 1L;
	private Goods goods;		// 商品ID
	private Property property;		// 属性ID
	
	private List<GoodsPropvalue> goodsPropvalue=Lists.newArrayList(); //属性值集合
	
	public GoodsProp() {
		super();
	}

	public GoodsProp(Goods goods, Property property) {
		this.goods = goods;
		this.property = property;
	}

	public GoodsProp(String id){
		super(id);
	}
	@NotEmpty(message="属性不能为空")
	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	@NotEmpty(message="商品不能为空")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	public List<GoodsPropvalue> getGoodsPropvalue() {
		return goodsPropvalue;
	}

	public void setGoodsPropvalue(List<GoodsPropvalue> goodsPropvalue) {
		this.goodsPropvalue = goodsPropvalue;
	}
}