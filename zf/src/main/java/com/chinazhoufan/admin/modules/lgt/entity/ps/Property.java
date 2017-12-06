/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 属性表Entity
 * @author 杨晓辉
 * @version 2015-10-13
 */
public class Property extends DataEntity<Property> {
	
	private static final long serialVersionUID = 1L;
	private String propName;		// 属性名称
	private String propType;		// 属性类型（1：参数说明类	2：价格决策类）
	private String suitType;		// 适用范围（1：通用	2：采购	3：销售）
	private String valueType;		// 取值类型（1：单选	2：多选	3：输入）
	private String necessaryFlag;	// 是否必须项（0：否    	1：是  默认0）
	private String produceFlag; 	// 是否影响价格（0：否    	1：是  默认0）
	private String orderNo;			// 排序序号
	
	private String filterFlag;     	// 是否筛选可用（0：否	1：是）目前主要用来产品促销界面
	private String showFlag;     	// 是否前台展示（0：否	1：是）2017-9-19新增，用于是否在前台界面显示
	private String titleFlag;     	// 是否属于展示标题（0：否	1：是）2017-9-19新增，用于是否组装到“产品展示标题”中
	
	private List<Propvalue> propvalueList=Lists.newArrayList();	// 属性拥有的属性值
	private List<Categories> categoryList=Lists.newArrayList();	// 属性拥有的分类

	public static final String GOODS_PROPERTY_SELECT	= "1";	// 单选类型
	public static final String GOODS_PROPERTY_CHECKBOX	= "2";	// 多选类型
	public static final String GOODS_PROPERTY_INPUT		= "3";	// 输入类型
	
	public static final String PROPTYPE_DESCRIPTION = "1";      // 参数说明类
	public static final String PROPTYPE_DECISION = "2";         // 价格决策类
	
	/****************** 查询条件 ********************/
	private Categories category;//查询分类条件
	
	/************ 属性分类解析 前端选择器适用 ************/
	private String selectCategoryIds="";//属性具备的分类ID集合以,分割
	
	
	
	public Property() {
		super();
	}

	public Property(String id){
		super(id);
	}
	
	
	
	@NotEmpty(message="属性名称不能为空")
	@Length(min=1, max=100, message="属性名称长度必须介于 1 和 100 之间")
	public String getPropName() {
		return propName;
	}

	public void setPropName(String propName) {
		this.propName = propName;
	}
	
	@NotEmpty(message="属性类型不能为空")
	@Length(min=0, max=2, message="属性类型长度必须介于 0 和 2 之间")
	public String getPropType() {
		return propType;
	}

	public void setPropType(String propType) {
		this.propType = propType;
	}
	
	@NotEmpty(message="属性适用范围不能为空")
	@Length(min=0, max=2, message="适用范围（采购/销售/通用）长度必须介于 0 和 2 之间")
	public String getSuitType() {
		return suitType;
	}

	public void setSuitType(String suitType) {
		this.suitType = suitType;
	}
	
	@NotEmpty(message="取值类型不能为空")
	@Length(min=0, max=2, message="取值类型（单选/多选/填）长度必须介于 0 和 2 之间")
	public String getValueType() {
		return valueType;
	}

	public void setValueType(String valueType) {
		this.valueType = valueType;
	}
	
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	@NotEmpty(message="是否必须项不能为空")
	public String getNecessaryFlag() {
		return necessaryFlag;
	}
	
	public void setNecessaryFlag(String necessaryFlag) {
		this.necessaryFlag = necessaryFlag;
	}

	public List<Propvalue> getPropvalueList() {
		return propvalueList;
	}

	public void setPropvalueList(List<Propvalue> propvalueList) {
		this.propvalueList = propvalueList;
	}

	public List<Categories> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<Categories> categoryList) {
		this.categoryList = categoryList;
	}

	public String getProduceFlag() {
		return produceFlag;
	}

	public void setProduceFlag(String produceFlag) {
		this.produceFlag = produceFlag;
	}
	
	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}
	
	//********属性分类解析 前端选择器适用************//
	public String getSelectCategoryIds() {
		for(Categories category:getCategoryList()){
			selectCategoryIds=selectCategoryIds+category.getId()+",";
		}
		return selectCategoryIds;
	}

	public void setSelectCategoryIds(String selectCategoryIds) {
		categoryList=Lists.newArrayList();
		if (categoryList != null){
			String[] ids = StringUtils.split(selectCategoryIds, ",");
			for (String id : ids) {
				if(StringUtils.isBlank(id.trim()))
					continue;
				Categories category = new Categories();
				category.setId(id);
				categoryList.add(category);
			}
		}
		this.selectCategoryIds = selectCategoryIds;
	}

	public String getFilterFlag() {
		return filterFlag;
	}

	public void setFilterFlag(String filterFlag) {
		this.filterFlag = filterFlag;
	}

	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
	}

	public String getTitleFlag() {
		return titleFlag;
	}

	public void setTitleFlag(String titleFlag) {
		this.titleFlag = titleFlag;
	}
}