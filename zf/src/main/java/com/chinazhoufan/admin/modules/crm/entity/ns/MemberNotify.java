/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.ns;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 会员消息Entity
 * @author 张金俊
 * @version 2017-07-18
 */
public class MemberNotify extends DataEntity<MemberNotify> {
	
	private static final long serialVersionUID = 1L;
	private Member member;			// 会员
	private Notify notify;			// 消息
	private String notifyType;		// 消息类型（1：公告Announce、2：提醒Remind、3：信息Message）   crm_ns_notify_type
	private String title;			// 标题
	private String content;			// 内容
	private String readFlag;		// 查看标记
	private Date readTime;			// 查看时间

	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginReadTime;		// 开始 查看时间
	private Date endReadTime;		// 结束 查看时间
	
	
	public MemberNotify() {
		super();
	}

	
	public MemberNotify(Member member, Notify notify, String readFlag) {
		super();
		this.member = member;
		this.notify = notify;
		this.notifyType = notify.getType();
		this.title = notify.getTitle();
		this.readFlag = readFlag;
	}
	
	public MemberNotify(String id){
		super(id);
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
	
	public String getNotifyType() {
		return notifyType;
	}

	public void setNotifyType(String notifyType) {
		this.notifyType = notifyType;
	}

	@Length(min=1, max=200, message="标题长度必须介于 1 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=1, max=1, message="查看标记长度必须介于 1 和 1 之间")
	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReadTime() {
		return readTime;
	}

	public void setReadTime(Date readTime) {
		this.readTime = readTime;
	}
	
	public Date getBeginReadTime() {
		return beginReadTime;
	}

	public void setBeginReadTime(Date beginReadTime) {
		this.beginReadTime = beginReadTime;
	}
	
	public Date getEndReadTime() {
		return endReadTime;
	}

	public void setEndReadTime(Date endReadTime) {
		this.endReadTime = endReadTime;
	}
		
}