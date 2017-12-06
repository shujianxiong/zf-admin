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
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 优惠券Entity
 * @author 张金俊
 * @version 2016-12-02
 */
public class Coupon extends DataEntity<Coupon> {
	
	private static final long serialVersionUID = 1L;
	private CouponTemplate couponTemplate;		// 优惠券模板
	private String name;					// 名称
	private String code;					// 编码
	private String status;					// 状态（1：未领取    2：已领取    3：已使用）
	private Date startTime;					// 可用起始时间
	private Date endTime;					// 可用截止时间
	private String type;					// 优惠类型
	private BigDecimal reachMoney;			// 达标金额
	private BigDecimal decreaseMoney;		// 扣减金额
	private BigDecimal discountScale;		// 打折比例
	private BigDecimal discountMoneyMax;	// 打折金额上限
	private Member member;					// 所属会员
	private String receiveType;				// 领取方式（1：积分兑换    2：发放）
	private Date receiveTime;				// 领取时间
	private String useBuyOrder;				// 使用订单
	private BigDecimal useDecMoney;			// 使用扣减金额
	private Date useTime;					// 使用时间
	
	// 优惠券状态 [spm_ci_coupon_status]
	public static final String STATUS_UNRECEIVED	= "1";	// 未领取
	public static final String STATUS_RECEIVED		= "2";	// 已领取
	public static final String STATUS_USED			= "3";	// 已使用
	
	// 优惠券优惠类型 [spm_ci_coupon_type]
	
	// 优惠券领取方式 [spm_ci_coupon_receiveType]
	public static final String RECEIVETYPE_EXCHANGE = "1"; 	// 积分兑换
	public static final String RECEIVETYPE_GIVE 	= "2";	// 发放
	
	
	public Coupon() {
		super();
	}

	public Coupon(String id){
		super(id);
	}

	public Coupon(CouponTemplate couponTemplate) {
		this.couponTemplate = couponTemplate;
	};
	
	@Length(min=1, max=64, message="模板ID长度必须介于 1 和 64 之间")
	public CouponTemplate getCouponTemplate() {
		return couponTemplate;
	}

	public void setCouponTemplate(CouponTemplate couponTemplate) {
		this.couponTemplate = couponTemplate;
	}
	
	@Length(min=1, max=50, message="优惠券名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Length(min=1, max=2, message="优惠券状态（0未发1已发2已用）长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
	
	@Length(min=0, max=64, message="所属会员ID长度必须介于 0 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=0, max=2, message="领取方式（兑换/发放）长度必须介于 0 和 2 之间")
	public String getReceiveType() {
		return receiveType;
	}

	public void setReceiveType(String receiveType) {
		this.receiveType = receiveType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	
	@Length(min=0, max=64, message="使用订单ID长度必须介于 0 和 64 之间")
	public String getUseBuyOrder() {
		return useBuyOrder;
	}

	public void setUseBuyOrder(String useBuyOrder) {
		this.useBuyOrder = useBuyOrder;
	}
	
	public BigDecimal getUseDecMoney() {
		return useDecMoney;
	}

	public void setUseDecMoney(BigDecimal useDecMoney) {
		this.useDecMoney = useDecMoney;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUseTime() {
		return useTime;
	}

	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}
	
}