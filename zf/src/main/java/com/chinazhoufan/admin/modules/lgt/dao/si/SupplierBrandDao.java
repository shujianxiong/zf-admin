/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.si;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierBrand;

/**
 * 供应商品牌关系DAO接口
 * @author liut
 * @version 2016-04-29
 */
@MyBatisDao
public interface SupplierBrandDao extends CrudDao<SupplierBrand> {
	
	public void deleteBySupplierId(SupplierBrand supplierBrand);
	
	public List<SupplierBrand> listBySupplierId(SupplierBrand supplierBrand);
	
	public SupplierBrand getAllBrandNameBySupplierId(SupplierBrand supplierBrand);
	
	public void saveSupplierBrandBatch(List<SupplierBrand> list);
}