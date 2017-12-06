/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mb;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

import java.util.Date;

/**
 * 会员魅力豆Entity
 * @author 张金俊
 * @version 2017-08-03
 */
public class Beans extends DataEntity<Beans> {
	
	private static final long serialVersionUID = 1L;
	private Member member;				// 会员ID
	private Integer historyBeans;		// 历史魅力豆
	private Integer currentBeans;		// 当前魅力豆
	private Integer lastItemNo;			// 最后流水号
	
	/******************************************** 自定义参数  *********************************************/
	private Date beginUpdateDate;		// 开始 更新时间
	private Date endUpdateDate;			// 结束 更新时间

	/******************************************** 自定义常量  *********************************************/
	public static final String BEANS_EXCHANGE_SCALE	= "beansExchangeScale";	// 魅力豆兑换资金比例（一颗魅力豆可兑换或抵扣的现金数量（单位元））


	
	public Beans() {
		super();
	}

	public Beans(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@NotNull(message="历史魅力豆不能为空")
	public Integer getHistoryBeans() {
		return historyBeans;
	}

	public void setHistoryBeans(Integer historyBeans) {
		this.historyBeans = historyBeans;
	}
	
	@NotNull(message="当前魅力豆不能为空")
	public Integer getCurrentBeans() {
		return currentBeans;
	}

	public void setCurrentBeans(Integer currentBeans) {
		this.currentBeans = currentBeans;
	}

	@NotNull(message="最后流水号不能为空")
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