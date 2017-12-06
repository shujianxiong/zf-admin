/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.wp;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 微信预支付记录Entity
 * @author 张金俊
 * @version 2017-05-26
 */
public class WechatPrepayRecord extends DataEntity<WechatPrepayRecord> {
	
	private static final long serialVersionUID = 1L;
	private String orderType;		// 支付订单类型（体验/预约..）
	private String orderId;			// 支付订单ID
	private String orderNo;			// 支付订单编号
	private String prepayNo;		// 预支付编号
	

	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "bus_wp_prepayNo";	// 获取微信预支付编号 字段
	
	
	public WechatPrepayRecord() {
		super();
	}

	public WechatPrepayRecord(String id){
		super(id);
	}
	

	@Length(min=1, max=2, message="支付订单类型长度必须介于 1 和 2 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=1, max=64, message="支付订单ID长度必须介于 1 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=1, max=64, message="支付订单编号长度必须介于 1 和 64 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=64, message="预支付编号长度必须介于 1 和 64 之间")
	public String getPrepayNo() {
		return prepayNo;
	}

	public void setPrepayNo(String prepayNo) {
		this.prepayNo = prepayNo;
	}
	
}