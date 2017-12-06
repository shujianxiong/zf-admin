/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.gd;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 场景Entity
 * @author liut
 * @version 2017-03-15
 */
public class Scene extends DataEntity<Scene> {
	
	private static final long serialVersionUID = 1L;
	private Scene scene;				// 父场景ID
	private String name;				// 场景名称
	private String englishName;			// 场景英文名称
	private String dpPhoto;				// 场景展示图
	private String topPhoto;			// 场景头部图
	private String searchIcon;			// 场景搜索图标
	private String listIconChoose;		// 场景分类图标（选中）
	private String listIconUnchoose;	// 场景分类图标（未选中）
	private String description;			// 场景描述
	private String orderNo;				// 排列序号
	private String indexFlag;			// 是否首页推荐
	private String usableFlag;			// 是否启用
	
	//临时字段
	private int subType;				// 是否是子场景
	
	
	
	public Scene() {
		super();
	}

	public Scene(String id){
		super(id);
	}

	
	public Scene getScene() {
		return scene;
	}

	public void setScene(Scene scene) {
		this.scene = scene;
	}
	
	@Length(min=1, max=50, message="场景名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=50, message="场景英文名称长度必须介于 1 和 50 之间")
	public String getEnglishName() {
		return englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	
	public String getDpPhoto() {
		return dpPhoto;
	}

	public void setDpPhoto(String dpPhoto) {
		this.dpPhoto = dpPhoto;
	}
	
	public String getTopPhoto() {
		return topPhoto;
	}

	public void setTopPhoto(String topPhoto) {
		this.topPhoto = topPhoto;
	}
	
	public String getSearchIcon() {
		return searchIcon;
	}

	public void setSearchIcon(String searchIcon) {
		this.searchIcon = searchIcon;
	}

	public String getListIconChoose() {
		return listIconChoose;
	}

	public void setListIconChoose(String listIconChoose) {
		this.listIconChoose = listIconChoose;
	}

	public String getListIconUnchoose() {
		return listIconUnchoose;
	}

	public void setListIconUnchoose(String listIconUnchoose) {
		this.listIconUnchoose = listIconUnchoose;
	}

	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=1, message="是否首页推荐长度必须介于 1 和 1 之间")
	public String getIndexFlag() {
		return indexFlag;
	}

	public void setIndexFlag(String indexFlag) {
		this.indexFlag = indexFlag;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}

	public int getSubType() {
		return subType;
	}

	public void setSubType(int subType) {
		this.subType = subType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
}