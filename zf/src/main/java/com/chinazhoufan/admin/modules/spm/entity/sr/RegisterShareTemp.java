/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.sr;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 注册分享模板Entity
 * @author 刘晓东
 * @version 2015-11-06
 */
public class RegisterShareTemp extends DataEntity<RegisterShareTemp> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 模板名称
	private String tempStatus;		// 模板使用状态(1新建 2启用 3停用)
	private BigDecimal rewardAmount;		// 奖励金额
	private Date activeStartTime;		// 活动启用时间
	private Integer activeDays;		// 有效时间（天）
	private String rewardType;		// 邀请奖励类型(1优惠券)
	private String shareUrl;		// 分享URL
	private String shareTitle;		// 分享标题
	private String shareSummary;		// 分享简介
	private String shareIcon;		// 分享ICON
	private String sharePhoto;		// 分享广告图
	private String shareColor;		// 分享背景色
	private String ruleExplain;		// 规则说明
	private String activeExplain;		// 活动说明
	
	//模板使用状态
	public static final String TEMPSTATUS_NEW = "1";//新建
	public static final String TEMPSTATUS_ENABLE = "2";//启用
	public static final String TEMPSTATUS_DISABLED = "3";//停用
	
	
	public RegisterShareTemp() {
		super();
	}

	public RegisterShareTemp(String id){
		super(id);
	}

	@Length(min=1, max=50, message="模板名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="模板使用状态(1新建 2启用 3停用)长度必须介于 1 和 2 之间")
	public String getTempStatus() {
		return tempStatus;
	}

	public void setTempStatus(String tempStatus) {
		this.tempStatus = tempStatus;
	}
	
	public BigDecimal getRewardAmount() {
		return rewardAmount;
	}

	public void setRewardAmount(BigDecimal rewardAmount) {
		this.rewardAmount = rewardAmount;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="活动启用时间不能为空")
	public Date getActiveStartTime() {
		return activeStartTime;
	}

	public void setActiveStartTime(Date activeStartTime) {
		this.activeStartTime = activeStartTime;
	}
	
	public Integer getActiveDays() {
		return activeDays;
	}

	public void setActiveDays(Integer activeDays) {
		this.activeDays = activeDays;
	}

	@Length(min=1, max=2, message="邀请奖励类型(1优惠券)长度必须介于 1 和 2 之间")
	public String getRewardType() {
		return rewardType;
	}

	public void setRewardType(String rewardType) {
		this.rewardType = rewardType;
	}
	
	@Length(min=0, max=2000, message="分享URL长度必须介于 0 和 2000 之间")
	public String getShareUrl() {
		return shareUrl;
	}

	public void setShareUrl(String shareUrl) {
		this.shareUrl = shareUrl;
	}
	
	@Length(min=0, max=100, message="分享标题长度必须介于 0 和 100 之间")
	public String getShareTitle() {
		return shareTitle;
	}

	public void setShareTitle(String shareTitle) {
		this.shareTitle = shareTitle;
	}
	
	@Length(min=0, max=100, message="分享简介长度必须介于 0 和 100 之间")
	public String getShareSummary() {
		return shareSummary;
	}

	public void setShareSummary(String shareSummary) {
		this.shareSummary = shareSummary;
	}
	
	@Length(min=0, max=255, message="分享ICON长度必须介于 0 和 255 之间")
	public String getShareIcon() {
		return shareIcon;
	}

	public void setShareIcon(String shareIcon) {
		this.shareIcon = shareIcon;
	}
	
	@Length(min=0, max=255, message="分享广告图长度必须介于 0 和 255 之间")
	public String getSharePhoto() {
		return sharePhoto;
	}

	public void setSharePhoto(String sharePhoto) {
		this.sharePhoto = sharePhoto;
	}
	
	@Length(min=0, max=50, message="分享背景色长度必须介于 0 和 50 之间")
	public String getShareColor() {
		return shareColor;
	}

	public void setShareColor(String shareColor) {
		this.shareColor = shareColor;
	}
	
	public String getRuleExplain() {
		return ruleExplain;
	}

	public void setRuleExplain(String ruleExplain) {
		this.ruleExplain = ruleExplain;
	}
	
	public String getActiveExplain() {
		return activeExplain;
	}

	public void setActiveExplain(String activeExplain) {
		this.activeExplain = activeExplain;
	}
	
}