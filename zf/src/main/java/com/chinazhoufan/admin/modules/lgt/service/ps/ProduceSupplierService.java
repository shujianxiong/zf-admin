/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceSupplierDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceSupplier;

/**
 * 产品供货Service
 * @author 陈适
 * @version 2016-03-29
 */
@Service
@Transactional(readOnly = true)
public class ProduceSupplierService extends CrudService<ProduceSupplierDao, ProduceSupplier> {

	public ProduceSupplier get(String id) {
		return super.get(id);
	}
	
	public List<ProduceSupplier> findList(ProduceSupplier produceSupplier) {
		return super.findList(produceSupplier);
	}
	
	public Page<ProduceSupplier> findPage(Page<ProduceSupplier> page, ProduceSupplier produceSupplier) {
		return super.findPage(page, produceSupplier);
	}
	
	@Transactional(readOnly = false)
	public void save(ProduceSupplier produceSupplier) {
		super.save(produceSupplier);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProduceSupplier produceSupplier) {
		super.delete(produceSupplier);
	}
	
}