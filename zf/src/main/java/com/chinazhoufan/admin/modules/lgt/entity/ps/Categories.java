/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;

/**
 * 商品分类管理Entity
 * @author 杨晓辉
 * @version 2015-10-12
 */
public class Categories extends DataEntity<Categories> {
	
	private static final long serialVersionUID = 1L;
	private Categories parent;		// 父分类
	private String allParentId;		// 所有父分类ID
	private String categoryName;	// 分类名称
	private String categoryTag;		// 分类标记
	private String categoryIcon;	// 分类图标
	private String orderNo;			// 排序序号
	
	
	private String useRange;//使用范围    字典：useRange
	
	private List<Property> lgtPsPropertyList=Lists.newArrayList();//关联属性
	
	public Categories() {
		super();
	}

	public Categories(String id){
		super(id);
	}

	public Categories getParent() {
		return parent;
	}

	public void setParent(Categories parent) {
		this.parent = parent;
	}

	public String getAllParentId() {
		if(StringUtils.isBlank(allParentId))
			return "";
		return allParentId;
	}
	
	public void setAllParentId(String allParentId) {
		this.allParentId = allParentId;
	}
	
	@NotEmpty(message="分类名不能为空")
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	@NotEmpty(message="分类标记不能为空")
	@Length(min=0, max=50, message="分类标记长度必须介于 0 和 50 之间")
	public String getCategoryTag() {
		return categoryTag;
	}

	public void setCategoryTag(String categoryTag) {
		this.categoryTag = categoryTag;
	}
	
	@Length(min=0, max=255, message="分类图标长度必须介于 0 和 255 之间")
	public String getCategoryIcon() {
		return categoryIcon;
	}

	public void setCategoryIcon(String categoryIcon) {
		this.categoryIcon = categoryIcon;
	}
	
	@NotEmpty(message="分类排序不能为空")
	@Length(min=0, message="分类排序必须大于0")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	

	public List<Property> getLgtPsPropertyList() {
		return lgtPsPropertyList;
	}

	public void setLgtPsPropertyList(List<Property> lgtPsPropertyList) {
		this.lgtPsPropertyList = lgtPsPropertyList;
	}

	@JsonIgnore
	public static void sortList(List<Categories> list, List<Categories> sourcelist, String parentId, boolean cascade){
		
		for (int i=0; i<sourcelist.size(); i++){
			Categories e = sourcelist.get(i);
			if (e.getParent()!=null && e.getParent().getId()!=null
					&& e.getParent().getId().equals(parentId)){
				list.add(e);
				if (cascade){
					// 判断是否还有子节点, 有则继续获取子节点
					for (int j=0; j<sourcelist.size(); j++){
						Categories child = sourcelist.get(j);
						if (child.getParent()!=null && child.getParent().getId()!=null
								&& child.getParent().getId().equals(e.getId())){
							sortList(list, sourcelist, e.getId(), true);
							break;
						}
					}
				}
			}
		}
	}

	public String getUseRange() {
		return useRange;
	}

	public void setUseRange(String useRange) {
		this.useRange = useRange;
	}
	
	
	
}