/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.qa;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 问卷列表Entity
 * @author 贾斌
 * @version 2015-11-17
 */
public class Questionnaire extends DataEntity<Questionnaire> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 问卷名称
	private String type;		// 问卷类别(市场调研)
	private String status;      //问卷状态 1新建，2发布
	private String title;		// 问卷标题
	private String description;		// 问卷说明
	private String displayType;		// 展现类型（流程/列表）
	private String rewardPointFlag;		// 是否奖励积分
	private Integer rewardPointNum;		// 奖励积分数量
	
	
	private List<QuestionnaireQue> questionnaireQueList = Lists.newArrayList();
	
	//问卷状态
	public static final String STATUS_NEW = "1"; //新建
	public static final String STATUS_RELEASE = "2"; //发布
	

	public List<QuestionnaireQue> getQuestionnaireQueList() {
		return questionnaireQueList;
	}

	public void setQuestionnaireQueList(List<QuestionnaireQue> questionnaireQueList) {
		this.questionnaireQueList = questionnaireQueList;
	}

	public Questionnaire() {
		super();
	}

	public Questionnaire(String id){
		super(id);
	}

	@Length(min=1, max=100, message="问卷名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="问卷类别长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=100, message="问卷标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=1000, message="问卷说明长度必须介于 0 和 1000 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=1, max=2, message="展现类型（流程/列表）长度必须介于 1 和 2 之间")
	public String getDisplayType() {
		return displayType;
	}

	public void setDisplayType(String displayType) {
		this.displayType = displayType;
	}

	@Length(min=1, max=1, message="是否奖励积分长度必须介于 1 和 1 之间")
	public String getRewardPointFlag() {
		return rewardPointFlag;
	}

	public void setRewardPointFlag(String rewardPointFlag) {
		this.rewardPointFlag = rewardPointFlag;
	}

	public Integer getRewardPointNum() {
		return rewardPointNum;
	}

	public void setRewardPointNum(Integer rewardPointNum) {
		this.rewardPointNum = rewardPointNum;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}