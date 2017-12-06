/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.ns;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 订阅Entity
 * @author 张金俊
 * @version 2017-07-18
 */
public class Subscribe extends DataEntity<Subscribe> {
	
	private static final long serialVersionUID = 1L;
	private String targetId;		// 目标ID
	private Member member;			// 会员
	private Notify notify;			// 消息
	private String status;			// 状态
	private String readFlag;		// 查看标记

	/***************************************** 自定义关联对象  ******************************************/
	private Produce produce;		// 产品类目标
	
	/******************************************** 自定义常量  *********************************************/
	// 订阅状态 crm_ns_subscribe_status
	public static final String STATUS_NEW		= "1";	// 新建
	public static final String STATUS_TOREMIND	= "2";	// 待提醒
	public static final String STATUS_REMINDED	= "3";	// 已提醒
	
	
	public Subscribe() {
		super();
	}

	public Subscribe(String id){
		super(id);
	}
	
	
	@Length(min=1, max=64, message="目标ID长度必须介于 1 和 64 之间")
	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=64, message="消息ID长度必须介于 1 和 64 之间")
	public Notify getNotify() {
		return notify;
	}

	public void setNotify(Notify notify) {
		this.notify = notify;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
}