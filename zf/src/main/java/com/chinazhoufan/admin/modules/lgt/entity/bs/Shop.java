/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.bs;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Area;

import javax.validation.constraints.NotNull;

/**
 * 体验店（自提点）Entity
 * @author 张金俊
 * @version 2016-01-21
 */
public class Shop extends DataEntity<Shop> {
	
	private static final long serialVersionUID = 1L;
	private String name;			// 体验店名称
	private String tel;				// 联系电话
	private Area area;				// 地址ID
	private String areaDetail;		// 地址详情
	private String photoUrl;		// 展示图片
	private String selfPickFlag;	// 是否可自提
	
	public static final String SELF_PICK_YES = "1";//自提
	public static final String SELF_PICK_NO = "0";//配送
	
	public Shop() {
		super();
	}

	public Shop(String id){
		super(id);
	}

	@Length(min=1, max=50, message="体验店名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=50, message="联系电话长度必须介于 1 和 50 之间")
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@NotNull(message="地址ID不能为空")
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=1, max=255, message="地址详情长度必须介于 1 和 255 之间")
	public String getAreaDetail() {
		return areaDetail;
	}

	public void setAreaDetail(String areaDetail) {
		this.areaDetail = areaDetail;
	}
	
	@Length(min=1, max=255, message="展示图片长度必须介于 1 和 255 之间")
	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
	@Length(min=1, max=1, message="是否可自提长度必须介于 1 和 1 之间")
	public String getSelfPickFlag() {
		return selfPickFlag;
	}

	public void setSelfPickFlag(String selfPickFlag) {
		this.selfPickFlag = selfPickFlag;
	}
	
}