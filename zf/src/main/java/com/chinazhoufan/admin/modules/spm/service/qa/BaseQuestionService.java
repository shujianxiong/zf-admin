/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.qa;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.qa.BaseAnswerDao;
import com.chinazhoufan.admin.modules.spm.dao.qa.BaseQuestionDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseAnswer;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseQuestion;

/**
 * 问题基本信息Service
 * @author 贾斌
 * @version 2015-11-17
 */
@Service
@Transactional(readOnly = true)
public class BaseQuestionService extends CrudService<BaseQuestionDao, BaseQuestion> {

	@Autowired
	public BaseAnswerService answerService;
	
	@Autowired
	public BaseAnswerDao answerDao;
	
	public BaseQuestion get(String id) {
		BaseQuestion baseQuestion = super.get(id);
		baseQuestion.setAnswerList(answerDao.findBaseQuestionId(baseQuestion));
		return baseQuestion;
	}
	
	public BaseQuestion find(String id) {
		if(StringUtils.isBlank(id))
			return new BaseQuestion();
		return dao.find(id);
	}
	public List<BaseQuestion> findList(BaseQuestion baseQuestion) {
		return super.findList(baseQuestion);
	}
	
	public Page<BaseQuestion> findPage(Page<BaseQuestion> page, BaseQuestion baseQuestion) {
		return super.findPage(page, baseQuestion);
	}
	
	/**
	 * 调研问题只支持新增操作，不支持修改操作
	 * 如果需要修改，必须伪删除后再新增
	 */
	@Transactional(readOnly = false)
	public void save(BaseQuestion baseQuestion) {
		
		//新增问题
		super.save(baseQuestion);
		//新增答案记录
		for(BaseAnswer baseAnswer : baseQuestion.getAnswerList()){
			if(StringUtils.isBlank(baseAnswer.getName()))
				continue;
			baseAnswer.setBaseQuestion(baseQuestion);
			answerService.save(baseAnswer);
		}	
		
	}
	
	@Transactional(readOnly = false)
	public void update(BaseQuestion baseQuestion) {
		baseQuestion.preUpdate();
		dao.update(baseQuestion);
		
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseQuestion baseQuestion) {
		super.delete(baseQuestion);
		for(BaseAnswer baseAnswer:baseQuestion.getAnswerList()){
			answerService.delete(baseAnswer);
		}
	}
	
}