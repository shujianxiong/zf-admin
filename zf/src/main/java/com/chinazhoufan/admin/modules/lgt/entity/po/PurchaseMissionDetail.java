/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.po;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;


import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 采购任务产品Entity
 * @author 张金俊
 * @version 2016-04-13
 */
public class PurchaseMissionDetail extends DataEntity<PurchaseMissionDetail> {
	
	private static final long serialVersionUID = 1L;
	private PurchaseMission purchaseMission;	// 采购任务ID
	private Produce produce;					// 产品ID
	private Integer num;						// 数量

	
	
	public PurchaseMissionDetail() {
		super();
	}

	public PurchaseMissionDetail(String id){
		super(id);
	}

	
	
	@Length(min=1, max=64, message="采购任务ID长度必须介于 1 和 64 之间")
	public PurchaseMission getPurchaseMission() {
		return purchaseMission;
	}

	public void setPurchaseMission(PurchaseMission purchaseMission) {
		this.purchaseMission = purchaseMission;
	}
	
	@Length(min=1, max=64, message="产品ID长度必须介于 1 和 64 之间")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	@NotNull(message="数量不能为空")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
		
}