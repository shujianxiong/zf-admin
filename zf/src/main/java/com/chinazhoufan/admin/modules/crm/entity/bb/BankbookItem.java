/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.bb;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 会员资金账户流水表Entity
 * @author 张金俊
 * @version 2015-11-23
 */
public class BankbookItem extends DataEntity<BankbookItem> {

	private static final long serialVersionUID = 1L;
	private Integer itemNo; 					// 流水号（所有流水的编号 顺序增长）
	private BankbookBalance bankbookBalance; 	// 资金账户
	private String changeType; 					// 变动类型（UBA/UBD/UB2FB等）
	private String moneyType; 					// 资金类型（UBA01：可用余额充值    UB2FB01：申请提现    与变动类型相关）
	private BigDecimal money; 					// 变动金额
	private BigDecimal usableBalance; 			// 变动后可用金额
	private BigDecimal frozenBalance; 			// 变动后冻结金额
	private Integer lastItemNo; 				// 上一次流水号
	private BigDecimal lastUsableBalance; 		// 上一次可用余额
	private BigDecimal lastFrozenBalance; 		// 上一次冻结余额
	private String uniqueNo; 					// 来源业务编号（变动类型与来源业务编号应保证联合唯一）（下单扣款则保存订单ID，后台存折条目扣补则保存存折条目ID）

	/**===============================资金变动类型  与字典同步======================================*/
	// 变动类型 crm_bb_bankbook_changeType
	public static final String CHANGETYPE_UBA 	= "UBA";	// 可用金额增加
	public static final String CHANGETYPE_UBD 	= "UBD";	// 可用金额扣减
	public static final String CHANGETYPE_UB2FB = "UB2FB";	// 可用转冻结
	
	public static final String CHANGETYPE_FBA 	= "FBA";	// 冻结金额增加
	public static final String CHANGETYPE_FBD 	= "FBD";	// 冻结金额扣减
	public static final String CHANGETYPE_FB2UB = "FB2UB";	// 冻结转可用

	// 资金类型 crm_bb_bankbook_moneyType
	public static final String MONEYTYPE_UBA_CHARGE 		= "UBA01";		// 余额充值
	public static final String MONEYTYPE_UBD_ORDERPAY 		= "UBD01";		// 订单支付
	public static final String MONEYTYPE_UB2FB_CASHAPPLY 	= "UB2FB01";	// 申请提现
	
	public static final String MONEYTYPE_FBD_CASHFINISH 	= "FBD01";		// 提现完成
	
	
	
	public BankbookItem() {}

	public BankbookItem(String id) {
		super(id);
	}

	public BankbookItem(Integer itemNo, BankbookBalance bankbookBalance,
			String changeType, String moneyType, BigDecimal money,
			BigDecimal usableBalance, BigDecimal frozenBalance,
			Integer lastItemNo, 
			BigDecimal lastUsableBalance, BigDecimal lastFrozenBalance,
			String uniqueNo) {
		this.itemNo = itemNo;
		this.bankbookBalance = bankbookBalance;
		this.changeType = changeType;
		this.moneyType = moneyType;
		this.money = money;
		this.usableBalance = usableBalance;
		this.frozenBalance = frozenBalance;
		this.lastItemNo = lastItemNo;
		this.lastUsableBalance = lastUsableBalance;
		this.lastFrozenBalance = lastFrozenBalance;
		this.uniqueNo = uniqueNo;
	}
	
	
	
	@Length(min = 1, max = 11, message = "流水编号长度必须介于 1 和 11 之间")
	public Integer getItemNo() {
		return itemNo;
	}

	public void setItemNo(Integer itemNo) {
		this.itemNo = itemNo;
	}

	public BankbookBalance getBankbookBalance() {
		return bankbookBalance;
	}

	public void setBankbookBalance(BankbookBalance bankbookBalance) {
		this.bankbookBalance = bankbookBalance;
	}

	@Length(min = 1, max = 10, message = "变动类型长度必须介于 1 和 10 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	@Length(min = 1, max = 10, message = "资金类型长度必须介于 1 和 10 之间")
	public String getMoneyType() {
		return moneyType;
	}

	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}

	@Length(min = 0, max = 11, message = "上一次流水编号长度必须介于 0 和 11 之间")
	public Integer getLastItemNo() {
		return lastItemNo;
	}

	public void setLastItemNo(Integer lastItemNo) {
		this.lastItemNo = lastItemNo;
	}

	@Length(min = 0, max = 64, message = "来源业务编号长度必须介于 0 和 64 之间")
	public String getUniqueNo() {
		return uniqueNo;
	}

	public void setUniqueNo(String uniqueNo) {
		this.uniqueNo = uniqueNo;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getUsableBalance() {
		return usableBalance;
	}

	public void setUsableBalance(BigDecimal usableBalance) {
		this.usableBalance = usableBalance;
	}

	public BigDecimal getFrozenBalance() {
		return frozenBalance;
	}

	public void setFrozenBalance(BigDecimal frozenBalance) {
		this.frozenBalance = frozenBalance;
	}

	public BigDecimal getLastUsableBalance() {
		return lastUsableBalance;
	}

	public void setLastUsableBalance(BigDecimal lastUsableBalance) {
		this.lastUsableBalance = lastUsableBalance;
	}

	public BigDecimal getLastFrozenBalance() {
		return lastFrozenBalance;
	}

	public void setLastFrozenBalance(BigDecimal lastFrozenBalance) {
		this.lastFrozenBalance = lastFrozenBalance;
	}

}