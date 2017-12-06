/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.zi;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 芝麻信用配置Entity
 * @author liuxiaodong
 * @version 2017-09-23
 */
public class Zmxy extends DataEntity<Zmxy> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String summary;		// 简介
	private Integer scoreMax;		// 分值上线
	private Integer scoreMin;		// 分值下线
	private BigDecimal depositRate;		// 押金比例
	private Integer duration;		// 持续时间(天)
	private BigDecimal amount;		// 限定金额
	private Integer limitOrderNum;	//限制下单数量
	private String activeFlag;		// 启用状态
	
	public Zmxy() {
		super();
	}

	public Zmxy(String id){
		super(id);
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=500, message="简介长度必须介于 1 和 500 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public Integer getScoreMax() {
		return scoreMax;
	}

	public void setScoreMax(Integer scoreMax) {
		this.scoreMax = scoreMax;
	}

	public Integer getScoreMin() {
		return scoreMin;
	}

	public void setScoreMin(Integer scoreMin) {
		this.scoreMin = scoreMin;
	}

	public BigDecimal getDepositRate() {
		return depositRate;
	}

	public void setDepositRate(BigDecimal depositRate) {
		this.depositRate = depositRate;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Integer getLimitOrderNum() {
		return limitOrderNum;
	}

	public void setLimitOrderNum(Integer limitOrderNum) {
		this.limitOrderNum = limitOrderNum;
	}
	
}