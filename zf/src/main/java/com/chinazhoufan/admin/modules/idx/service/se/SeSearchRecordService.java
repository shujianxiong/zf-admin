/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.se;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.se.SeSearchRecord;
import com.chinazhoufan.admin.modules.idx.dao.se.SeSearchRecordDao;

/**
 * 搜索记录表Service
 * @author liut
 * @version 2016-10-27
 */
@Service
@Transactional(readOnly = true)
public class SeSearchRecordService extends CrudService<SeSearchRecordDao, SeSearchRecord> {

	public SeSearchRecord get(String id) {
		return super.get(id);
	}
	
	public List<SeSearchRecord> findList(SeSearchRecord seSearchRecord) {
		return super.findList(seSearchRecord);
	}
	
	public Page<SeSearchRecord> findPage(Page<SeSearchRecord> page, SeSearchRecord seSearchRecord) {
		return super.findPage(page, seSearchRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(SeSearchRecord seSearchRecord) {
		super.save(seSearchRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(SeSearchRecord seSearchRecord) {
		super.delete(seSearchRecord);
	}
	
}