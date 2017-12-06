/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.as;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 售后工单Entity
 * @author liut
 * @version 2017-05-18
 */
public class Workorder extends DataEntity<Workorder> {
	
	private static final long serialVersionUID = 1L;
	private String workorderNo;		// 工单编号
	private String workorderType;	// 工单类型（返修/退/换）
	private String status;			// 工单状态
	private Member member;			// 会员ID
	private String usercode;		// 会员账号
	private String orderType;		// 订单类型
	private String orderId;			// 订单ID
	private String orderNo;			// 订单编号
	private String photosUrl;		// 相关图片url
	private String description;		// 描述
	private User appointedUser;		// 被指派人
	
	private List<WorkorderDeal> workorderDealList = Lists.newArrayList();
	/***************************************** 自定义查询条件属性  ******************************************/
	private WorkorderDeal workorderDeal;
	private String waitDealStatus;	// 专门用于获取我的待处理工单列表的状态字段

	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_WORKORDERNO = "ser_as_workorderNo";	// 获取工单编号 字段
	
	//订单类型   bus_order_type
	public static final String ORDER_TYPE_EXPERIENCE 		= "1";	// 体验
	public static final String ORDER_TYPE_APPOINTEXPERIENCE = "2";	// 预约体验
	public static final String ORDER_TYPE_BUY 				= "3";	// 购买
	public static final String ORDER_TYPE_APPOINTBUY 		= "4";	// 预购
	
	//工单类型（返修/退/换） ser_as_workorder_workorderType
	public static final String WORKORDER_TYPE_REPAIR 		= "1";	// 返修
	public static final String WORKORDER_TYPE_REPLACE		= "2";	// 换
	public static final String WORKORDER_TYPE_BACK 			= "3";	// 退
	
	//工单状态  	ser_as_workorder_status
	public static final String WORKORDER_STATUS_WAIT 		= "1";	// 待接受
	public static final String WORKORDER_STATUS_DEAL 		= "2";	// 处理中
	public static final String WORKORDER_STATUS_FINISH 		= "3";	// 已完成
	
	
	
	public Workorder() {
		super();
	}

	public Workorder(String id){
		super(id);
	}

	@Length(min=1, max=50, message="工单编号长度必须介于 1 和 50 之间")
	public String getWorkorderNo() {
		return workorderNo;
	}

	public void setWorkorderNo(String workorderNo) {
		this.workorderNo = workorderNo;
	}
	
	@Length(min=1, max=2, message="工单类型（返修/退/换）长度必须介于 1 和 2 之间")
	public String getWorkorderType() {
		return workorderType;
	}

	public void setWorkorderType(String workorderType) {
		this.workorderType = workorderType;
	}
	
	@Length(min=1, max=2, message="工单状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=64, message="会员ID长度必须介于 0 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=0, max=64, message="会员账号长度必须介于 0 和 64 之间")
	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	
	@Length(min=0, max=2, message="订单类型长度必须介于 0 和 2 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=0, max=64, message="订单ID长度必须介于 0 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=0, max=64, message="订单编号长度必须介于 0 和 64 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=0, max=1000, message="相关图片url长度必须介于 0 和 1000 之间")
	public String getPhotosUrl() {
		return photosUrl;
	}

	public void setPhotosUrl(String photosUrl) {
		this.photosUrl = photosUrl;
	}
	
	@Length(min=0, max=1000, message="描述长度必须介于 0 和 1000 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<WorkorderDeal> getWorkorderDealList() {
		return workorderDealList;
	}

	public void setWorkorderDealList(List<WorkorderDeal> workorderDealList) {
		this.workorderDealList = workorderDealList;
	}

	public User getAppointedUser() {
		return appointedUser;
	}

	public void setAppointedUser(User appointedUser) {
		this.appointedUser = appointedUser;
	}

	public WorkorderDeal getWorkorderDeal() {
		return workorderDeal;
	}

	public void setWorkorderDeal(WorkorderDeal workorderDeal) {
		this.workorderDeal = workorderDeal;
	}

	public String getWaitDealStatus() {
		return waitDealStatus;
	}

	public void setWaitDealStatus(String waitDealStatus) {
		this.waitDealStatus = waitDealStatus;
	}

	
	
}