/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.bs;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 设计师Entity
 * @author 张金俊
 * @version 2016-08-17
 */
public class Designer extends DataEntity<Designer> {
	
	private static final long serialVersionUID = 1L;
	private String name;			// 姓名
	private String sex;				// 性别
	private String age;				// 年龄
	private String country;			// 国籍
	private String designStyle;		// 设计风格
	private String tags;			// 标签
	private String gravatar;		// 头像
	private String listPhoto;		// 列表图
	private String headPhoto;		// 形象图
	private String summary;			// 简介
	private String detail;			// 详情
	private String usableFlag;		// 是否启用
	private String recommendFlag;	// 是否推荐
	private String orderNo;			// 排列序号
	
	public Designer() {
		super();
	}

	public Designer(String id){
		super(id);
	}

	
	
	@Length(min=1, max=50, message="姓名长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=1, message="性别长度必须介于 1 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Length(min=0, max=11, message="年龄长度必须介于 0 和 11 之间")
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	@Length(min=1, max=2, message="国籍长度必须介于 1 和 2 之间")
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
	@Length(min=1, max=2, message="设计风格长度必须介于 1 和 2 之间")
	public String getDesignStyle() {
		return designStyle;
	}

	public void setDesignStyle(String designStyle) {
		this.designStyle = designStyle;
	}
	
	@Length(min=0, max=200, message="标签长度必须介于 0 和 200 之间")
	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}
	
	@Length(min=0, max=255, message="头像长度必须介于 0 和 255 之间")
	public String getGravatar() {
		return gravatar;
	}

	public void setGravatar(String gravatar) {
		this.gravatar = gravatar;
	}
	
	@Length(min=0, max=255, message="列表图长度必须介于 0 和 255 之间")
	public String getListPhoto() {
		return listPhoto;
	}

	public void setListPhoto(String listPhoto) {
		this.listPhoto = listPhoto;
	}
	
	@Length(min=0, max=255, message="形象图长度必须介于 0 和 255 之间")
	public String getHeadPhoto() {
		return headPhoto;
	}

	public void setHeadPhoto(String headPhoto) {
		this.headPhoto = headPhoto;
	}
	
	@Length(min=0, max=1000, message="简介长度必须介于 0 和 1000 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
	@Length(min=1, max=1, message="是否推荐长度必须介于 1 和 1 之间")
	public String getRecommendFlag() {
		return recommendFlag;
	}

	public void setRecommendFlag(String recommendFlag) {
		this.recommendFlag = recommendFlag;
	}
	
	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
}