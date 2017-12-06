/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.cap.entity.cc;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Office;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 公司资产设备表Entity
 * @author 贾斌
 * @version 2015-12-08
 */
public class Capital extends DataEntity<Capital> {
	
	private static final long serialVersionUID = 1L;
	private Office sysOffice;		// 公司ID
	private String name;			// 资产名称
	private String fullName;		// 资产全称
	private String modelNumber;		// 规格型号
	private String capitalNo;		// 固定资产编号
	private String category;		// 资产类别（办公/经营等）
	private String type;			// 资产类型（摄像头/评价器）
	private String num;				// 数量
	private String unit;			// 单位
	private String supplier;		// 供应商
	private String price;			// 资产价值
	private Date buyDate;			// 购入时间
	private String photosUrl;		// 资产图片
	private String belongType;		// 归属类型（公司/员工/不确定）
	private User belongUser;		// 归属人（员工ID）
	private Office useOffice;			// 使用部门
	private String usePlace;		// 使用地点
	private User useUser;			// 使用员工ID
	private String capitalStatus;	// 资产状态（正常/破损/损坏）
	private String useStatus;		// 使用状态（使用中/闲置）
	
	public Capital() {
		super();
	}

	public Capital(String id){
		super(id);
	}
	@NotNull(message="公司不能为空")
	public Office getSysOffice() {
		return sysOffice;
	}

	public void setSysOffice(Office sysOffice) {
		this.sysOffice = sysOffice;
	}
	@Length(min=1, max=50, message="资产名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	@Length(min=1, max=100, message="资产全称长度必须介于 1 和 100 之间")
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	@Length(min=1, max=50, message="规格型号长度必须介于 1 和 50 之间")
	public String getModelNumber() {
		return modelNumber;
	}

	public void setModelNumber(String modelNumber) {
		this.modelNumber = modelNumber;
	}
	@Length(min=1, max=50, message="固定资产编号长度必须介于 1 和 50 之间")
	public String getCapitalNo() {
		return capitalNo;
	}

	public void setCapitalNo(String capitalNo) {
		this.capitalNo = capitalNo;
	}
	@Length(min=1, max=2, message="资产类别长度必须介于 1 和 2 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	@Length(min=1, max=2, message="资产类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	@Length(min=1, max=11, message="数量长度必须介于 1 和 11 之间")
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	@Length(min=1, max=10, message="单位长度必须介于 1 和 10 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	@Length(min=0, max=100, message="供应商长度必须介于 0 和 100 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	@NotNull(message="购入时间不能为空")
	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}
	@Length(min=0, max=1000, message="资产图片长度必须介于 0 和 1000 之间")
	public String getPhotosUrl() {
		return photosUrl;
	}

	public void setPhotosUrl(String photosUrl) {
		this.photosUrl = photosUrl;
	}
	@Length(min=1, max=2, message="归属类型长度必须介于 1 和 2 之间")
	public String getBelongType() {
		return belongType;
	}

	public void setBelongType(String belongType) {
		this.belongType = belongType;
	}
	
	public User getBelongUser() {
		return belongUser;
	}

	public void setBelongUser(User belongUser) {
		this.belongUser = belongUser;
	}
	
	public Office getUseOffice() {
		return useOffice;
	}

	public void setUseOffice(Office useOffice) {
		this.useOffice = useOffice;
	}
	@Length(min=1, max=50, message="使用地点长度必须介于 1 和 50 之间")
	public String getUsePlace() {
		return usePlace;
	}

	public void setUsePlace(String usePlace) {
		this.usePlace = usePlace;
	}

	public User getUseUser() {
		return useUser;
	}

	public void setUseUser(User useUser) {
		this.useUser = useUser;
	}
	@Length(min=1, max=2, message="资产状态长度必须介于 1 和 2 之间")
	public String getCapitalStatus() {
		return capitalStatus;
	}

	public void setCapitalStatus(String capitalStatus) {
		this.capitalStatus = capitalStatus;
	}
	@Length(min=1, max=2, message="使用状态长度必须介于 1 和 2 之间")
	public String getUseStatus() {
		return useStatus;
	}

	public void setUseStatus(String useStatus) {
		this.useStatus = useStatus;
	}

	
	
}