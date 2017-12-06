/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pd;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 产品筛选属性值表Entity
 * @author liut
 * @version 2017-07-04
 */
public class DiscountPropvalue extends DataEntity<DiscountPropvalue> {
	
	private static final long serialVersionUID = 1L;
	private DiscountProperty discountProperty;		// 产品筛选属性ID
	private String pvid;		// 属性值ID
	
	public DiscountPropvalue() {
		super();
	}

	public DiscountPropvalue(String id){
		super(id);
	}

	@Length(min=1, max=64, message="产品筛选属性ID长度必须介于 1 和 64 之间")
	public DiscountProperty getDiscountProperty() {
		return discountProperty;
	}

	public void setDiscountProperty(DiscountProperty discountProperty) {
		this.discountProperty = discountProperty;
	}
	
	@Length(min=1, max=64, message="属性值ID长度必须介于 1 和 64 之间")
	public String getPvid() {
		return pvid;
	}

	public void setPvid(String pvid) {
		this.pvid = pvid;
	}
	
}