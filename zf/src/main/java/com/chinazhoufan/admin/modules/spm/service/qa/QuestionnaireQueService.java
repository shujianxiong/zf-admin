/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.qa;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.qa.QuestionnaireDao;
import com.chinazhoufan.admin.modules.spm.dao.qa.QuestionnaireQueDao;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseAnswer;
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseQuestion;
import com.chinazhoufan.admin.modules.spm.entity.qa.QuestionnaireQue;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;
import com.chinazhoufan.admin.modules.spm.entity.qa.RespondentsAns;
import com.google.common.collect.Lists;

/**
 * 问卷问题列表Service
 * @author 贾斌
 * @version 2015-11-17
 */
@Service
@Transactional(readOnly = true)
public class QuestionnaireQueService extends CrudService<QuestionnaireQueDao, QuestionnaireQue> {

	@Autowired
	private QuestionnaireDao questionnaireDao;
	@Autowired
	private BaseQuestionService baseQuestionService;
	
	public QuestionnaireQue get(String id) {
		return super.get(id);
	}
	
	public List<QuestionnaireQue> findList(QuestionnaireQue questionnaireQue) {
		return super.findList(questionnaireQue);
	}
	
	public Page<QuestionnaireQue> findPage(Page<QuestionnaireQue> page, QuestionnaireQue questionnaireQue) {
		return super.findPage(page, questionnaireQue);
	}
	
	@Transactional(readOnly = false)
	public void save(QuestionnaireQue questionnaireQue) {
		super.save(questionnaireQue);
	}
	
	@Transactional(readOnly = false)
	public void delete(QuestionnaireQue questionnaireQue) {
		super.delete(questionnaireQue);
	}
	
	public List<QuestionnaireQue> getByRespondents(Respondents respondents) {
		List<QuestionnaireQue> questionnaireQueList = Lists.newArrayList();
		List<RespondentsAns> respondentsAnsList = respondents.getRespondentsAnsList();
		QuestionnaireQue tempQue;
		BaseQuestion tempQuestion;
		for (RespondentsAns respondentsAns : respondentsAnsList) {
			tempQuestion = baseQuestionService.find(get(respondentsAns.getQuestionnaireQue().getId()).getBaseQuestion().getId());
			tempQue = dao.get(respondentsAns.getQuestionnaireQue().getId());
			tempQue.setBaseQuestion(tempQuestion);
			if (!BaseQuestion.ANSWERTYPE_INPUT.equals(tempQuestion.getType())) {
				List<BaseAnswer> List = tempQuestion.getAnswerList();
				tempQue.setBaseAnswerList(List);
			}
			questionnaireQueList.add(tempQue);
		}
		return questionnaireQueList;
	}
	
}