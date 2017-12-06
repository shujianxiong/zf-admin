/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.qa;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.qa.BaseAnswerDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseAnswer;

/**
 * 问题答案列表Service
 * @author 贾斌
 * @version 2015-11-17
 */
@Service
@Transactional(readOnly = true)
public class BaseAnswerService extends CrudService<BaseAnswerDao, BaseAnswer> {

	public BaseAnswer get(String id) {
		return super.get(id);
	}
	
	public List<BaseAnswer> findList(BaseAnswer baseAnswer) {
		return super.findList(baseAnswer);
	}
	
	public Page<BaseAnswer> findPage(Page<BaseAnswer> page, BaseAnswer baseAnswer) {
		return super.findPage(page, baseAnswer);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseAnswer baseAnswer) {
		super.save(baseAnswer);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseAnswer baseAnswer) {
		super.delete(baseAnswer);
	}
	
	
}