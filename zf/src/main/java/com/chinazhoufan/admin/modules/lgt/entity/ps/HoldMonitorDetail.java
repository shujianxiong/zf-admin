/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 货品持有监控管理Entity
 * @author 刘晓东
 * @version 2015-10-15
 */
public class HoldMonitorDetail extends DataEntity<HoldMonitorDetail> {
	
	private static final long serialVersionUID = 1L;
	private HoldMonitor holdMonitor;		// 持货ID 父类
	private Product product;		// 货品ID
	
	public HoldMonitorDetail() {
		super();
	}

	public HoldMonitorDetail(String id){
		super(id);
	}

	public HoldMonitorDetail(HoldMonitor holdMonitor){
		this.holdMonitor = holdMonitor;
	}

	
	public HoldMonitor getHoldMonitor() {
		return holdMonitor;
	}

	public void setHoldMonitor(HoldMonitor holdMonitor) {
		this.holdMonitor = holdMonitor;
	}

	@Length(min=1, max=64, message="货品ID长度必须介于 1 和 64 之间")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
}