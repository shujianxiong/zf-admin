/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 仓库管理Entity
 * @author 贾斌
 * @version 2015-10-15
 */
public class Warehouse extends DataEntity<Warehouse> {
	
	private static final long serialVersionUID = 1L;
	private String code;				// 编码
	private String name;				// 名称
	private String type;				// 类型（存货仓/店铺仓）
	private Area area;					// 所处地址    省市区
	private String areaDetail;			// 地址详情
	private String tel;					// 仓库联系电话
	private String layoutPhoto;			// 仓库布局图
	private User responsibleUser;		// 负责人
	private String responsibleMobile;	// 负责人电话
	private String orderNo;				// 排列序号
	private String usableFlag;			// 是否启用
	private List<Warearea> wareareaList = Lists.newArrayList();// 仓库区域
	
	/** 构造 */
	public Warehouse() {
		super();
	}

	public Warehouse(String id){
		super(id);
	}

	
	/** 方法 */
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	@NotBlank(message="仓库名称不能为空")
	@Length(min=1, max=64, message="仓库名称长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotBlank(message="详细地址不能为空")
	@Length(min=0, max=255, message="地址详情长度必须介于 0 和 255 之间")
	public String getAreaDetail() {
		return areaDetail;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}

	public void setAreaDetail(String areaDetail) {
		this.areaDetail = areaDetail;
	}
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=0, max=255, message="仓库布局图长度必须介于 0 和 255 之间")
	public String getLayoutPhoto() {
		return layoutPhoto;
	}

	public void setLayoutPhoto(String layoutPhoto) {
		this.layoutPhoto = layoutPhoto;
	}
	
	@NotBlank(message="负责人电话不能为空")
	@Length(min=0, max=50, message="负责人电话长度必须介于 0 和 50 之间")
	public String getResponsibleMobile() {
		return responsibleMobile;
	}

	public void setResponsibleMobile(String responsibleMobile) {
		this.responsibleMobile = responsibleMobile;
	}
	
	public User getResponsibleUser() {
		return responsibleUser;
	}

	public void setResponsibleUser(User responsibleUser) {
		this.responsibleUser = responsibleUser;
	}
	
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public List<Warearea> getWareareaList() {
		return wareareaList;
	}

	public void setWareareaList(List<Warearea> wareareaList) {
		this.wareareaList = wareareaList;
	}
}