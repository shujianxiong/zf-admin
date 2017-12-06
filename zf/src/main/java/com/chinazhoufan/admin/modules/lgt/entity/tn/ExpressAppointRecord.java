/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.tn;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 快递预约记录Entity
 * @author liut
 * @version 2017-05-24
 */
public class ExpressAppointRecord extends DataEntity<ExpressAppointRecord> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private String expressOrderId;		// 快递订单号
	private String orderType;		// 来源订单类型  bus_order_type
	private String orderId;		// 来源订单ID
	private String status;		// 预约状态  lgt_tn_express_appoint_record_status
	private Date appointStartTime;		// 预约起始时间
	private Date appointEndTime;		// 预约结束时间
	private Area area;		// 取件地址ID
	private String areaDetail;		// 取件地址
	
	
	//预约状态  lgt_tn_express_appoint_record_status
	public static final String CUSTOMER_STATUS_OK = "1";    //	用户预约成功
	public static final String CUSTOMER_STATUS_NO = "2";    //  用户预约失败
	public static final String SYS_USER_STATUS_OK = "3";    //  员工预约成功
	public static final String CUSTOMER_STATUS_CANCEL = "4";    //  用户取消预约
	public static final String SYSTEM_STATUS_CANCEL = "5";    //  系统取消预约
	
	public static final String EXPRESS_APPOINT_RECORD_EXPRESS_ORDER_ID = "express_appoint_record_express_order_id";
	
	public ExpressAppointRecord() {
		super();
	}

	public ExpressAppointRecord(String id){
		super(id);
	}

	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=2, message="来源订单类型长度必须介于 1 和 2 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=1, max=64, message="来源订单ID长度必须介于 1 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=1, max=2, message="预约状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="预约起始时间不能为空")
	public Date getAppointStartTime() {
		return appointStartTime;
	}

	public void setAppointStartTime(Date appointStartTime) {
		this.appointStartTime = appointStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="预约结束时间不能为空")
	public Date getAppointEndTime() {
		return appointEndTime;
	}

	public void setAppointEndTime(Date appointEndTime) {
		this.appointEndTime = appointEndTime;
	}
	
	@NotNull(message="取件地址ID不能为空")
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=1, max=500, message="取件地址长度必须介于 1 和 500 之间")
	public String getAreaDetail() {
		return areaDetail;
	}

	public void setAreaDetail(String areaDetail) {
		this.areaDetail = areaDetail;
	}

	public String getExpressOrderId() {
		return expressOrderId;
	}

	public void setExpressOrderId(String expressOrderId) {
		this.expressOrderId = expressOrderId;
	}
}