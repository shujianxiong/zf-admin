/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.tn;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressInfoRecord;
import com.chinazhoufan.admin.modules.lgt.dao.tn.ExpressInfoRecordDao;

/**
 * 快递信息记录Service
 * @author liuxiaodong
 * @version 2017-11-04
 */
@Service
@Transactional(readOnly = true)
public class ExpressInfoRecordService extends CrudService<ExpressInfoRecordDao, ExpressInfoRecord> {

	public ExpressInfoRecord get(String id) {
		return super.get(id);
	}
	
	public List<ExpressInfoRecord> findList(ExpressInfoRecord expressInfoRecord) {
		return super.findList(expressInfoRecord);
	}
	
	public Page<ExpressInfoRecord> findPage(Page<ExpressInfoRecord> page, ExpressInfoRecord expressInfoRecord) {
		return super.findPage(page, expressInfoRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(ExpressInfoRecord expressInfoRecord) {
		super.save(expressInfoRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExpressInfoRecord expressInfoRecord) {
		super.delete(expressInfoRecord);
	}
	
}