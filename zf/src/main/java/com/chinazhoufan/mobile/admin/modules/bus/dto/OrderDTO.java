package com.chinazhoufan.mobile.admin.modules.bus.dto;

import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;

/**
 * 
 * 订单DTO
 * 
 */
public class OrderDTO {

	
	private String orderNo;//订单编号
	
	private String orderType;//订单类型
	
	private Date orderDate;//下单日期
	
	private String status;//订单状态
	
	private String remarks;//订单备注
	
	
	private List<ProduceDTO> produceList = Lists.newArrayList();//关联产品
	
	
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public List<ProduceDTO> getProduceList() {
		return produceList;
	}

	public void setProduceList(List<ProduceDTO> produceList) {
		this.produceList = produceList;
	}

	
	
}
