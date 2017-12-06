/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.se;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 搜索记录表Entity
 * @author liut
 * @version 2016-10-27
 */
public class SeSearchRecord extends DataEntity<SeSearchRecord> {
	
	private static final long serialVersionUID = 1L;
	private String keyword;		// 关键词名称
	private String type;		// 类型（商品场景范）
	private Integer searchNum;		// 搜索量
	
	public static final String TYPE_SCENE = "1";//场景
	public static final String TYPE_FAN = "2";//范儿
	public static final String TYPE_COLLOCATION = "3";//搭配
	public static final String TYPE_GOODS = "4";//商品
	
	public SeSearchRecord() {
		super();
	}

	public SeSearchRecord(String id){
		super(id);
	}

	@Length(min=1, max=50, message="关键词名称长度必须介于 1 和 50 之间")
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Length(min=1, max=2, message="类型（商品场景范）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@NotNull(message="搜索量不能为空")
	public Integer getSearchNum() {
		return searchNum;
	}

	public void setSearchNum(Integer searchNum) {
		this.searchNum = searchNum;
	}
	
}