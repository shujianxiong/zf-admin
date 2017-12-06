/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ar;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 宣传文章Entity
 * @author 张金俊
 * @version 2016-05-19
 */
public class ArArticle extends DataEntity<ArArticle> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 文章名称
	private String code;		// 文章编码
	private String category;	// 文章类别
	private String tags;		// 文章标签（,分割）
	private String title;		// 标题
	private String subtitle;	// 副标题
	private String shareSPhoto;	// 分享小图
	private String shareMPhoto;	// 分享中图
	private String summary;		// 简介
	private String content;		// 内容
	private Date publishTime;	// 发布时间
	private String activeFlag;	// 启用状态（0关闭/1启用）
	private Integer orderNo;	// 排列序号
	private Integer readNum;	// 阅读量
	private Integer likeNum;	// 点赞量
	
	
	public ArArticle() {
		super();
	}

	public ArArticle(String id){
		super(id);
	}

	@Length(min=1, max=100, message="文章名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Length(min=1, max=2, message="文章类别长度必须介于 1 和 2 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=1, max=100, message="文章标签（,分割）长度必须介于 1 和 100 之间")
	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}
	
	@Length(min=1, max=100, message="标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=100, message="副标题长度必须介于 0 和 100 之间")
	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	
	@Length(min=0, max=255, message="分享小图长度必须介于 0 和 255 之间")
	public String getShareSPhoto() {
		return shareSPhoto;
	}

	public void setShareSPhoto(String shareSPhoto) {
		this.shareSPhoto = shareSPhoto;
	}
	
	@Length(min=0, max=255, message="分享中图长度必须介于 0 和 255 之间")
	public String getShareMPhoto() {
		return shareMPhoto;
	}

	public void setShareMPhoto(String shareMPhoto) {
		this.shareMPhoto = shareMPhoto;
	}
	
	@Length(min=1, max=200, message="简介长度必须介于 1 和 200 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="发布时间不能为空")
	public Date getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}
	
	@Length(min=1, max=1, message="启用状态（0关闭/1启用）长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	
	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	
	@NotNull(message="阅读量不能为空")
	public Integer getReadNum() {
		return readNum;
	}

	public void setReadNum(Integer readNum) {
		this.readNum = readNum;
	}
	
	@NotNull(message="点赞量不能为空")
	public Integer getLikeNum() {
		return likeNum;
	}

	public void setLikeNum(Integer likeNum) {
		this.likeNum = likeNum;
	}
	
}