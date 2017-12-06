/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.qa;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 问题答案列表Entity
 * @author 贾斌
 * @version 2015-11-17
 */
public class BaseAnswer extends DataEntity<BaseAnswer> {
	
	private static final long serialVersionUID = 1L;
	private BaseQuestion baseQuestion;	// 问题
	private String name;				// 答案名称
	private String correctFlag;			// 正确答案标记
	
	private List<BaseQuestion> questions = Lists.newArrayList();//问题
	
	
	
	public BaseAnswer(List<BaseQuestion> questions) {
		super();
		this.questions = questions;
	}

	public BaseAnswer(BaseQuestion baseQuestion, String name) {
		super();
		this.baseQuestion = baseQuestion;
		this.name = name;
	}
	
	
	
	public List<BaseQuestion> getQuestions() {
		return questions;
	}

	public void setQuestions(List<BaseQuestion> questions) {
		this.questions = questions;
	}

	public BaseQuestion getBaseQuestion() {
		return baseQuestion;
	}

	public void setBaseQuestion(BaseQuestion baseQuestion) {
		this.baseQuestion = baseQuestion;
	}

	public BaseAnswer() {
		super();
	}

	public BaseAnswer(String id){
		super(id);
	}

	@Length(min=1, max=200, message="答案名称长度必须介于 1 和 200 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCorrectFlag() {
		return correctFlag;
	}

	public void setCorrectFlag(String correctFlag) {
		this.correctFlag = correctFlag;
	}
	
}