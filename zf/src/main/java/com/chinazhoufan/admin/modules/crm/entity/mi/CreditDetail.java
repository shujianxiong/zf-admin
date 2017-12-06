/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mi;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 会员信誉流水Entity
 * @author 张金俊
 * @version 2017-04-26
 */
public class CreditDetail extends DataEntity<CreditDetail> {
	
	private static final long serialVersionUID = 1L;
	private Member member;				// 会员
	private String changeType;			// 变动类型（增/减）
	private Integer changeCredit;		// 变动信誉积分数量
	private Integer lastCredit;			// 变动后积分
	private String changeReasonType;	// 变动原因
	private Date changeTime;			// 变动时间
	private String operaterType;		// 操作人类型（会员/员工/系统）
	private String operateSourceNo;		// 来源业务编号
	
	//变动类型 [add_decrease]
	public static final String CHANGE_TYPE_ADD 		= "A";	// 增加
	public static final String CHANGE_TYPE_DECREASE = "D";	// 减少
	//操作人类型 [operater_type]
	public static final String OPERATER_TYPE_MEMBER = "M";	// 会员
	public static final String OPERATER_TYPE_STAFF 	= "U";	// 员工
	public static final String OPERATER_TYPE_SYS 	= "S";	// 系统
	//变动原因 [crm_mi_credit_detail_changeReasonType]
	public static final String CRT_A_REALNAME 		= "A1";	// 实名
	
	
	public CreditDetail() {
		super();
	}

	public CreditDetail(String id){
		super(id);
	}

	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=2, message="变动类型长度必须介于 1 和 2 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	
	public Integer getChangeCredit() {
		return changeCredit;
	}

	public void setChangeCredit(Integer changeCredit) {
		this.changeCredit = changeCredit;
	}
	
	public Integer getLastCredit() {
		return lastCredit;
	}

	public void setLastCredit(Integer lastCredit) {
		this.lastCredit = lastCredit;
	}
	
	@Length(min=1, max=2, message="变动原因长度必须介于 1 和 2 之间")
	public String getChangeReasonType() {
		return changeReasonType;
	}

	public void setChangeReasonType(String changeReasonType) {
		this.changeReasonType = changeReasonType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="变动时间不能为空")
	public Date getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(Date changeTime) {
		this.changeTime = changeTime;
	}
	
	@Length(min=1, max=2, message="操作人类型长度必须介于 1 和 2 之间")
	public String getOperaterType() {
		return operaterType;
	}

	public void setOperaterType(String operaterType) {
		this.operaterType = operaterType;
	}
	
	@Length(min=0, max=64, message="来源业务编号长度必须介于 0 和 64 之间")
	public String getOperateSourceNo() {
		return operateSourceNo;
	}

	public void setOperateSourceNo(String operateSourceNo) {
		this.operateSourceNo = operateSourceNo;
	}
	
}