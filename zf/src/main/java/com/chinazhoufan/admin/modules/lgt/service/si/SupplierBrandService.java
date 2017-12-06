/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.si;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierBrandDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierBrand;

/**
 * 供应商合同Service
 * @author liut
 * @version 2016-04-29
 */
@Service
@Transactional(readOnly = true)
public class SupplierBrandService extends CrudService<SupplierBrandDao, SupplierBrand> {

	public SupplierBrand get(String id) {
		return super.get(id);
	}
	
	public List<SupplierBrand> findList(SupplierBrand supplierBrand) {
		return super.findList(supplierBrand);
	}
	
	public Page<SupplierBrand> findPage(Page<SupplierBrand> page, SupplierBrand supplierBrand) {
		return super.findPage(page, supplierBrand);
	}
	
	@Transactional(readOnly = false)
	public void save(SupplierBrand supplierBrand) {
		super.save(supplierBrand);
	}
	
	@Transactional(readOnly = false)
	public void delete(SupplierBrand supplierBrand) {
		super.delete(supplierBrand);
	}
	
	@Transactional(readOnly = false)
	public void deleteBySupplierId(SupplierBrand supplierBrand){
		dao.deleteBySupplierId(supplierBrand);
	}
	
	public List<SupplierBrand> listBySupplierId(SupplierBrand supplierBrand) {
		return dao.listBySupplierId(supplierBrand);
	}
	
	@Transactional(readOnly = false)
	public void saveSupplierBrandBatch(List<SupplierBrand> list) {
		dao.saveSupplierBrandBatch(list);
	}
	
	public SupplierBrand getAllBrandNameBySupplierId(SupplierBrand supplierBrand) {
		return dao.getAllBrandNameBySupplierId(supplierBrand);
	}
}