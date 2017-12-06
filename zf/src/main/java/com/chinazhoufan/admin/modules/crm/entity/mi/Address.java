/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mi;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Area;

/**
 * 会员物流地址管理Entity
 * @author 刘晓东
 * @version 2015-12-22
 */
public class Address extends DataEntity<Address> {
	
	private static final long serialVersionUID = 1L;
	private Member member;			// 会员
	private Area sysArea;			// 收货地址
	private String addressDetail;	// 收货地址详情
	private String zipCode;     	// 邮编
	private String receiveName;		// 收货人
	private String receiveTel;		// 收货联系电话
	private String defaultFlag;		// 是否默认0：否    1:是 
	
	public Address() {
		super();
	}

	public Address(String id){
		super(id);
	}
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Area getSysArea() {
		return sysArea;
	}

	public void setSysArea(Area sysArea) {
		this.sysArea = sysArea;
	}

	@Length(min=1, max=50, message="收货人长度必须介于 1 和 50 之间")
	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}
	
	@Length(min=1, max=50, message="收货联系电话长度必须介于 1 和 50 之间")
	public String getReceiveTel() {
		return receiveTel;
	}

	public void setReceiveTel(String receiveTel) {
		this.receiveTel = receiveTel;
	}
	
	@Length(min=1, max=1, message="是否默认长度必须介于 1 和 1 之间")
	public String getDefaultFlag() {
		return defaultFlag;
	}

	public void setDefaultFlag(String defaultFlag) {
		this.defaultFlag = defaultFlag;
	}
	
	@Length(min=0, max=255, message="收货地址详情长度必须介于 0 和 255 之间")
	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	
}