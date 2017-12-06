package com.chinazhoufan.admin.modules.crm.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 自定义消息会员选择VO
 * @author liuxiaodong
 *
 */
public class NotifyMemberVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String type;
	private Integer experienceCountStart;
	private Integer experienceCountEnd;
	private Integer buyCountStart;
	private Integer buyCountEnd;
	private BigDecimal tradeMoneyStart;
	private BigDecimal tradeMoneyEnd;
	private Date startDate;
	private Date endDate;
	
	public static final String TYPE_REGISTER = "1"; //注册未交易
	public static final String TYPE_EXPERIENCE = "2"; //体验未购买
	public static final String TYPE_BUY = "3"; //购买
	
	
	
	public NotifyMemberVO() {
		super();
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Integer getExperienceCountStart() {
		return experienceCountStart;
	}
	public void setExperienceCountStart(Integer experienceCountStart) {
		this.experienceCountStart = experienceCountStart;
	}
	public Integer getExperienceCountEnd() {
		return experienceCountEnd;
	}
	public void setExperienceCountEnd(Integer experienceCountEnd) {
		this.experienceCountEnd = experienceCountEnd;
	}
	public Integer getBuyCountStart() {
		return buyCountStart;
	}
	public void setBuyCountStart(Integer buyCountStart) {
		this.buyCountStart = buyCountStart;
	}
	public Integer getBuyCountEnd() {
		return buyCountEnd;
	}
	public void setBuyCountEnd(Integer buyCountEnd) {
		this.buyCountEnd = buyCountEnd;
	}
	public BigDecimal getTradeMoneyStart() {
		return tradeMoneyStart;
	}
	public void setTradeMoneyStart(BigDecimal tradeMoneyStart) {
		this.tradeMoneyStart = tradeMoneyStart;
	}
	public BigDecimal getTradeMoneyEnd() {
		return tradeMoneyEnd;
	}
	public void setTradeMoneyEnd(BigDecimal tradeMoneyEnd) {
		this.tradeMoneyEnd = tradeMoneyEnd;
	}
	
}
