/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.si;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierContactsDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierContacts;

/**
 * 供应商通讯录Service
 * @author 张金俊
 * @version 2015-10-15
 */
@Service
@Transactional(readOnly = true)
public class SupplierContactsService extends CrudService<SupplierContactsDao, SupplierContacts> {

	@Autowired
	private SupplierContactsDao supplierContactsDao;
	
	public SupplierContacts get(String id) {
		return super.get(id);
	}
	
	public List<SupplierContacts> findList(SupplierContacts supplierContacts) {
		return super.findList(supplierContacts);
	}
	
	public Page<SupplierContacts> findPage(Page<SupplierContacts> page, SupplierContacts supplierContacts) {
		return super.findPage(page, supplierContacts);
	}
	
	public Page<SupplierContacts> findPageBySupplier(Page<SupplierContacts> page, SupplierContacts supplierContacts) {
		supplierContacts.setPage(page);
		page.setList(supplierContactsDao.findSupplierContactsBySupplier(supplierContacts));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(SupplierContacts supplierContacts) {
		super.save(supplierContacts);
	}
	
	@Transactional(readOnly = false)
	public void delete(SupplierContacts supplierContacts) {
		super.delete(supplierContacts);
	}
	
}