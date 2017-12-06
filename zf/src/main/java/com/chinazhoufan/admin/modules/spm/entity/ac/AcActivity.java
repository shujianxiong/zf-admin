/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ac;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 调研活动表Entity
 * @author liut
 * @version 2016-05-19
 */
public class AcActivity extends DataEntity<AcActivity> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 活动名称
	private String activityType;		// 活动类型（调研/推广）
	private String title;		// 活动标题
	private String subtitle;		// 活动副标题
	private String shareSPhoto;		// 分享小图
	private String shareMPhoto;		// 分享中图
	private String summary;		// 简介
	private String introduce;		// 介绍
	private String ruleDetail;		// 规则详情
	private Integer rewardPoint;		// 奖励积分
	private Prize rewardPrize;		// 奖励奖品ID
	private Date startTime;		// 起始时间
	private Date endTime;		// 结束时间
	private String activeFlag;		// 启用状态（0关闭/1启用）
	private AcActivityTemplate acActivityTemplate;//活动模板
	
	
	
	//------------
	private Date beginRequiredTime;				// 时间段范围的开始时间
	private Date endRequiredTime;				// 时间段范围的结束时间
	
	
	public AcActivity() {
		super();
	}

	public AcActivity(String id){
		super(id);
	}

	@Length(min=1, max=100, message="活动名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="活动类型（调研/推广）长度必须介于 1 和 2 之间")
	public String getActivityType() {
		return activityType;
	}

	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}
	
	@Length(min=1, max=100, message="活动标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=100, message="活动副标题长度必须介于 0 和 100 之间")
	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	
	@Length(min=0, max=255, message="分享小图长度必须介于 0 和 255 之间")
	public String getShareSPhoto() {
		return shareSPhoto;
	}

	public void setShareSPhoto(String shareSPhoto) {
		this.shareSPhoto = shareSPhoto;
	}
	
	@Length(min=0, max=255, message="分享中图长度必须介于 0 和 255 之间")
	public String getShareMPhoto() {
		return shareMPhoto;
	}

	public void setShareMPhoto(String shareMPhoto) {
		this.shareMPhoto = shareMPhoto;
	}
	
	@Length(min=1, max=200, message="简介长度必须介于 1 和 200 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	public String getRuleDetail() {
		return ruleDetail;
	}

	public void setRuleDetail(String ruleDetail) {
		this.ruleDetail = ruleDetail;
	}
	
	public Integer getRewardPoint() {
		return rewardPoint;
	}

	public void setRewardPoint(Integer rewardPoint) {
		this.rewardPoint = rewardPoint;
	}

	public Prize getRewardPrize() {
		return rewardPrize;
	}

	public void setRewardPrize(Prize rewardPrize) {
		this.rewardPrize = rewardPrize;
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
	
	@Length(min=1, max=1, message="启用状态（0关闭/1启用）长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Date getBeginRequiredTime() {
		return beginRequiredTime;
	}

	public void setBeginRequiredTime(Date beginRequiredTime) {
		this.beginRequiredTime = beginRequiredTime;
	}

	public Date getEndRequiredTime() {
		return endRequiredTime;
	}

	public void setEndRequiredTime(Date endRequiredTime) {
		this.endRequiredTime = endRequiredTime;
	}

	public AcActivityTemplate getAcActivityTemplate() {
		return acActivityTemplate;
	}

	public void setAcActivityTemplate(AcActivityTemplate acActivityTemplate) {
		this.acActivityTemplate = acActivityTemplate;
	}
	
	
	
}