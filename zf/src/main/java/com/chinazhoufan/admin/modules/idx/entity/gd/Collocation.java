/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.gd;

import java.math.BigDecimal;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 搭配Entity
 * @author liut
 * @version 2017-03-15
 */
public class Collocation extends DataEntity<Collocation> {
	
	private static final long serialVersionUID = 1L;
	private Scene scene;			// 所属场景
	private String name;			// 搭配名称
	private String englishName;		// 搭配英文名称
	private String colourSystem;	// 色系（字典：idx_gd_collocation_colourSystem）
	private BigDecimal averagePrice;// 均价
	private String photo;			// 搭配详情图
	private String description;		// 搭配描述
	private Integer orderNo;		// 排列序号
	private String recommendFlag;	// 是否推荐
	private String shareTitle;		//分享标题
	private String shareDescribe;	//分享描述
	private String sharePhoto;		//分享图片
	private String usableFlag;		// 是否启用
	private String searchKey;		// 搜索关键词
	
	//分组小搭配
	private List<CollocationGroup> ccgList = Lists.newArrayList();
	
	
	public Collocation() {
		super();
	}

	public Collocation(String id){
		super(id);
	}
	

	@NotNull(message="所属场景ID不能为空")
	public Scene getScene() {
		return scene;
	}

	public void setScene(Scene scene) {
		this.scene = scene;
	}
	
	@Length(min=1, max=50, message="搭配名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=255, message="搭配详情图不能为空")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}

	public String getEnglishName() {
		return englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}

	public String getColourSystem() {
		return colourSystem;
	}

	public void setColourSystem(String colourSystem) {
		this.colourSystem = colourSystem;
	}

	public BigDecimal getAveragePrice() {
		return averagePrice;
	}

	public void setAveragePrice(BigDecimal averagePrice) {
		this.averagePrice = averagePrice;
	}

	public List<CollocationGroup> getCcgList() {
		return ccgList;
	}

	public void setCcgList(List<CollocationGroup> ccgList) {
		this.ccgList = ccgList;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public String getRecommendFlag() {
		return recommendFlag;
	}

	public void setRecommendFlag(String recommendFlag) {
		this.recommendFlag = recommendFlag;
	}

	public String getShareTitle() {
		return shareTitle;
	}

	public void setShareTitle(String shareTitle) {
		this.shareTitle = shareTitle;
	}

	public String getShareDescribe() {
		return shareDescribe;
	}

	public void setShareDescribe(String shareDescribe) {
		this.shareDescribe = shareDescribe;
	}

	public String getSharePhoto() {
		return sharePhoto;
	}

	public void setSharePhoto(String sharePhoto) {
		this.sharePhoto = sharePhoto;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
}