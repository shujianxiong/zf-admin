/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.qa;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 问卷问题列表Entity
 * @author 贾斌、张金俊
 * @version 2015-11-17
 */
public class QuestionnaireQue extends DataEntity<QuestionnaireQue> {
	
	private static final long serialVersionUID = 1L;
	private Questionnaire questionnaire;	// 问卷
	private BaseQuestion baseQuestion;		// 问题项
//	private BaseAnswer baseAnswer;			// 问题答案
	private Integer point;					// 问题项分值
	private Integer levelNum;				// 问题顺序层级
	
	private List<BaseQuestion> baseQuestions = Lists.newArrayList();	// 问题集合
	private List<BaseAnswer> baseAnswerList = Lists.newArrayList();		// 问题答案集合
	
	
	public QuestionnaireQue() {
		super();
	}

	public QuestionnaireQue(String id){
		super(id);
	}
	
	public QuestionnaireQue(Questionnaire questionnaire){
		this.questionnaire = questionnaire;
	}
	
	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}

	public BaseQuestion getBaseQuestion() {
		return baseQuestion;
	}

	public void setBaseQuestion(BaseQuestion baseQuestion) {
		this.baseQuestion = baseQuestion;
	}
	
	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public Integer getLevelNum() {
		return levelNum;
	}

	public void setLevelNum(Integer levelNum) {
		this.levelNum = levelNum;
	}

	public List<BaseQuestion> getBaseQuestions() {
		return baseQuestions;
	}

	public void setBaseQuestions(List<BaseQuestion> baseQuestions) {
		this.baseQuestions = baseQuestions;
	}

	public List<BaseAnswer> getBaseAnswerList() {
		return baseAnswerList;
	}

	public void setBaseAnswerList(List<BaseAnswer> baseAnswerList) {
		this.baseAnswerList = baseAnswerList;
	}

}