/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品属性值表管理Entity
 * @author 陈适
 * @version 2015-10-20
 */
public class GoodsPropvalue extends DataEntity<GoodsPropvalue> {
	
	private static final long serialVersionUID = 1L;
	private GoodsProp goodsProp;		// 商品属性ID
	private Propvalue propvalue;		// 属性值ID
	private String pvalue;		// 属性值
	
	public GoodsPropvalue() {
		super();
	}

	public GoodsPropvalue(String id){
		super(id);
	}
	
	@NotEmpty(message="商品属性不能为空")
	public GoodsProp getGoodsProp() {
		return goodsProp;
	}

	public void setGoodsProp(GoodsProp goodsProp) {
		this.goodsProp = goodsProp;
	}

	public Propvalue getPropvalue() {
		return propvalue;
	}

	public void setPropvalue(Propvalue propvalue) {
		this.propvalue = propvalue;
	}

	public String getPvalue() {
		return pvalue;
	}

	public void setPvalue(String pvalue) {
		this.pvalue = pvalue;
	}
	
	/** 编辑商品时用到 */
	private String pid;   // 属性id
	private String goodsId;	//商品id
	
	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
	
	
	
}