/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.tn;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressAppointRecord;
import com.chinazhoufan.admin.modules.lgt.dao.tn.ExpressAppointRecordDao;

/**
 * 快递预约记录Service
 * @author liut
 * @version 2017-05-24
 */
@Service
@Transactional(readOnly = true)
public class ExpressAppointRecordService extends CrudService<ExpressAppointRecordDao, ExpressAppointRecord> {

	public ExpressAppointRecord get(String id) {
		return super.get(id);
	}
	
	public List<ExpressAppointRecord> findList(ExpressAppointRecord expressAppointRecord) {
		return super.findList(expressAppointRecord);
	}
	
	public Page<ExpressAppointRecord> findPage(Page<ExpressAppointRecord> page, ExpressAppointRecord expressAppointRecord) {
		return super.findPage(page, expressAppointRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(ExpressAppointRecord expressAppointRecord) {
		super.save(expressAppointRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExpressAppointRecord expressAppointRecord) {
		super.delete(expressAppointRecord);
	}

	public ExpressAppointRecord getByExpressOrderId(String expressOrderId) {
		return dao.getByExpressOrderId(expressOrderId);
	}
}