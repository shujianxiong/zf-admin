/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.op;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 付款单Entity
 * @author 张金俊
 * @version 2017-08-21
 */
public class PayOrder extends DataEntity<PayOrder> {
	
	private static final long serialVersionUID = 1L;
	private String no;							// 付款单编号
	private String orderType;					// 来源订单类型（体验/预约..）
	private String orderId;						// 来源订单ID
	private String orderNo;						// 来源订单编号
	private String moneyType;					// 支付金额类型
	private BigDecimal money;					// 支付金额
	private String status;						// 支付状态
	private Date payTime;						// 支付时间
	private Date returnTime;					// 支付返回时间
	private String returnResult;				// 支付返回结果
	private String openid;						// 支付人openid
	private String refundFlag;					// 可退款标记（0：否 1：是）
	private BigDecimal refundAutoMoney;			// 自动退款金额
	private Date refundAutoTime;				// 自动退款时间
	private String refundArtificialStatus;		// 人工退款状态
	private BigDecimal refundArtificialMoney;	// 人工退款金额
	private Date refundArtificialTime;			// 人工退款时间
	private String refundArtificialRemarks;		// 人工退款备注

	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "bus_op_pay_order_no";	// 获取付款单编号 字段
	
	// 支付金额类型 bus_op_pay_order_moneyType
	public static final String MONEYTYPE_TOTAL		= "1";	// 全款
	public static final String MONEYTYPE_APPOINT	= "2";	// 定金
	public static final String MONEYTYPE_FINAL		= "3";	// 尾款
	// 支付状态 bus_op_pay_order_status
	// 自动退款状态 bus_op_pay_order_refundAutoStatus
	// 人工退款状态 bus_op_pay_order_refundArtificialStatus
	
	
	
	public PayOrder() {
		super();
	}

	public PayOrder(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="付款单编号长度必须介于 1 和 64 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
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
	
	@Length(min=1, max=64, message="来源订单编号长度必须介于 1 和 64 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=2, message="支付金额类型长度必须介于 1 和 2 之间")
	public String getMoneyType() {
		return moneyType;
	}

	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}
	
	@NotNull(message="支付金额不能为空")
	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	
	@Length(min=1, max=2, message="支付状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}
	
	@Length(min=0, max=100, message="支付返回结果长度必须介于 0 和 100 之间")
	public String getReturnResult() {
		return returnResult;
	}

	public void setReturnResult(String returnResult) {
		this.returnResult = returnResult;
	}
	
	@Length(min=0, max=100, message="支付人openid长度必须介于 0 和 100 之间")
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	@Length(min=1, max=1, message="可退款标记长度必须介于 1 和 1 之间")
	public String getRefundFlag() {
		return refundFlag;
	}

	public void setRefundFlag(String refundFlag) {
		this.refundFlag = refundFlag;
	}
	
	public BigDecimal getRefundAutoMoney() {
		return refundAutoMoney;
	}

	public void setRefundAutoMoney(BigDecimal refundAutoMoney) {
		this.refundAutoMoney = refundAutoMoney;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRefundAutoTime() {
		return refundAutoTime;
	}

	public void setRefundAutoTime(Date refundAutoTime) {
		this.refundAutoTime = refundAutoTime;
	}
	
	@Length(min=0, max=2, message="人工退款状态长度必须介于 0 和 2 之间")
	public String getRefundArtificialStatus() {
		return refundArtificialStatus;
	}

	public void setRefundArtificialStatus(String refundArtificialStatus) {
		this.refundArtificialStatus = refundArtificialStatus;
	}
	
	public BigDecimal getRefundArtificialMoney() {
		return refundArtificialMoney;
	}

	public void setRefundArtificialMoney(BigDecimal refundArtificialMoney) {
		this.refundArtificialMoney = refundArtificialMoney;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRefundArtificialTime() {
		return refundArtificialTime;
	}

	public void setRefundArtificialTime(Date refundArtificialTime) {
		this.refundArtificialTime = refundArtificialTime;
	}
	
	@Length(min=0, max=255, message="人工退款备注长度必须介于 0 和 255 之间")
	public String getRefundArtificialRemarks() {
		return refundArtificialRemarks;
	}

	public void setRefundArtificialRemarks(String refundArtificialRemarks) {
		this.refundArtificialRemarks = refundArtificialRemarks;
	}
	
}