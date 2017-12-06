/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.google.common.collect.Lists;

/**
 * 货屉列表Entity
 * @author 贾斌
 * @version 2015-10-15
 */
public class Warecounter extends DataEntity<Warecounter> {
	
	private static final long serialVersionUID = 1L;
	private Warearea warearea;			// 所属货架
	private String code;				// 编码
	private Supplier supplier;          // 归属供应商
	private Categories category;      	// 归属分类
	private String usableFlag;			// 是否启用
	
	private List<Wareplace> wareplacesList = Lists.newArrayList();	// 货位
	
	
	
	/** 构造 */
	public Warecounter() {
		super();
	}

	public Warecounter(String id){
		super(id);
	}
	
	public Warecounter(Warearea warearea) {
		this.warearea = warearea;
	}
	
	public Warecounter(Warearea warearea, String code, String usableFlag) {
		super();
		this.warearea = warearea;
		this.code = code;
		this.usableFlag = usableFlag;
	}
	
	/** 方法 */
	@NotBlank(message="货屉编码不能为空")
	@Length(min=1, max=20, message="货屉编码长度必须介于 1 和 20 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Warearea getWarearea() {
		return warearea;
	}

	public void setWarearea(Warearea warearea) {
		this.warearea = warearea;
	}
	
	public List<Wareplace> getWareplacesList() {
		return wareplacesList;
	}

	public void setWareplacesList(List<Wareplace> wareplacesList) {
		this.wareplacesList = wareplacesList;
	}

	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}
	
}