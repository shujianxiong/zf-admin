package com.chinazhoufan.admin.modules.lgt.entity.si;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;

public class SupplierBrand  extends DataEntity<SupplierBrand> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7972938750652788245L;

	private Supplier supplier;
	private Brand brand;
	
	public Supplier getSupplier() {
		return supplier;
	}
	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	public Brand getBrand() {
		return brand;
	}
	public void setBrand(Brand brand) {
		this.brand = brand;
	}
	
}
