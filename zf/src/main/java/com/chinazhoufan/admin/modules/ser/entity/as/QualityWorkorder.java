/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.as;

import com.google.common.collect.Lists;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

import java.util.List;

/**
 * 质检工单列表Entity
 * @author 舒剑雄
 * @version 2017-10-13
 */
public class QualityWorkorder extends DataEntity<QualityWorkorder> {
	
	private static final long serialVersionUID = 1L;
	private String workorderNo;		// 工单编号
	private String workorderType;		// 工单类型（返修/退/换）
	private String status;		// 工单状态
	private String memberId;		// 会员ID
	private String usercode;		// 会员账号
	private String orderType;		// 订单类型
	private String orderId;		// 订单ID
	private String orderNo;		// 订单编号
	private String description;		// 描述
	private String appointedUser;		// 被指派人

	//订单类型   bus_order_type
	public static final String ORDER_TYPE_EXPERIENCE 		= "1";	// 体验
	public static final String ORDER_TYPE_APPOINTEXPERIENCE = "2";	// 预约体验
	public static final String ORDER_TYPE_BUY 				= "3";	// 购买
	public static final String ORDER_TYPE_APPOINTBUY 		= "4";	// 预购

	//工单类型（返修/退/换） ser_as_workorder_workorderType
	public static final String WORKORDER_TYPE_REPAIR 		= "1";	// 返修
	public static final String WORKORDER_TYPE_REPLACE		= "2";	// 换
	public static final String WORKORDER_TYPE_BACK 			= "3";	// 退

	//工单状态  	ser_as_qualityWorkorder_status
	public static final String WORKORDER_STATUS_DEAL 		= "1";	// 未处理
	public static final String WORKORDER_STATUS_APPROVE 	= "2";	// 待审核
	public static final String WORKORDER_STATUS_FINISH 		= "3";	// 已完成

	public static final String SER_AS_QUALITY_ORDERNO = "ser_as_qualityWorkorderNo";

	private List<QualityWorkordProduct> qualityWorkordProductList = Lists.newArrayList();
	public QualityWorkorder() {
		super();
	}

	public QualityWorkorder(String id){
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
	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
	
	@Length(min=0, max=1000, message="描述长度必须介于 0 和 1000 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=64, message="被指派人长度必须介于 0 和 64 之间")
	public String getAppointedUser() {
		return appointedUser;
	}

	public void setAppointedUser(String appointedUser) {
		this.appointedUser = appointedUser;
	}

	public List<QualityWorkordProduct> getQualityWorkordProductList() {
		return qualityWorkordProductList;
	}

	public void setQualityWorkordProductList(List<QualityWorkordProduct> qualityWorkordProductList) {
		this.qualityWorkordProductList = qualityWorkordProductList;
	}
}