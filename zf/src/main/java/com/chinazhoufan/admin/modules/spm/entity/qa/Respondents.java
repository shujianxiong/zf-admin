/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.qa;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 答卷列表Entity
 * @author 贾斌
 * @version 2015-11-18
 */
public class Respondents extends DataEntity<Respondents> {
	
	private static final long serialVersionUID = 1L;
	private Questionnaire questionnaire;	// 问卷
	private Member member;					// 答题会员
	private String answerChannel;			// 答题渠道
	private Date startTime;					// 起始时间
	private Date endTime;					// 结束时间
	private Integer point;					// 获得分值
	private List<RespondentsAns> respondentsAnsList = Lists.newArrayList();//答卷问题答案list
	
	//答题渠道
	public final static String ANSWERCHANNEL_WECHAT = "1" ;//微信
	
	public Respondents() {
		super();
	}

	public Respondents(String id){
		super(id);
	}
	
	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Length(min=1, max=2, message="答题渠道长度必须介于 1 和 2 之间")
	public String getAnswerChannel() {
		return answerChannel;
	}

	public void setAnswerChannel(String answerChannel) {
		this.answerChannel = answerChannel;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="起始时间不能为空")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="结束时间不能为空")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public List<RespondentsAns> getRespondentsAnsList() {
		return respondentsAnsList;
	}

	public void setRespondentsAnsList(List<RespondentsAns> respondentsAnsList) {
		this.respondentsAnsList = respondentsAnsList;
	}
	
}