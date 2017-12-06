/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.entity.uw;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.util.Calendar;
import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 员工报警中心Entity
 * @author 刘晓东
 * @version 2015-12-10
 */
public class Warning extends DataEntity<Warning> {
	
	private static final long serialVersionUID = 1L;
	private String category;			// 警报类别（库存监控/物流调货）  msg_uw_warning_category
	private String type;				// 警报类型（库存超标/到货延迟/低于安全库存/低于警报库存）   	msg_uw_warning_type
	private User sendUser;				// 发送用户ID（为空代表系统）
	private String title;				// 标题
	private String content;				// 内容
	private User receiveUser;			// 接收用户ID
	private User dealUser;				// 处理用户ID
	private String status;				// 警报状态（待推/已推/已看/处理中/完成）
	private Date pushTime;				// 推送时间
	private Date viewTime;				// 查看时间
	private Date dealStartTime;			// 处理开始时间
	private Date dealEndTime;			// 处理完成时间
	private String dealResultType;		// 处理结果类型
	private String dealResultRemarks;	// 处理结果备注
	
	//警报类别  msg_uw_warning_category
	public static final String CATEGORY_STOCK 	= "0";	// 库存监控
	public static final String CATEGORY_TRANSFER= "1";	// 物流调货

	//警报类型  msg_uw_warning_type
	public static final String TYPE_OVER 		= "0";	// 库存超标
	public static final String TYPE_DELAY 		= "1";	// 到货延迟.
	public static final String TYPE_SAFETY 		= "2";	// 低于安全库存
	public static final String TYPE_AlARM 		= "3";	// 低于警报库存
	public final static String TYPE_WEIGHT 		= "4";	// 克重异常
	
	//警报状态 msg_uw_warning_status
	public static final String STATUS_TO_VIEW	= "1";	// 待查看
	public static final String STATUS_TO_DEAL	= "2";	// 待处理
	public static final String STATUS_FINISH	= "3";	// 已处理
	
	
	public Warning() {
		super();
	}

	public Warning(String id){
		super(id);
	}
	

	public Warning(String category, String type, String title) {
		this.category = category;
		this.type = type;
		this.title = title;
		this.status = STATUS_TO_VIEW;
		this.pushTime = Calendar.getInstance().getTime();
	}

	@Length(min=1, max=2, message="警报类别（库存监控/物流调货）长度必须介于 1 和 2 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@Length(min=1, max=2, message="警报类型（库存超标/到货延迟）长度必须介于 1 和 2 之间")
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
	
	public User getDealUser() {
		return dealUser;
	}

	public void setDealUser(User dealUser) {
		this.dealUser = dealUser;
	}
	
	@Length(min=1, max=2, message="警报状态（待推/已推/已看/处理中/完成）长度必须介于 1 和 2 之间")
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
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDealStartTime() {
		return dealStartTime;
	}

	public void setDealStartTime(Date dealStartTime) {
		this.dealStartTime = dealStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDealEndTime() {
		return dealEndTime;
	}

	public void setDealEndTime(Date dealEndTime) {
		this.dealEndTime = dealEndTime;
	}
	
	@Length(min=0, max=10, message="处理结果类型长度必须介于 0 和 10 之间")
	public String getDealResultType() {
		return dealResultType;
	}

	public void setDealResultType(String dealResultType) {
		this.dealResultType = dealResultType;
	}
	
	@Length(min=0, max=10, message="处理结果备注长度必须介于 0 和 10 之间")
	public String getDealResultRemarks() {
		return dealResultRemarks;
	}

	public void setDealResultRemarks(String dealResultRemarks) {
		this.dealResultRemarks = dealResultRemarks;
	}
	
}