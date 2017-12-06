/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.qa;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 问题基本信息Entity
 * @author 杨晓辉
 * @version 2015-11-17
 */
public class BaseQuestion extends DataEntity<BaseQuestion> {
	
	private static final long serialVersionUID = 1L;
	private String name;			// 问题名称
	private String type;			// 问题类型（场景类/产品类/模式类/防乱答）
	private String description;		// 问题描述
	private String photo;			// 问题图片介绍
	private String answerType;		// 答案类型（单选/多选/填写）
	private String activeFlag;		// 启用状态(0:未启用  1：启用)
//	private String ansId;			// 问题Id
	private List<BaseAnswer> answerList = Lists.newArrayList();			// 答案项集合
	
	
	
	public final static String ANSWERTYPE_RADIO 	= "1";	// 单选
	public final static String ANSWERTYPE_CHECKBOX	= "2";	// 多选
	public final static String ANSWERTYPE_INPUT		= "3";	// 填写
	

	
	public BaseQuestion() {
		super();
	}

	public BaseQuestion(String id){
		super(id);
	}

	
	
	@Length(min=1, max=200, message="问题名称长度必须介于 1 和 200 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="问题类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=1000, message="问题描述长度必须介于 0 和 1000 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=1000, message="问题图片介绍长度必须介于 0 和 1000 之间")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	@Length(min=1, max=2, message="答案类型长度必须介于 1 和 2 之间")
	public String getAnswerType() {
		return answerType;
	}

	public void setAnswerType(String answerType) {
		this.answerType = answerType;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public List<BaseAnswer> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<BaseAnswer> answerList) {
		this.answerList = answerList;
	}
	
}