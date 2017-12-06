package com.chinazhoufan.mobile.index.modules.usercenter.vo;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BankbookItemVO {

	private String id;
	
	private Date time; //变动时间
	
	private BigDecimal usableBalance; //可用余额
	
	private BigDecimal money;	//变动金额
	
	private String changeType;	//变动类型

	private String moneyType;	//变动原因

	public BankbookItemVO() {
	}

	public BankbookItemVO(String id, Date time, BigDecimal usableBalance,
			BigDecimal money, String changeType, String moneyType) {
		this.id = id;
		this.time = time;
		this.usableBalance = usableBalance;
		this.money = money;
		this.changeType = changeType;
		this.moneyType = moneyType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@JsonFormat(pattern = "yyyy年MM月dd号")
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public BigDecimal getUsableBalance() {
		return usableBalance;
	}

	public void setUsableBalance(BigDecimal usableBalance) {
		this.usableBalance = usableBalance;
	}

	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getMoneyStr() {
		return money.compareTo(BigDecimal.ZERO)>0?"+"+money.abs().toString():"-"+money.abs().toString();
	}

	public String getMoneyType() {
		return moneyType;
	}

	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}
}
