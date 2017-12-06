/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.bb;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 会员资金账户临时条目表Entity
 * @author 陈适
 * @version 2015-11-23
 */
public class BankbookTemp extends DataEntity<BankbookTemp> {
	
	private static final long serialVersionUID = 1L;
	private BankbookBalance bankbookBalance;	// 资金账户
	private Integer tempSerialNo;				// 账户条目序列号	某一账户审核通过的条目的序列号
	private String createType; 					// 创建类型（U:员工 S:系统）
	private String changeType;					// 变动类型（UBA/UBD/UB2FB等）
	private String moneyType;					// 资金类型（UBA01：可用余额充值）
	private BigDecimal money;					// 变动金额
	private String status;						// 条目状态   1.新建    2.审核通过    3.审核拒绝
	private String checkBy;						// 审核者
	private Date checkTime;						// 审核时间
	private String checkMsg;					// 处理结果
	
	/**查询条件***********************************************************/	
	private Date beginTime;	//  变更 时间段查询
	private Date endTime;

	public static final String STATUS_NEW = "1";//条目状态：新建
	public static final String STATUS_OK = "2";//条目状态：通过
	public static final String STATUS_NO = "3";//条目状态：拒绝
		
	
	public BankbookTemp() {
		super();
	}

	public BankbookTemp(String id){
		super(id);
	}

	
	public BankbookBalance getBankbookBalance() {
		return bankbookBalance;
	}

	public void setBankbookBalance(BankbookBalance bankbookBalance) {
		this.bankbookBalance = bankbookBalance;
	}

//	@Length(min=0, max=11, message="账户条目序列号长度必须介于 0 和 11 之间")
	public Integer getTempSerialNo() {
		return tempSerialNo;
	}

	public void setTempSerialNo(Integer tempSerialNo) {
		this.tempSerialNo = tempSerialNo;
	}
	
	@Length(min = 0, max = 2, message = "创建类型长度必须介于 0 和 2 之间")
	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}
	
	@Length(min=1, max=10, message="变动类型长度必须介于 1 和 10 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	
	@Length(min=1, max=10, message="资金类型长度必须介于 1 和 10 之间")
	public String getMoneyType() {
		return moneyType;
	}

	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}
	
	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	
	@Length(min=0, max=2, message="条目状态长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCheckBy() {
		return checkBy;
	}

	public void setCheckBy(String checkBy) {
		this.checkBy = checkBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	
	@Length(min=0, max=50, message="处理结果长度必须介于 0 和 50 之间")
	public String getCheckMsg() {
		return checkMsg;
	}

	public void setCheckMsg(String checkMsg) {
		this.checkMsg = checkMsg;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
}