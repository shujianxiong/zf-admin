/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.qa;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 答卷答案列表Entity
 * @author 贾斌、张金俊
 * @version 2015-11-18
 */
public class RespondentsAns extends DataEntity<RespondentsAns> {
	
	private static final long serialVersionUID = 1L;
	private Respondents respondents;			// 答卷
	private QuestionnaireQue questionnaireQue;	// 问卷问题
	private BaseAnswer baseAnswer;				// 答案项
	private String answerText;					// 答案
	
	private List<BaseAnswer> baseAnswerList = Lists.newArrayList();
	
	public RespondentsAns() {
		super();
	}

	public RespondentsAns(String id){
		super(id);
	}
	
	public RespondentsAns(Respondents respondents){
		this.respondents = respondents;
	}
	
	public Respondents getRespondents() {
		return respondents;
	}

	public void setRespondents(Respondents respondents) {
		this.respondents = respondents;
	}

	public QuestionnaireQue getQuestionnaireQue() {
		return questionnaireQue;
	}

	public void setQuestionnaireQue(QuestionnaireQue questionnaireQue) {
		this.questionnaireQue = questionnaireQue;
	}

	public BaseAnswer getBaseAnswer() {
		return baseAnswer;
	}

	public void setBaseAnswer(BaseAnswer baseAnswer) {
		this.baseAnswer = baseAnswer;
	}

	@Length(min=1, max=1000, message="答案长度必须介于 1 和 1000 之间")
	public String getAnswerText() {
		return answerText;
	}

	public void setAnswerText(String answerText) {
		this.answerText = answerText;
	}

	public List<BaseAnswer> getBaseAnswerList() {
		return baseAnswerList;
	}

	public void setBaseAnswerList(List<BaseAnswer> baseAnswerList) {
		this.baseAnswerList = baseAnswerList;
	}
	
}