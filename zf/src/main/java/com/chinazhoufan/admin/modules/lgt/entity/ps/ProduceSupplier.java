/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;


import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;

/**
 * 产品供货Entity
 * @author 陈适
 * @version 2016-03-29
 */
public class ProduceSupplier extends DataEntity<ProduceSupplier> {
	
	private static final long serialVersionUID = 1L;
	private Produce produce;		// 产品ID
	private Supplier supplier;		// 供应商ID
	
	public ProduceSupplier() {
		super();
	}

	public ProduceSupplier(String id){
		super(id);
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
}