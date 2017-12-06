/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ci;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 优惠券模板Entity
 * @author 张金俊
 * @version 2016-12-02
 */
public class CouponTemplate extends DataEntity<CouponTemplate> {
	
	private static final long serialVersionUID = 1L;
	private String name;				// 模板名称
	private String couponName;			// 优惠券名称
	private Date startTime;				// 可用起始时间
	private Date endTime;				// 可用截止时间
	private String couponType;			// 优惠类型
	private BigDecimal reachMoney;		// 达标金额
	private BigDecimal decreaseMoney;	// 扣减金额
	private BigDecimal discountScale;	// 打折比例
	private BigDecimal discountMoneyMax;// 打折金额上限
	private String introduction;		// 优惠券介绍
	private Integer numCreated;			// 已生成数量
	private Integer numProvided;		// 已领取数量
	
	// 优惠券优惠类型 [spm_ci_coupon_type]
	
	public static final String COUPONTYPE_MJ = "1";//满减
	public static final String COUPONTYPE_KJ = "2";//扣减
	public static final String COUPONTYPE_ZK = "3";//折扣
	public static final String COUPONTYPE_FREE = "4";//租赁费全免
	
	//存储查询当前时间临时字段
	private Date currentDate;
	
	
	
	public Date getCurrentDate() {
		return currentDate;
	}

	public void setCurrentDate(Date currentDate) {
		this.currentDate = currentDate;
	}

	public CouponTemplate() {
		super();
	}

	public CouponTemplate(String id){
		super(id);
	}

	
	@Length(min=1, max=50, message="模板名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=50, message="优惠券名称长度必须介于 1 和 50 之间")
	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="可用起始时间不能为空")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="可用截止时间不能为空")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=1, max=2, message="优惠类型长度必须介于 1 和 2 之间")
	public String getCouponType() {
		return couponType;
	}

	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}
	
	public BigDecimal getReachMoney() {
		return reachMoney;
	}

	public void setReachMoney(BigDecimal reachMoney) {
		this.reachMoney = reachMoney;
	}

	public BigDecimal getDecreaseMoney() {
		return decreaseMoney;
	}

	public void setDecreaseMoney(BigDecimal decreaseMoney) {
		this.decreaseMoney = decreaseMoney;
	}
	
	public BigDecimal getDiscountScale() {
		return discountScale;
	}

	public void setDiscountScale(BigDecimal discountScale) {
		this.discountScale = discountScale;
	}
	
	public BigDecimal getDiscountMoneyMax() {
		return discountMoneyMax;
	}

	public void setDiscountMoneyMax(BigDecimal discountMoneyMax) {
		this.discountMoneyMax = discountMoneyMax;
	}
	
	@Length(min=1, max=2000, message="优惠券介绍长度必须介于 1 和 2000 之间")
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	public Integer getNumCreated() {
		return numCreated;
	}

	public void setNumCreated(Integer numCreated) {
		this.numCreated = numCreated;
	}
	
	public Integer getNumProvided() {
		return numProvided;
	}

	public void setNumProvided(Integer numProvided) {
		this.numProvided = numProvided;
	}
	
}