/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.bb;

import javax.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 会员资金账户余额表Entity
 * @author 张金俊
 * @version 2015-11-20
 */
public class BankbookBalance extends DataEntity<BankbookBalance> {
	
	private static final long serialVersionUID = 1L;
	private Member member;				// 会员
	private BigDecimal usableBalance;	// 可用余额
	private BigDecimal frozenBalance;	// 冻结余额
	private Integer lastItemNo;			// 最后流水编号
	
	/************************* 自定义参数  **************************/
	
	private Date beginUpdateDate;		// 开始 更新时间
	private Date endUpdateDate;			// 结束 更新时间
	
	
	
	public BankbookBalance() {
		super();
	}

	public BankbookBalance(String id){
		super(id);
	}
	
	
	
	@NotNull(message = "钱包用户不能为空")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@NotNull(message="可用余额不能为空")
	public BigDecimal getUsableBalance() {
		return usableBalance;
	}

	public void setUsableBalance(BigDecimal usableBalance) {
		this.usableBalance = usableBalance;
	}
	
	@NotNull(message="冻结余额不能为空")
	public BigDecimal getFrozenBalance() {
		return frozenBalance;
	}

	public void setFrozenBalance(BigDecimal frozenBalance) {
		this.frozenBalance = frozenBalance;
	}
	
	public Integer getLastItemNo() {
		return lastItemNo;
	}

	public void setLastItemNo(Integer lastItemNo) {
		this.lastItemNo = lastItemNo;
	}
	
	public Date getBeginUpdateDate() {
		return beginUpdateDate;
	}

	public void setBeginUpdateDate(Date beginUpdateDate) {
		this.beginUpdateDate = beginUpdateDate;
	}
	
	public Date getEndUpdateDate() {
		return endUpdateDate;
	}

	public void setEndUpdateDate(Date endUpdateDate) {
		this.endUpdateDate = endUpdateDate;
	}
		
}