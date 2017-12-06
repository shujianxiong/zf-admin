/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.bb;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 微信充值单Entity
 * @author 张金俊
 * @version 2016-12-19
 */
public class RechargeOrder extends DataEntity<RechargeOrder> {
	
	private static final long serialVersionUID = 1L;
	private String no;				// 充值单编号
	private Member member;			// 充值会员
	private BigDecimal money;		// 金额
	private String status;			// 状态（待充值/已充值）[crm_bb_recharge_order_status]
	private Date rechargeTime;		// 充值时间
	private String serialNo;		// 充值流水号
	private Date receiveTime;		// 到账时间
	
	// “微信充值单编号”编码生成器代码
	public static final String GENERATECODE_ORDERNO	= "crm_bb_recharge_order_no";
	// 微信充值单状态
	public static final String STATUS_WAIT 		= "1";	// 待充值
	public static final String STATUS_FINISH 	= "2";	// 已充值
	
	
	public RechargeOrder() {
		super();
	}

	public RechargeOrder(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="充值单编号长度必须介于 1 和 64 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@Length(min=1, max=64, message="充值会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@NotNull(message="金额不能为空")
	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	
	@Length(min=1, max=2, message="状态（待充值/已充值）长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="充值时间不能为空")
	public Date getRechargeTime() {
		return rechargeTime;
	}

	public void setRechargeTime(Date rechargeTime) {
		this.rechargeTime = rechargeTime;
	}
	
	@Length(min=0, max=100, message="充值流水号长度必须介于 0 和 100 之间")
	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	
}