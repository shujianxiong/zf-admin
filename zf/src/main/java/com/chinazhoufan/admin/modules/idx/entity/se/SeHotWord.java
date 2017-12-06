/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.se;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 搜索热词Entity
 * @author liut
 * @version 2016-11-09
 */
public class SeHotWord extends DataEntity<SeHotWord> {
	
	private static final long serialVersionUID = 1L;
	private String name;			// 热词名称
	private String type;			// 热词类型（商品场景范）
	private String relateKeywords;	// 关联关键词（,分割）
	private String orderNo;			// 排列序号
	private String clickNum;		// 点击量
	private String usableFlag;		// 是否启用
	
	
	public SeHotWord() {
		super();
	}

	public SeHotWord(String id){
		super(id);
	}

	
	@Length(min=1, max=50, message="热词名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="热词类型（商品场景范）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getRelateKeywords() {
		return relateKeywords;
	}

	public void setRelateKeywords(String relateKeywords) {
		this.relateKeywords = relateKeywords;
	}

	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=11, message="点击量长度必须介于 1 和 11 之间")
	public String getClickNum() {
		return clickNum;
	}

	public void setClickNum(String clickNum) {
		this.clickNum = clickNum;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}