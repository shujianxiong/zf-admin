/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ir;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ir.InvoiceRecord;
import com.chinazhoufan.admin.modules.bus.dao.ir.InvoiceRecordDao;

/**
 * 发票开票记录Service
 * @author 张金俊
 * @version 2017-08-07
 */
@Service
@Transactional(readOnly = true)
public class InvoiceRecordService extends CrudService<InvoiceRecordDao, InvoiceRecord> {

	public InvoiceRecord get(String id) {
		return super.get(id);
	}
	
	public List<InvoiceRecord> findList(InvoiceRecord invoiceRecord) {
		return super.findList(invoiceRecord);
	}
	
	public Page<InvoiceRecord> findPage(Page<InvoiceRecord> page, InvoiceRecord invoiceRecord) {
		return super.findPage(page, invoiceRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(InvoiceRecord invoiceRecord) {
		super.save(invoiceRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(InvoiceRecord invoiceRecord) {
		super.delete(invoiceRecord);
	}
	
}