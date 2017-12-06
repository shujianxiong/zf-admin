/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ac;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.ac.AcActivityTemplateDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivityTemplate;

/**
 * 调研活动模板Service
 * @author liut
 * @version 2016-05-20
 */
@Service
@Transactional(readOnly = true)
public class AcActivityTemplateService extends CrudService<AcActivityTemplateDao, AcActivityTemplate> {

	public AcActivityTemplate get(String id) {
		return super.get(id);
	}
	
	public List<AcActivityTemplate> findList(AcActivityTemplate acActivityTemplate) {
		return super.findList(acActivityTemplate);
	}
	
	public Page<AcActivityTemplate> findPage(Page<AcActivityTemplate> page, AcActivityTemplate acActivityTemplate) {
		return super.findPage(page, acActivityTemplate);
	}
	
	@Transactional(readOnly = false)
	public void save(AcActivityTemplate acActivityTemplate) {
		super.save(acActivityTemplate);
	}
	
	@Transactional(readOnly = false)
	public void delete(AcActivityTemplate acActivityTemplate) {
		super.delete(acActivityTemplate);
	}
	
}