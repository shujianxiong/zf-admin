/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.entity.um;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 员工消息中心Entity
 * @author 刘晓东
 * @version 2015-12-11
 */
public class UmMessage extends DataEntity<UmMessage> {
	
	private static final long serialVersionUID = 1L;
	private String category;		// 消息类别（1通知/2提示/3消息）
	private String type;		// 消息类型（系统/个人/流量报警）
	private User sendUser;		// 发送用户ID（为空代表系统）
	private String title;		// 标题
	private String content;		// 内容
	private User receiveUser;		// 接收用户ID
	private String status;		// 消息状态（未查看/已查看）
	private Date pushTime;		// 推送时间
	private Date viewTime;		// 查看时间
	
	private Date beginPushTime;		// 开始 推送时间
	private Date endPushTime;		// 结束 推送时间
	private Date beginViewTime;		// 开始 查看时间
	private Date endViewTime;		// 结束 查看时间
	
	private String delFlagReceive;  //收件人删除标记（0=正常， 1=删除）
	
	//收件人删除标记状态
	public final static String DEL_FLAG_RECEIVE_NORMAL = "0";
	public final static String DEL_FLAG_RECEIVE_DEL = "1";
	
	// 消息状态
	public final static String STATUS_VIEWED = "1";//已查看
	public final static String STATUS_NOT_VIEWED = "0";//未查看
	
	/***消息类别***/
	public final static String CATEGORY_NOTICE = "1";//通知
	public final static String CATEGORY_TIP = "2";//提示
	public final static String CATEGORY_MESSAGE = "3";//消息
	
	/***消息类型***/
	public final static String TYPE_SYSTEM = "1";//系统
	public final static String TYPE_PERSON = "2";//个人
	public final static String TYPE_WARNING = "3";//流量报警
	
	
	public UmMessage() {
		super();
	}

	public UmMessage(String id){
		super(id);
	}

	@Length(min=1, max=2, message="消息类别（通知/提示/消息）长度必须介于 1 和 2 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=1, max=2, message="消息类型（系统/个人/流量报警）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public User getSendUser() {
		return sendUser;
	}

	public void setSendUser(User sendUser) {
		this.sendUser = sendUser;
	}
	
	@Length(min=1, max=50, message="标题长度必须介于 1 和 50 之间")
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
	
	@NotNull(message="接收用户ID不能为空")
	public User getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(User receiveUser) {
		this.receiveUser = receiveUser;
	}
	
	@Length(min=1, max=2, message="消息状态（待推送/已推送/已查看）长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPushTime() {
		return pushTime;
	}

	public void setPushTime(Date pushTime) {
		this.pushTime = pushTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getViewTime() {
		return viewTime;
	}

	public void setViewTime(Date viewTime) {
		this.viewTime = viewTime;
	}
	
	public Date getBeginPushTime() {
		return beginPushTime;
	}

	public void setBeginPushTime(Date beginPushTime) {
		this.beginPushTime = beginPushTime;
	}
	
	public Date getEndPushTime() {
		return endPushTime;
	}

	public void setEndPushTime(Date endPushTime) {
		this.endPushTime = endPushTime;
	}
		
	public Date getBeginViewTime() {
		return beginViewTime;
	}

	public void setBeginViewTime(Date beginViewTime) {
		this.beginViewTime = beginViewTime;
	}
	
	public Date getEndViewTime() {
		return endViewTime;
	}

	public void setEndViewTime(Date endViewTime) {
		this.endViewTime = endViewTime;
	}

	public String getDelFlagReceive() {
		return delFlagReceive;
	}

	public void setDelFlagReceive(String delFlagReceive) {
		this.delFlagReceive = delFlagReceive;
	}
		
	
}