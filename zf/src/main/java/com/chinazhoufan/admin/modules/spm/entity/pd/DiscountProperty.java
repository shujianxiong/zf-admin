/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pd;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 产品筛选属性Entity
 * @author liut
 * @version 2017-07-04
 */
public class DiscountProperty extends DataEntity<DiscountProperty> {
	
	private static final long serialVersionUID = 1L;
	private Discount discount;		// 产品筛选促销ID
	private String pid;		// 属性ID
	
	//****************************** 组装参数 ****************************************/
	private List<DiscountPropvalue> discountPropvalueList = Lists.newArrayList();
	
	
	public DiscountProperty() {
		super();
	}

	public DiscountProperty(String id){
		super(id);
	}

	@Length(min=1, max=64, message="产品筛选促销ID长度必须介于 1 和 64 之间")
	public Discount getDiscount() {
		return discount;
	}

	public void setDiscount(Discount discount) {
		this.discount = discount;
	}
	
	@Length(min=1, max=64, message="属性ID长度必须介于 1 和 64 之间")
	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public List<DiscountPropvalue> getDiscountPropvalueList() {
		return discountPropvalueList;
	}

	public void setDiscountPropvalueList(
			List<DiscountPropvalue> discountPropvalueList) {
		this.discountPropvalueList = discountPropvalueList;
	}
	
}