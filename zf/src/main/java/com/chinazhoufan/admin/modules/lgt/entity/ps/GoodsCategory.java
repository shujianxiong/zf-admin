/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品分类管理Entity
 * @author 杨晓辉
 * @version 2015-10-14
 */
public class GoodsCategory extends DataEntity<GoodsCategory> {
	
	private static final long serialVersionUID = 1L;
	private Categories category;		// 分类ID
	private Goods goods;		// 商品ID
	private String apcid;		// 所有父分类ID
	
	
	public GoodsCategory() {
		super();
	}
	public GoodsCategory(String cid, String goodsId, String apcid) {
		this.category = new Categories();
		this.goods = new Goods();
		this.apcid = apcid;
	}

	public GoodsCategory(String id){
		super(id);
	}
	
	@NotEmpty(message="商品分类不能为空")
	public Categories getCategory() {
		return category;
	}
	
	public void setCategory(Categories category) {
		this.category = category;
	}
	
	@NotEmpty(message="商品不能为空")
	public Goods getGoods() {
		return goods;
	}
	
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	@Length(min=1, max=2000, message="所有父分类ID长度必须介于 1 和 2000之间")
	public String getApcid() {
		return apcid;
	}
	public void setApcid(String apcid) {
		this.apcid = apcid;
	}
	
}