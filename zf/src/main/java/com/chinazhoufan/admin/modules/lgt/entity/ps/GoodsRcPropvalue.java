/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品推荐属性值表Entity
 * @author 刘晓东
 * @version 2016-05-17
 */
public class GoodsRcPropvalue extends DataEntity<GoodsRcPropvalue> {
	
	private static final long serialVersionUID = 1L;
	private GoodsRcProp goodsRcProp;		// 商品推荐属性ID
	private Propvalue propvalue;		// 属性值ID
	private String pvalue;		// 属性值
	
	public GoodsRcPropvalue() {
		super();
	}

	public GoodsRcPropvalue(String id){
		super(id);
	}

	public GoodsRcProp getGoodsRcProp() {
		return goodsRcProp;
	}

	public void setGoodsRcProp(GoodsRcProp goodsRcProp) {
		this.goodsRcProp = goodsRcProp;
	}

	public Propvalue getPropvalue() {
		return propvalue;
	}

	public void setPropvalue(Propvalue propvalue) {
		this.propvalue = propvalue;
	}

	@Length(min=0, max=255, message="属性值长度必须介于 0 和 255 之间")
	public String getPvalue() {
		return pvalue;
	}

	public void setPvalue(String pvalue) {
		this.pvalue = pvalue;
	}
	
}