package com.chinazhoufan.admin.modules.bus.vo;

import com.chinazhoufan.api.common.pay.Config;

/**
 * 退款信息封装
 * @author liuxiaodong
 * @date 2017-08-18
 */
public class RefundInfo {
	
	private String platformId; //民生平台ID
	private String merchantNo; //民生商户号
	private String merchantSeq; //订单流水号
	private int orderAmount; //订单金额 单位 ： 分
	private String orderNote; //退款备注
	
	
	public RefundInfo() {
		super();
		this.setPlatformId(Config.getProperty("platformId"));
		this.setMerchantNo(Config.getProperty("merchantNo"));
		this.setOrderNote("周范退款");
	}
	
	public String getPlatformId() {
		return platformId;
	}
	public void setPlatformId(String platformId) {
		this.platformId = platformId;
	}
	public String getMerchantNo() {
		return merchantNo;
	}
	public void setMerchantNo(String merchantNo) {
		this.merchantNo = merchantNo;
	}
	public String getMerchantSeq() {
		return merchantSeq;
	}
	public void setMerchantSeq(String merchantSeq) {
		this.merchantSeq = merchantSeq;
	}
	public int getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getOrderNote() {
		return orderNote;
	}
	public void setOrderNote(String orderNote) {
		this.orderNote = orderNote;
	}
	
	
}
