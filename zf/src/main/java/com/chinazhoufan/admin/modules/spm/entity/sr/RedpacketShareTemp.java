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
 * 红包分享模板Entity
 * @author 刘晓东
 * @version 2015-11-06
 */
public class RedpacketShareTemp extends DataEntity<RedpacketShareTemp> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 模板名称
	private String amountType;		// 红包金额类型(1固定 2随机)
	private BigDecimal amount;		// 红包金额
	private BigDecimal maxAmount;		// 红包最大金额
	private BigDecimal minAmount;		// 红包最小金额
	private String shareType;		// 抢红包类型(1均分 2随机)
	private Integer activeDays;		// 红包有效时间（天）
	private String numType;		// 红包数量类型(1固定 2随机)
	private Integer num;		// 红包数量
	private Integer maxNum;		// 红包最大数量
	private Integer minNum;		// 红包最小数量
	private String tempStatus;		// 模板使用状态(1新建 2启用 3停用)
	private Date redpacketStartTime;		// 活动启用时间
	private String redpacketType;		// 红包类型(1优惠券)
	private String ruleExplain;		// 规则说明
	private String activeExplain;		// 活动说明
	
	//模板使用状态
	public static final String AMOUNTTYPE_NEW = "1";//新建
	public static final String AMOUNTTYPE_ENABLE = "2";//启用
	public static final String AMOUNTTYPE_DISABLED = "3";//停用
	//红包金额+数量类型
	public static final String AMOUNT_NUM_TYPE_STABLE = "1";//固定
	public static final String AMOUNT_NUM_TYPE_RANDOM = "2";//随机
	
	
	public RedpacketShareTemp() {
		super();
	}

	public RedpacketShareTemp(String id){
		super(id);
	}

	@Length(min=1, max=50, message="模板名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="红包金额类型(1固定 2随机)长度必须介于 1 和 2 之间")
	public String getAmountType() {
		return amountType;
	}

	public void setAmountType(String amountType) {
		this.amountType = amountType;
	}
	
	
	
	@Length(min=1, max=2, message="抢红包类型(1均分 2随机)长度必须介于 1 和 2 之间")
	public String getShareType() {
		return shareType;
	}

	public void setShareType(String shareType) {
		this.shareType = shareType;
	}
	
	
	@Length(min=1, max=2, message="红包数量类型(1固定 2随机)长度必须介于 1 和 2 之间")
	public String getNumType() {
		return numType;
	}

	public void setNumType(String numType) {
		this.numType = numType;
	}
	
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getMaxAmount() {
		return maxAmount;
	}

	public void setMaxAmount(BigDecimal maxAmount) {
		this.maxAmount = maxAmount;
	}

	public BigDecimal getMinAmount() {
		return minAmount;
	}

	public void setMinAmount(BigDecimal minAmount) {
		this.minAmount = minAmount;
	}

	public Integer getActiveDays() {
		return activeDays;
	}

	public void setActiveDays(Integer activeDays) {
		this.activeDays = activeDays;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getMaxNum() {
		return maxNum;
	}

	public void setMaxNum(Integer maxNum) {
		this.maxNum = maxNum;
	}

	public Integer getMinNum() {
		return minNum;
	}

	public void setMinNum(Integer minNum) {
		this.minNum = minNum;
	}

	@Length(min=1, max=2, message="模板使用状态(1新建 2启用 3停用)长度必须介于 1 和 2 之间")
	public String getTempStatus() {
		return tempStatus;
	}

	public void setTempStatus(String tempStatus) {
		this.tempStatus = tempStatus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="活动启用时间不能为空")
	public Date getRedpacketStartTime() {
		return redpacketStartTime;
	}

	public void setRedpacketStartTime(Date redpacketStartTime) {
		this.redpacketStartTime = redpacketStartTime;
	}
	
	@Length(min=1, max=2, message="红包类型(1优惠券)长度必须介于 1 和 2 之间")
	public String getRedpacketType() {
		return redpacketType;
	}

	public void setRedpacketType(String redpacketType) {
		this.redpacketType = redpacketType;
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