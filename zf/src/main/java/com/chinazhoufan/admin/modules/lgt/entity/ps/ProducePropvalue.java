/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 产品组合属性值Entity
 * @author 陈适
 * @version 2015-10-22
 */
public class ProducePropvalue extends DataEntity<ProducePropvalue> {
	
	private static final long serialVersionUID = 1L;
	private Produce produce;		// 产品
	private Property property;		// 属性
	private Propvalue propvalue;	// 属性值
	private String pvalue;			// 输入值
	private String titleFlag;			// 对应lgt_ps_property.title_flag，2017-9-20新增，用于是否组装产品展示标题

	public ProducePropvalue() {
	}

	public ProducePropvalue(String id){
		super(id);
	}

	@NotEmpty(message="产品不能为空")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	@Length(min=0, max=255, message="pvalue长度必须介于 0 和 255 之间")
	public String getPvalue() {
		return pvalue;
	}

	public void setPvalue(String pvalue) {
		this.pvalue = pvalue;
	}

	@NotEmpty(message="属性不能为空")
	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public Propvalue getPropvalue() {
		return propvalue;
	}

	public void setPropvalue(Propvalue propvalue) {
		this.propvalue = propvalue;
	}

	public String getTitleFlag() {
		return titleFlag;
	}

	public void setTitleFlag(String titleFlag) {
		this.titleFlag = titleFlag;
	}
}