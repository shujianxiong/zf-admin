/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ai;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 活动参与记录Entity
 * @author 张金俊
 * @version 2017-08-04
 */
public class ActivityRecord extends DataEntity<ActivityRecord> {
	
	private static final long serialVersionUID = 1L;
	private Activity activity;		// 活动
	private Member member;			// 会员
	
	
	
	public ActivityRecord() {
		super();
	}

	public ActivityRecord(String id){
		super(id);
	}

	
	
	@Length(min=1, max=64, message="活动ID长度必须介于 1 和 64 之间")
	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}
	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
}