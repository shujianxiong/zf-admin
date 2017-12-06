/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.pd;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 广告Entity
 * @author 张金俊
 * @version 2016-08-12
 */
public class Advertisement extends DataEntity<Advertisement> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 广告名称
	private String type;		// 广告类型（入口/展示）
	private String displayArea;	// 展示区域（欢迎页/首页弹窗/首页轮播/商品列表头部/商品详情头部/购物车头部）
	private String dpPhoto;		// 展示图
	private String url;			// 链接地址
	private String orderNo;		// 排列序号
	private String usableFlag;	// 是否启用
	
	public Advertisement() {
		super();
	}

	public Advertisement(String id){
		super(id);
	}

	@Length(min=1, max=50, message="广告名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=10, message="广告类型（入口/展示）长度必须介于 1 和 10 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=10, message="展示区域长度必须介于 1 和 10 之间")
	public String getDisplayArea() {
		return displayArea;
	}

	public void setDisplayArea(String displayArea) {
		this.displayArea = displayArea;
	}
	
	@Length(min=0, max=255, message="展示图长度必须介于 0 和 255 之间")
	public String getDpPhoto() {
		return dpPhoto;
	}

	public void setDpPhoto(String dpPhoto) {
		this.dpPhoto = dpPhoto;
	}
	
	@Length(min=0, max=255, message="链接地址长度必须介于 0 和 255 之间")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=1, message="是否启用长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}