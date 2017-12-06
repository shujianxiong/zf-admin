/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.bs;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 货品定损标准Entity
 * @author liut
 * @version 2016-11-19
 */
public class BreakdownStandard extends DataEntity<BreakdownStandard> {
	
	private static final long serialVersionUID = 1L;
	private String breakdownType;			// 问题类型（破损/刮花）（bus_pr_product_repair_breakdownType）
	private BigDecimal moneyLossPercent;	// 定损百分比（如：0.001）
	private BigDecimal beansDecFlag;	// 魅力豆可抵标记

	/******************************************** 自定义常量  *********************************************/

	public static final String BEANS_NO	= "0";	// 魅力豆不可抵

	public static final String BEANS_YES	= "1";	// 魅力豆可抵
	public BreakdownStandard() {
		super();
	}

	public BreakdownStandard(String id){
		super(id);
	}

	
	@Length(min=1, max=2, message="问题类型（破损/刮花）长度必须介于 1 和 2 之间")
	public String getBreakdownType() {
		return breakdownType;
	}

	public void setBreakdownType(String breakdownType) {
		this.breakdownType = breakdownType;
	}
	
	public BigDecimal getMoneyLossPercent() {
		return moneyLossPercent;
	}

	public void setMoneyLossPercent(BigDecimal moneyLossPercent) {
		this.moneyLossPercent = moneyLossPercent;
	}

	public BigDecimal getBeansDecFlag() {
		return beansDecFlag;
	}

	public void setBeansDecFlag(BigDecimal beansDecFlag) {
		this.beansDecFlag = beansDecFlag;
	}
}