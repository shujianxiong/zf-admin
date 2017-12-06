/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.cl;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 会员搭配收藏Entity
 * @author 张金俊
 * @version 2016-10-26
 */
public class CollocationCollect extends DataEntity<CollocationCollect> {
	
	private static final long serialVersionUID = 1L;
	private Member member;				// 会员
	private String collocation;	// 搭配
	
	
	public CollocationCollect() {
		super();
	}

	public CollocationCollect(String id){
		super(id);
	}
	

	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=64, message="搭配ID长度必须介于 1 和 64 之间")
	public String getCollocation() {
		return collocation;
	}

	public void setCollocation(String collocation) {
		this.collocation = collocation;
	}
	
}