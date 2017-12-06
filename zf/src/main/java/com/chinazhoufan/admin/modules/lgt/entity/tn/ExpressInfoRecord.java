/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.tn;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 快递信息记录Entity
 * @author liuxiaodong
 * @version 2017-11-04
 */
public class ExpressInfoRecord extends DataEntity<ExpressInfoRecord> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private String expressOrderId;		// 快递订单号
	private String orderType;		// 来源订单类型
	private String orderId;		// 来源订单ID
	private String sendOrderType;		// 送货单类型(1、体验发货单 2、换新发货单 3、维修发货单 4、体验退货5、维修退货单)
	private String status;		// 快递状态
	private String statusDescription;		// 状态描述
	private Date time;		// 时间
	
	public static final String SENDTYPE_EXPERIENCE		= "1";	// 体验单发货
	public static final String ORDERTYPE_CHANGE			= "2";	// 换新发货
	public static final String ORDERTYPE_REPAIR 	= "3";	//维修发货
	public static final String ORDER_EXPERIENCE		= "4";	// 体验退货
	
	public ExpressInfoRecord() {
		super();
	}

	public ExpressInfoRecord(String id){
		super(id);
	}

	public ExpressInfoRecord(String expressOrderId,String status, String  statusDescription, Date time ) {
		super();
		this.expressOrderId = expressOrderId;
		this.status = status;
		this.statusDescription = statusDescription;
		this.time = time;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Length(min=0, max=64, message="快递订单号长度必须介于 0 和 64 之间")
	public String getExpressOrderId() {
		return expressOrderId;
	}

	public void setExpressOrderId(String expressOrderId) {
		this.expressOrderId = expressOrderId;
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
	
	@Length(min=1, max=2, message="送货单类型(1、体验发货单 2、换新发货单 3、维修发货单 4、体验退货5、维修退货单)长度必须介于 1 和 2 之间")
	public String getSendOrderType() {
		return sendOrderType;
	}

	public void setSendOrderType(String sendOrderType) {
		this.sendOrderType = sendOrderType;
	}
	
	@Length(min=1, max=32, message="快递状态长度必须介于 1 和 32 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=255, message="状态描述长度必须介于 1 和 255 之间")
	public String getStatusDescription() {
		return statusDescription;
	}

	public void setStatusDescription(String statusDescription) {
		this.statusDescription = statusDescription;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="时间不能为空")
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "ExpressInfoRecord{" +
				"member=" + member +
				", expressOrderId='" + expressOrderId + '\'' +
				", orderType='" + orderType + '\'' +
				", orderId='" + orderId + '\'' +
				", sendOrderType='" + sendOrderType + '\'' +
				", status='" + status + '\'' +
				", statusDescription='" + statusDescription + '\'' +
				", time=" + time +
				'}';
	}
}