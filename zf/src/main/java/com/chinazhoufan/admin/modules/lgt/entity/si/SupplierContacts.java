/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.si;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Area;

/**
 * 供应商通讯录Entity
 * @author 张金俊
 * @version 2015-10-15
 */
public class SupplierContacts extends DataEntity<SupplierContacts> {
	
	private static final long serialVersionUID = 1L;
	private Supplier supplier;		// 供应商 父类
	private String name;		// 姓名
	private String role;		// 角色
	private String job;		// 岗位
	private String telephone;		// 联系电话
	private Area area;		// 联系地址编号
	private String sysAreaDetail;		// 联系地址
	
	public SupplierContacts() {
		super();
	}

	public SupplierContacts(String id){
		super(id);
	}

	public SupplierContacts(Supplier supplier){
		this.supplier = supplier;
	}


	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=1, max=50, message="姓名长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=100, message="角色长度必须介于 0 和 100 之间")
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	@Length(min=0, max=100, message="岗位长度必须介于 0 和 100 之间")
	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	
	@Length(min=0, max=50, message="联系电话长度必须介于 0 和 50 之间")
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
//	@Length(min=0, max=64, message="联系地址编号长度必须介于 0 和 64 之间")
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	@Length(min=0, max=255, message="联系地址长度必须介于 0 和 255 之间")
	public String getSysAreaDetail() {
		return sysAreaDetail;
	}

	

	public void setSysAreaDetail(String sysAreaDetail) {
		this.sysAreaDetail = sysAreaDetail;
	}
	
	
}