package com.chinazhoufan.mobile.index.modules.usercenter.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class VouchersItemVO implements java.io.Serializable {
	
	private String id;	//优惠卷id
	private String flag; // 领取状态
	private String useFlag; // 使用状态
	private String name; // 优惠卷名称
	private String amount; // 代金卷金额
	private String minOrderAmount; // 满多少可用
	private String useablePlatformType; // 可用范围（0所有,1线上,2线下）
	private String useableOrderType; // 可用订单类型（0所有,1购买,2租赁 3 团购）
	private Date startTime; // 开始时间
	private Date endTime; // 结束时间
	
	
	
	public VouchersItemVO() {}
	
	public VouchersItemVO(String id, String flag, String useFlag, String name,
			String amount, String minOrderAmount, String useablePlatformType,
			String useableOrderType, Date startTime, Date endTime) {
		this.id = id;
		this.flag = flag;
		this.useFlag = useFlag;
		this.name = name;
		this.amount = amount;
		this.minOrderAmount = minOrderAmount;
		this.useablePlatformType = useablePlatformType;
		this.useableOrderType = useableOrderType;
		this.startTime = startTime;
		this.endTime = endTime;
	}
	
	/**
	 * 适用范围
	 * 根据需求修改
	 */
	public String getScope() {
		String useablePlatformTypeString = "所有";
		if("1".equals(useablePlatformType)){
			useablePlatformTypeString = "线上";
		}else if("1".equals(useablePlatformType)){
			useablePlatformTypeString = "线下";
		}
	
		String useableOrderTypeString = "所有";
		if("1".equals(useableOrderType)){
			useableOrderTypeString = "购买";
		}else if("2".equals(useableOrderType)){
			useableOrderTypeString = "租赁";
		}else if("3".equals(useableOrderType)){
			useableOrderTypeString = "团购";
		}
		
		return useablePlatformTypeString + useableOrderTypeString;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getMinOrderAmount() {
		return minOrderAmount;
	}
	public void setMinOrderAmount(String minOrderAmount) {
		this.minOrderAmount = minOrderAmount;
	}
	public String getUseablePlatformType() {
		return useablePlatformType;
	}
	public void setUseablePlatformType(String useablePlatformType) {
		this.useablePlatformType = useablePlatformType;
	}
	public String getUseableOrderType() {
		return useableOrderType;
	}
	public void setUseableOrderType(String useableOrderType) {
		this.useableOrderType = useableOrderType;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	
}
