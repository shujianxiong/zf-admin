package com.chinazhoufan.admin.modules.bus.bean;

import java.io.Serializable;
import java.util.Date;

import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

public class Order implements Serializable{

	/**
	 * 订单ID
	 */
	public String id;
	
	/**
	 * 订单类型
	 */
	public String orderType;
	
	/**
	 * 订单号
	 */
	public String orderNo;
	
	/**
	 * 回单号
	 */
	public String expressNo;
	
	/**
	 * 物流公司
	 */
	public String expressCompany;
	
	/**
	 * 超期天数
	 */
	public String outOfDays;
	
	/**
	 * 回货收货人
	 */
	public User receiveBy;
	
	/**
	 * 回货收货时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date receiveTime;
	
	/**
	 * 订单状态
	 */
	public String orderStatus;
	
	
	
	
}
