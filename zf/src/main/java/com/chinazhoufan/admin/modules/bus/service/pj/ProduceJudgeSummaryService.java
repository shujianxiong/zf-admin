/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.pj;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudgeSummary;
import com.chinazhoufan.admin.modules.bus.dao.pj.ProduceJudgeSummaryDao;

/**
 * 产品评价摘要Service
 * @author liut
 * @version 2017-07-28
 */
@Service
@Transactional(readOnly = true)
public class ProduceJudgeSummaryService extends CrudService<ProduceJudgeSummaryDao, ProduceJudgeSummary> {

	public ProduceJudgeSummary get(String id) {
		return super.get(id);
	}
	
	public List<ProduceJudgeSummary> findList(ProduceJudgeSummary produceJudgeSummary) {
		return super.findList(produceJudgeSummary);
	}
	
	public Page<ProduceJudgeSummary> findPage(Page<ProduceJudgeSummary> page, ProduceJudgeSummary produceJudgeSummary) {
		return super.findPage(page, produceJudgeSummary);
	}
	
	@Transactional(readOnly = false)
	public void save(ProduceJudgeSummary produceJudgeSummary) {
		super.save(produceJudgeSummary);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProduceJudgeSummary produceJudgeSummary) {
		super.delete(produceJudgeSummary);
	}
	
}