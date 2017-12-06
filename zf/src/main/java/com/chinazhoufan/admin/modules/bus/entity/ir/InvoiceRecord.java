/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ir;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;

/**
 * 发票开票记录Entity
 * @author 张金俊
 * @version 2017-08-07
 */
public class InvoiceRecord extends DataEntity<InvoiceRecord> {
	
	private static final long serialVersionUID = 1L;
	private BuyOrder buyOrder;			// 购买订单
	private Double money;				// 开票金额
	private String status;				// 状态
	private String type;				// 发票类型
	private String titleType;			// 发票抬头类型
	private String title;				// 发票抬头
	private String taxNo;				// 发票税号
	private String contentType;			// 发票内容
	private String receiveName;			// 收货人
	private String receiveTel;			// 收货电话
	private String receiveAreaStr;		// 收货地址省市区
	private String receiveAreaDetail;	// 收货地址详情
	
	/******************************************** 自定义常量  *********************************************/
	
	// 发票开票记录状态 bus_ir_invoice_record_status
	public static final String STATUS_NEW			= "1";	// 新建
	public static final String STATUS_OUTED			= "2";	// 已开票
	// 发票开票记录发票类型 bus_ir_invoice_record_type
	public static final String TYPE_NORMAL			= "1";	// 普通发票
	public static final String TYPE_VALUE_ADDED		= "2";	// 增值税发票
	// 发票开票记录发票抬头类型 bus_ir_invoice_record_titleType
	public static final String TITLETYPE_PERSON		= "1";	// 个人
	public static final String TITLETYPE_COMPANY	= "2";	// 公司
	// 发票开票记录发票内容类型 bus_ir_invoice_record_contentType
	public static final String CONTENTTYPE_DETAIL	= "1";	// 明细
	
	
	
	public InvoiceRecord() {
		super();
	}

	public InvoiceRecord(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="购买订单ID长度必须介于 1 和 64 之间")
	public BuyOrder getBuyOrder() {
		return buyOrder;
	}

	public void setBuyOrder(BuyOrder buyOrder) {
		this.buyOrder = buyOrder;
	}
	
	@NotNull(message="开票金额不能为空")
	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}
	
	@Length(min=1, max=2, message="状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=2, message="发票类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getTitleType() {
		return titleType;
	}

	public void setTitleType(String titleType) {
		this.titleType = titleType;
	}

	@Length(min=1, max=100, message="发票抬头长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=50, message="发票税号长度必须介于 0 和 50 之间")
	public String getTaxNo() {
		return taxNo;
	}

	public void setTaxNo(String taxNo) {
		this.taxNo = taxNo;
	}
	
	@Length(min=1, max=2, message="发票内容长度必须介于 1 和 2 之间")
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	@Length(min=1, max=50, message="收货人长度必须介于 1 和 50 之间")
	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}
	
	@Length(min=1, max=50, message="收货电话长度必须介于 1 和 50 之间")
	public String getReceiveTel() {
		return receiveTel;
	}

	public void setReceiveTel(String receiveTel) {
		this.receiveTel = receiveTel;
	}
	
	@Length(min=1, max=100, message="收货地址省市区长度必须介于 1 和 100 之间")
	public String getReceiveAreaStr() {
		return receiveAreaStr;
	}

	public void setReceiveAreaStr(String receiveAreaStr) {
		this.receiveAreaStr = receiveAreaStr;
	}
	
	@Length(min=1, max=100, message="收货地址详情长度必须介于 1 和 100 之间")
	public String getReceiveAreaDetail() {
		return receiveAreaDetail;
	}

	public void setReceiveAreaDetail(String receiveAreaDetail) {
		this.receiveAreaDetail = receiveAreaDetail;
	}
	
}