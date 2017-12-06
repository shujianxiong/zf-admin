/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 属性值Entity
 * @author 杨晓辉
 * @version 2015-10-14
 */
public class Propvalue extends DataEntity<Propvalue> {
	
	private static final long serialVersionUID = 1L;
	private Property property;		// 属性
	private String pvalueName;		// 属性值
	private String pvalueNickname;	// 属性值别名（前端展示用）
	private int orderNo;			// 排序序号
	
	
	public Propvalue() {
		super();
	}

	public Propvalue(String id){
		super(id);
	}
	
	
	@Length(min=0, max=255, message="属性值长度必须介于 0 和 255 之间")
	public String getPvalueName() {
		return pvalueName;
	}

	public void setPvalueName(String pvalueName) {
		this.pvalueName = pvalueName;
	}
	
	public String getPvalueNickname() {
		return pvalueNickname;
	}

	public void setPvalueNickname(String pvalueNickname) {
		this.pvalueNickname = pvalueNickname;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	@NotEmpty(message="属性不能为空")
	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

}