/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.oe;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 体验单欠款临时记录
 * @author 舒剑雄
 * @version 2017-10-15
 */
public class ExperienceOrderDueTemp  {

	private BigDecimal moneySettDec;			// 结算扣减金额
	private BigDecimal moneySettOverdue;		// 结算滞纳金
	private BigDecimal moneySettReturn;			// 结算退款金额
	private BigDecimal moneySettSrcReturn;		// 结算原始应退金额
	private BigDecimal moneySettDecableBeans;	// 结算魅力豆可抵金额
	private BigDecimal moneySettDecBeans;		// 结算魅力豆抵扣金额
	private Integer numSettDecBeans;			// 结算魅力豆抵扣数量
	private BigDecimal moneySettReturnExpress;	// 结算退还回程快递费
	private Date settlementTime;				// 结算时间
	private BigDecimal buyOrderMoney;				// 结算时间
	private BigDecimal arrearageAmount;			// 欠费金额
	private String orderNo;
	private String memberId;
	private String damageType;              //存在损坏类型，按严重程度高的记录

	public BigDecimal getMoneySettDec() {
		return moneySettDec;
	}

	public void setMoneySettDec(BigDecimal moneySettDec) {
		this.moneySettDec = moneySettDec;
	}

	public BigDecimal getMoneySettOverdue() {
		return moneySettOverdue;
	}

	public void setMoneySettOverdue(BigDecimal moneySettOverdue) {
		this.moneySettOverdue = moneySettOverdue;
	}

	public BigDecimal getMoneySettReturn() {
		return moneySettReturn;
	}

	public void setMoneySettReturn(BigDecimal moneySettReturn) {
		this.moneySettReturn = moneySettReturn;
	}

	public BigDecimal getMoneySettSrcReturn() {
		return moneySettSrcReturn;
	}

	public void setMoneySettSrcReturn(BigDecimal moneySettSrcReturn) {
		this.moneySettSrcReturn = moneySettSrcReturn;
	}

	public BigDecimal getMoneySettDecableBeans() {
		return moneySettDecableBeans;
	}

	public void setMoneySettDecableBeans(BigDecimal moneySettDecableBeans) {
		this.moneySettDecableBeans = moneySettDecableBeans;
	}

	public BigDecimal getMoneySettDecBeans() {
		return moneySettDecBeans;
	}

	public void setMoneySettDecBeans(BigDecimal moneySettDecBeans) {
		this.moneySettDecBeans = moneySettDecBeans;
	}

	public Integer getNumSettDecBeans() {
		return numSettDecBeans;
	}

	public void setNumSettDecBeans(Integer numSettDecBeans) {
		this.numSettDecBeans = numSettDecBeans;
	}

	public BigDecimal getMoneySettReturnExpress() {
		return moneySettReturnExpress;
	}

	public void setMoneySettReturnExpress(BigDecimal moneySettReturnExpress) {
		this.moneySettReturnExpress = moneySettReturnExpress;
	}

	public Date getSettlementTime() {
		return settlementTime;
	}

	public void setSettlementTime(Date settlementTime) {
		this.settlementTime = settlementTime;
	}

	public BigDecimal getBuyOrderMoney() {
		return buyOrderMoney;
	}

	public void setBuyOrderMoney(BigDecimal buyOrderMoney) {
		this.buyOrderMoney = buyOrderMoney;
	}

	public BigDecimal getArrearageAmount() {
		return arrearageAmount;
	}

	public void setArrearageAmount(BigDecimal arrearageAmount) {
		this.arrearageAmount = arrearageAmount;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getDamageType() {
		return damageType;
	}

	public void setDamageType(String damageType) {
		this.damageType = damageType;
	}
}