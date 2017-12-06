/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.si;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierContactsDao;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.CreditPointDetail;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierContacts;

/**
 * 供应商Service
 * @author 张金俊
 * @version 2015-10-15
 */
@Service
@Transactional(readOnly = true)
public class SupplierService extends CrudService<SupplierDao, Supplier> {

	@Autowired
	private SupplierDao supplierDao;
	@Autowired
	private SupplierContactsDao supplierContactsDao;
	
	public Supplier get(String id) {
		Supplier supplier = super.get(id);
		if(StringUtils.isNotBlank(id) && supplier != null) {
			supplier.setSupplierContactsList(supplierContactsDao.findList(new SupplierContacts(supplier)));
		}
		return supplier;
	}
	
	public List<Supplier> findList(Supplier supplier) {
		return super.findList(supplier);
	}
	
	public List<Supplier> findList() {
		return super.findList(new Supplier());
	}
	
	/**
	 * 根据“是否启用”、“是否删除”的条件查询供应商
	 * @param activeFlag
	 * @return
	 */
	public List<Supplier> findListByActiveFlag(String activeFlag, String delFlag) {
		return supplierDao.findListByActiveFlag(activeFlag, delFlag);
	}

	public Page<Supplier> findPage(Page<Supplier> page, Supplier supplier) {
		return super.findPage(page, supplier);
	}
	
	@Transactional(readOnly = false)
	public void save(Supplier supplier) {
		super.save(supplier);
		
		//保存供应商联系人
		for (SupplierContacts supplierContacts : supplier.getSupplierContactsList()){
			if (supplierContacts.getId() == null){
				continue;
			}
			if (SupplierContacts.DEL_FLAG_NORMAL.equals(supplierContacts.getDelFlag())){
				if (StringUtils.isBlank(supplierContacts.getId())){
					supplierContacts.setSupplier(supplier);
					supplierContacts.preInsert();
					supplierContactsDao.insert(supplierContacts);
				}else{
					supplierContacts.preUpdate();
					supplierContactsDao.update(supplierContacts);
				}
			}else{
				supplierContactsDao.delete(supplierContacts);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Supplier supplier) {
		super.delete(supplier);
		supplierContactsDao.delete(new SupplierContacts(supplier));
	}
	
	public Supplier getSupplierByUserId(String userId) {
		return supplierDao.getSupplierByUserId(userId);
	}
	
	
	public List<Supplier> findActivitySupplierList(String activeFlag, String delFlag) {
		return supplierDao.findActivitySupplierList(activeFlag, delFlag);
	}
	
	@Transactional(readOnly = false)
	public void changeActiveFlag(Supplier supplier) {
		supplierDao.changeActiveFlag(supplier);
	};

	public Supplier getByName(String name) {
		return supplierDao.getByName(name);
	}
}