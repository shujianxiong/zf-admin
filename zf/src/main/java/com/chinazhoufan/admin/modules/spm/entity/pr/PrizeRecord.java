/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pr;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 奖品领取记录表Entity
 * @author liut
 * @version 2016-05-19
 */
public class PrizeRecord extends DataEntity<PrizeRecord> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private Prize prize;		// 奖品ID
	private String reasonType;		// 原因类型（活动参与/积分兑换）
	private Date receiveTime;		// 领取时间
	private String receiveStatus;   //领取状态（0=待领取，1=已领取）
	
	public static final String RECEIVE_WAIT = "0";//待领取
	public static final String RECEIVE_PASS = "1";//已领取
	
	//原因类型
	public static final String REASONTYPE_ACTIVITY = "1"; //活动参与
	public static final String REASONTYPE_EXCHANGE = "2"; //积分兑换
	
	
	public PrizeRecord() {
		super();
	}

	public PrizeRecord(String id){
		super(id);
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Prize getPrize() {
		return prize;
	}

	public void setPrize(Prize prize) {
		this.prize = prize;
	}

	@Length(min=1, max=2, message="原因类型（活动参与/积分兑换）长度必须介于 1 和 2 之间")
	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="领取时间不能为空")
	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}

	public String getReceiveStatus() {
		return receiveStatus;
	}

	public void setReceiveStatus(String receiveStatus) {
		this.receiveStatus = receiveStatus;
	}
	
	
}