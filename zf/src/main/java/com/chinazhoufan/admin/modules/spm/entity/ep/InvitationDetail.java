/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ep;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 邀请人记录Entity
 * @author 舒剑雄
 * @version 2017-09-04
 */
public class InvitationDetail extends DataEntity<InvitationDetail> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private String invitederOpenid;		// 被邀请人openid

	private String orderFlag;		// 被邀请人是否下过单

	private String userFlag;		// 是否已使用

	public String getOrderFlag() {
		return orderFlag;
	}

	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}

	public String getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}

	public InvitationDetail() {
		super();
	}

	public InvitationDetail(String id){
		super(id);
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=0, max=11, message="被邀请人openid长度必须介于 0 和 11 之间")
	public String getInvitederOpenid() {
		return invitederOpenid;
	}

	public void setInvitederOpenid(String invitederOpenid) {
		this.invitederOpenid = invitederOpenid;
	}
	
}