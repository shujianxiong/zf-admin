/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 货架管理Entity
 * @author 贾斌
 * @version 2015-10-13
 */
public class Warearea extends DataEntity<Warearea> {
	
	private static final long serialVersionUID = 1L;
	private Warehouse warehouse;		// 所属仓库
	private String code;				// 编码
	private String type;				// 类型（正常/坏货）
	private Categories categories;		// 存放产品分类
	private String usableFlag;			// 是否启用
	
	private List<Warecounter> warecountersList	= Lists.newArrayList();	// 货屉
	
	/******************************************** 自定义常量  *********************************************/
	// 货架类型 lgt_ps_warearea_type
	public static final String TYPE_NORMAL		= "1";	// 正常
	public static final String TYPE_BROKEN		= "2";	// 坏货
	
	
	/** 构造 */
	public Warearea() {
		super();
	}

	public Warearea(String id){
		super(id);
	}
	
	public Warearea(Warehouse warehouse) {
		this.warehouse = warehouse;
	}
	
	
	/** 方法 */
	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Categories getCategories() {
		return categories;
	}

	public void setCategories(Categories categories) {
		this.categories = categories;
	}

	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
	public List<Warecounter> getWarecountersList() {
		return warecountersList;
	}
	
	public void setWarecountersList(List<Warecounter> warecountersList) {
		this.warecountersList = warecountersList;
	}
	
	
}