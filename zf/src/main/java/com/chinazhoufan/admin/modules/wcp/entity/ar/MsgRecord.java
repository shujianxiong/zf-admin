/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.entity.ar;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 消息发送记录Entity
 * @author 张金俊
 * @version 2016-05-30
 */
public class MsgRecord extends DataEntity<MsgRecord> {
	
	private static final long serialVersionUID = 1L;
	private String platformType;	// 消息发送平台（微信）
	private String sendType;		// 信息发送类型（发/回）
	private String replyType;		// 回复类型（客服/系统）
	private String fromUserName;	// 发送人微信ID
	private String fromUserId;		// 发送人周范ID
	private String toUserName;		// 接收人微信ID
	private String toUserId;		// 接收人周范ID
	private String contentType;		// 内容类型
	private String content;			// 内容
	private AutoReply autoReply;	// 自动回复（ID）
	
	
	/***************************************************/
	// 消息发送平台（微信） wcp_ar_msg_record_platformType
	public static final String PLATFORMTYPE_WC 	= "WC";		// 微信
	
	// 信息发送类型（发/回） wcp_ar_msg_record_sendType
	public static final String SENDTYPE_SEND 	= "SEND";	// 发送
	public static final String SENDTYPE_REPLY 	= "REPLY";	// 回复
	
	// 回复类型（客服/系统） wcp_ar_msg_record_replyType
	public static final String REPLYTYPE_S = "S";			// 系统
	public static final String REPLYTYPE_U = "U";			// 客服
	
	
	
	public MsgRecord() {
		super();
	}

	public MsgRecord(String id){
		super(id);
	}
	
	

	@Length(min=1, max=10, message="消息发送平台（微信）长度必须介于 1 和 10 之间")
	public String getPlatformType() {
		return platformType;
	}

	public void setPlatformType(String platformType) {
		this.platformType = platformType;
	}
	
	@Length(min=1, max=10, message="信息发送类型（发/回）长度必须介于 1 和 10 之间")
	public String getSendType() {
		return sendType;
	}

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}
	
	@Length(min=1, max=2, message="回复类型（客服/系统）长度必须介于 1 和 2 之间")
	public String getReplyType() {
		return replyType;
	}

	public void setReplyType(String replyType) {
		this.replyType = replyType;
	}
	
	@Length(min=1, max=100, message="发送人微信ID长度必须介于 1 和 100 之间")
	public String getFromUserName() {
		return fromUserName;
	}

	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}
	
	@Length(min=0, max=64, message="发送人周范ID长度必须介于 0 和 64 之间")
	public String getFromUserId() {
		return fromUserId;
	}

	public void setFromUserId(String fromUserId) {
		this.fromUserId = fromUserId;
	}
	
	@Length(min=1, max=100, message="接收人微信ID长度必须介于 1 和 100 之间")
	public String getToUserName() {
		return toUserName;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}
	
	@Length(min=0, max=64, message="接收人周范ID长度必须介于 0 和 64 之间")
	public String getToUserId() {
		return toUserId;
	}

	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}
	
	@Length(min=1, max=10, message="内容类型长度必须介于 1 和 10 之间")
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	@Length(min=1, max=500, message="内容长度必须介于 1 和 500 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=1, max=64, message="自动回复ID长度必须介于 1 和 64 之间")
	public AutoReply getAutoReply() {
		return autoReply;
	}

	public void setAutoReply(AutoReply autoReply) {
		this.autoReply = autoReply;
	}
	
}