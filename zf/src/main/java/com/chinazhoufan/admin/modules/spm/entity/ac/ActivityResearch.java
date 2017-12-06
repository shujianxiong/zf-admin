/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ac;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;

/**
 * 调研活动表Entity
 * @author liut
 * @version 2016-05-25
 */
public class ActivityResearch extends DataEntity<ActivityResearch> {
	
	private static final long serialVersionUID = 1L;
	private AcActivity activity;			// 活动
	private Questionnaire questionnaire;	// 问卷
	
	public ActivityResearch() {
		super();
	}

	public ActivityResearch(String id){
		super(id);
	}

	@Length(min=1, max=64, message="活动ID长度必须介于 1 和 64 之间")
	public AcActivity getActivity() {
		return activity;
	}

	public void setActivity(AcActivity activity) {
		this.activity = activity;
	}
	
	@Length(min=1, max=64, message="问卷ID长度必须介于 1 和 64 之间")
	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}
	
}