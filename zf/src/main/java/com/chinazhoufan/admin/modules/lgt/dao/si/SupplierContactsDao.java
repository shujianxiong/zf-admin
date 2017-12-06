/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.si;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierContacts;

/**
 * 供应商通讯录DAO接口
 * @author 张金俊
 * @version 2015-10-15
 */
@MyBatisDao
public interface SupplierContactsDao extends CrudDao<SupplierContacts> {
	
	/**
	 * 获取当前登录供应商账号对应的供应商联系人信息
	 * @param supplierContacts
	 * @return
	 */
	public List<SupplierContacts> findSupplierContactsBySupplier(SupplierContacts supplierContacts);
	
	
	
}