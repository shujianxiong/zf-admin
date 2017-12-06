/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ep;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 邀请人Entity
 * @author 舒剑雄
 * @version 2017-08-31
 */
public class Invitation extends DataEntity<Invitation> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private Integer historyInviteder;		// 历史邀请人数量
	
	public Invitation() {
		super();
	}

	public Invitation(String id){
		super(id);
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Integer getHistoryInviteder() {
		return historyInviteder;
	}

	public void setHistoryInviteder(Integer historyInviteder) {
		this.historyInviteder = historyInviteder;
	}
	
}