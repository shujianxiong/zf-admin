/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ac;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 调研活动参与记录Entity
 * @author 刘晓东
 * @version 2016-05-27
 */
public class ActivityResearchRc extends DataEntity<ActivityResearchRc> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private ActivityResearch activityResearch;		// 调研活动ID
	private String status;		// 参与状态
	
	/*******************************************************************/
	public static final String STATUS_INVOLVING 	= "1";	// 参与中
	public static final String STATUS_FINISH 		= "2";	// 已完成
	
	
	
	public ActivityResearchRc() {
		super();
	}

	public ActivityResearchRc(String id){
		super(id);
	}
	
	

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public ActivityResearch getActivityResearch() {
		return activityResearch;
	}

	public void setActivityResearch(ActivityResearch activityResearch) {
		this.activityResearch = activityResearch;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}