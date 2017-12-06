/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ic;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 会员邀请码表Entity
 * @author 刘晓东
 * @version 2016-05-19
 */
public class InviteCode extends DataEntity<InviteCode> {
	
	private static final long serialVersionUID = 1L;
	private String createrId;		// 会员（记录活动邀请人）
	private String inviteCode;	// 邀请码
	private AcActivity activity;// 适用活动ID
	private String useFlag;		// 使用标记（0：未使用）
	private Member useMember;	// 使用会员（记录活动被邀请人，邀请码的使用者）
	private Date useTime;		// 使用时间
	private String createrType;	// 创建类型（U：员工    M：会员）（创建类型为员工，则记录为“创建者”创建；创建类型为会员，则记录为“会员”创建）
	
	public static final String USEFLAG_NO 	= "0";	// 未使用
	public static final String USEFLAG_YES 	= "1";	// 已使用
	
	public static final String CREATERTYPE_USER 	= "U";	// 创建类型：公司员工
	public static final String CREATERTYPE_MEMBER 	= "M";	// 创建类型：注册会员
	
	public InviteCode() {
		super();
	}

	public InviteCode(String id){
		super(id);
	}

	public void setUseMember(Member useMember) {
		this.useMember = useMember;
	}

	@Length(min=1, max=50, message="邀请码长度必须介于 1 和 50 之间")
	public String getInviteCode() {
		return inviteCode;
	}

	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}
	
	public AcActivity getActivity() {
		return activity;
	}

	public void setActivity(AcActivity activity) {
		this.activity = activity;
	}

	@Length(min=1, max=1, message="使用标记（0：未使用）长度必须介于 1 和 1 之间")
	public String getUseFlag() {
		return useFlag;
	}

	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	
	public Member getUseMember() {
		return useMember;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUseTime() {
		return useTime;
	}

	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}

	public String getCreaterId() {
		return createrId;
	}

	public void setCreaterId(String createrId) {
		this.createrId = createrId;
	}

	@Length(min=1, max=2, message="创建类型（U：员工 M：会员）长度必须介于 1 和 2 之间")
	public String getCreaterType() {
		return createrType;
	}

	public void setCreaterType(String createrType) {
		this.createrType = createrType;
	}
	
}