/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pm;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 积分商品兑换记录Entity
 * @author 张金俊
 * @version 2016-12-02
 */
public class PointExchange extends DataEntity<PointExchange> {
	
	private static final long serialVersionUID = 1L;
	private String serialNo;		// 兑换流水号
	private Member member;			// 会员
	private PointGoods pointGoods;	// 积分商品
	private String status;			// 兑换状态  spm_pm_point_exchange_status
	private Integer point;			// 消耗积分
	
	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "spm_pm_point_exchange_serialNo";	// 获取积分商品兑换流水号 字段
	
	// 兑换状态 [spm_pm_point_exchange_status]
	public static final String STATUS_EXCHANGED = "1";	// 已兑换（已申请兑换，已扣积分，积分商品尚未领取）
	public static final String STATUS_RECEIVED 	= "2";	// 已领取
	
	
	
	public PointExchange() {
		super();
	}

	public PointExchange(String id){
		super(id);
	}

	
	/**method*/
	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=64, message="积分商品ID长度必须介于 1 和 64 之间")
	public PointGoods getPointGoods() {
		return pointGoods;
	}

	public void setPointGoods(PointGoods pointGoods) {
		this.pointGoods = pointGoods;
	}
	
	@Length(min=1, max=2, message="兑换状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@NotNull(message="消耗积分不能为空")
	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}
	
}