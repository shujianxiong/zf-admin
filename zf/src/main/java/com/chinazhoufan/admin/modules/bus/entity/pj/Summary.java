/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.pj;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 评价摘要Entity
 * @author liut
 * @version 2017-07-28
 */
public class Summary extends DataEntity<Summary> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 类型（商品、服务、物流）  bus_pj_summary_type
	private String level;		// 所属等级  bus_pj_produce_judge_level
	private String name;		// 名称
	private String activeFlag;		// 启用状态
	private String orderNo;		// 排序
	
	/******************************************** 自定义常量  *********************************************/
	public static final String TYPE_GOODS    = "goods";			    // 商品评价
	public static final String TYPE_SERVICE  = "service";			// 服务评价
	public static final String TYPE_EXPRESS  = "express";			// 物流评价
	
	
	
	
	public Summary() {
		super();
	}

	public Summary(String id){
		super(id);
	}

	@Length(min=1, max=50, message="类型长度必须介于 1 和 50 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=2, message="所属等级长度必须介于 1 和 2 之间")
	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
	@Length(min=1, max=50, message="名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	
	@Length(min=0, max=11, message="排序长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
}