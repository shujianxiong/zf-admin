/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.pj;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.dao.pj.SummaryDao;
import com.chinazhoufan.admin.modules.bus.entity.pj.Summary;

/**
 * 评价摘要Service
 * @author liut
 * @version 2017-07-28
 */
@Service
@Transactional(readOnly = true)
public class SummaryService extends CrudService<SummaryDao, Summary> {

	public Summary get(String id) {
		return super.get(id);
	}
	
	public List<Summary> findList(Summary summaryEvaluation) {
		return super.findList(summaryEvaluation);
	}
	
	public Page<Summary> findPage(Page<Summary> page, Summary summaryEvaluation) {
		return super.findPage(page, summaryEvaluation);
	}
	
	@Transactional(readOnly = false)
	public void save(Summary summaryEvaluation) {
		super.save(summaryEvaluation);
	}
	
	@Transactional(readOnly = false)
	public void delete(Summary summaryEvaluation) {
		super.delete(summaryEvaluation);
	}
	
}