package com.chinazhoufan.mobile.index.modules.activity.vo;

import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;


/**
 * 问卷及答卷VO
 * @author 刘晓东
 *
 */
public class QueAndAnsVO {
	
	private Questionnaire questionnaire;
	private Respondents respondents;
	
	
	public QueAndAnsVO(Questionnaire questionnaire){
		this.questionnaire = questionnaire;
	}
	
	public QueAndAnsVO(Questionnaire questionnaire, Respondents respondents){
		this.questionnaire = questionnaire;
		this.respondents = respondents;
	}
	
	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}
	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}
	public Respondents getRespondents() {
		return respondents;
	}
	public void setRespondents(Respondents respondents) {
		this.respondents = respondents;
	}
	
}
