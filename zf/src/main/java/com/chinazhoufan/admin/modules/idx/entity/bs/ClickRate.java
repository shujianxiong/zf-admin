/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.bs;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 频道场景点击量Entity
 * @author liut
 * @version 2016-11-28
 */
public class ClickRate extends DataEntity<ClickRate> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String timesClick;		// 点击次数
	
	public ClickRate() {
		super();
	}

	public ClickRate(String id){
		super(id);
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=11, message="点击次数长度必须介于 1 和 11 之间")
	public String getTimesClick() {
		return timesClick;
	}

	public void setTimesClick(String timesClick) {
		this.timesClick = timesClick;
	}
	
}