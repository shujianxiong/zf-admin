/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service.ap;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.dao.ap.ApproveRecordDao;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveRecord;

/**
 * 审批记录Service
 * @author 贾斌
 * @version 2016-03-31
 */
@Service
@Transactional(readOnly = true)
public class ApproveRecordService extends CrudService<ApproveRecordDao, ApproveRecord> {

	public ApproveRecord get(String id) {
		return super.get(id);
	}
	
	public List<ApproveRecord> findList(ApproveRecord approveRecord) {
		return super.findList(approveRecord);
	}
	
	public Page<ApproveRecord> findPage(Page<ApproveRecord> page, ApproveRecord approveRecord) {
		return super.findPage(page, approveRecord);
	}
	
	/**
	 * 查询所有的审核记录
	 * @param page
	 * @param approveRecord
	 * @return
	 */
	public Page<ApproveRecord> findAllPage(Page<ApproveRecord> page, ApproveRecord approveRecord) {
		approveRecord.setPage(page);
		page.setList(dao.findAllList(approveRecord));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ApproveRecord approveRecord) {
		super.save(approveRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(ApproveRecord approveRecord) {
		super.delete(approveRecord);
	}
	
}