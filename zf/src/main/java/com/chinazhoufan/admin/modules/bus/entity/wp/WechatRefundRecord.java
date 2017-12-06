/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.wp;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 微信退款记录Entity
 * @author 舒剑雄
 * @version 2017-09-06
 */
public class WechatRefundRecord extends DataEntity<WechatRefundRecord> {
	
	private static final long serialVersionUID = 1L;
	private String refundNo;		// 退款编号
	private String refundAutoStatus;		// 自动退款状态
	private BigDecimal refundAutoMoney;		// 自动退款金额
	private Date refundAutoTime;		// 自动退款时间
	private String refundArtificialStatus;		// 人工退款状态
	private BigDecimal refundArtificialMoney;		// 人工退款金额
	private Date refundArtificialTime;		// 人工退款时间
	private String wxPayId;		// 支付订单ID
	
	public WechatRefundRecord() {
		super();
	}

	public WechatRefundRecord(String id){
		super(id);
	}

	@Length(min=0, max=64, message="退款编号长度必须介于 0 和 64 之间")
	public String getRefundNo() {
		return refundNo;
	}

	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
	}
	
	@Length(min=0, max=2, message="自动退款状态长度必须介于 0 和 2 之间")
	public String getRefundAutoStatus() {
		return refundAutoStatus;
	}

	public void setRefundAutoStatus(String refundAutoStatus) {
		this.refundAutoStatus = refundAutoStatus;
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
	
	@Length(min=0, max=64, message="支付订单ID长度必须介于 0 和 64 之间")
	public String getWxPayId() {
		return wxPayId;
	}

	public void setWxPayId(String wxPayId) {
		this.wxPayId = wxPayId;
	}
	
}