/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.pm;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 托盘管理Entity
 * @author liuxiaodong
 * @version 2017-10-27
 */
public class PlateManage extends DataEntity<PlateManage> {
	
	private static final long serialVersionUID = 1L;
	private String plateNo;		// 托盘编号
	private String plateStatus;		// 托盘状态
	private String plateUsed;		// 托盘使用情况
	
	public PlateManage() {
		super();
	}

	public PlateManage(String id){
		super(id);
	}

	@Length(min=1, max=64, message="托盘编号长度必须介于 1 和 64 之间")
	public String getPlateNo() {
		return plateNo;
	}

	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}
	
	@Length(min=1, max=2, message="托盘状态长度必须介于 1 和 2 之间")
	public String getPlateStatus() {
		return plateStatus;
	}

	public void setPlateStatus(String plateStatus) {
		this.plateStatus = plateStatus;
	}
	
	@Length(min=1, max=2, message="托盘使用情况长度必须介于 1 和 2 之间")
	public String getPlateUsed() {
		return plateUsed;
	}

	public void setPlateUsed(String plateUsed) {
		this.plateUsed = plateUsed;
	}
	
}