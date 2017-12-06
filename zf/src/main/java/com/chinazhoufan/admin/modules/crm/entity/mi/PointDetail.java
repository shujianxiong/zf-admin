/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mi;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 积分管理Entity
 * @author 刘晓东
 * @version 2015-11-04
 */
public class PointDetail extends DataEntity<PointDetail> {
	
	private static final long serialVersionUID = 1L;
	private Member member;				// 会员
	private String changeType;			// 变动类型（增/减）
	private Integer changePoint;		// 变动积分数量
	private Integer lastPoint;			// 变动后积分
	private String changeReasonType;	// 变动原因
	private Date changeTime;			// 变动时间
	private String operaterType;		// 操作人类型（会员/员工/系统）
	private String operateSourceNo;		// 来源业务编号
	
	
	/******************************************** 自定义常量  *********************************************/
	//变动类型 [add_decrease]
	public static final String CHANGE_TYPE_ADD 		= "A";	// 增加
	public static final String CHANGE_TYPE_DECREASE = "D";	// 减少
	//操作人类型 [operater_type]
	public static final String OPERATER_TYPE_MEMBER = "M";	// 会员
	public static final String OPERATER_TYPE_STAFF 	= "U";	// 员工
	public static final String OPERATER_TYPE_SYS 	= "S";	// 系统
	//变动原因 [crm_mi_point_detail_changeReasonType]
	public static final String CRT_A_REGISTER 		= "A01";	// 会员注册
	public static final String CRT_A_SIGN 			= "A02";	// 会员签到
	public static final String CRT_A_REALNAME 		= "A03";	// 实名认证
	public static final String CRT_A_INVITE 		= "A04";	// 邀请注册
	public static final String CRT_A_ACTIVITY 		= "A05";	// 参与活动
	public static final String CRT_A_ORDER_PAID 	= "A20";	// 订单支付
	public static final String CRT_A_ORDER_RECEIVE 	= "A21";	// 确认收货
	public static final String CRT_A_ORDER_SETTLED 	= "A22";	// 订单结算
	public static final String CRT_A_ORDER_JUDGED 	= "A23";	// 订单评价
	public static final String CRT_D_POINT_MALL 	= "D01";	// 积分商城兑换
	
	//积分系统参数配置
	public static final String POINT_ADD_REGISTER 		= "pointAddRegister"; 		// 赠送积分数量（用户注册成功）
	public static final String POINT_ADD_ORDERPAID 		= "pointAddOrderPaid"; 		// 赠送积分数量（用户订单支付成功）
	public static final String POINT_ADD_ORDERSETTLED	= "pointAddOrderSettled"; 	// 赠送积分数量（用户订单结算成功）
	public static final String POINT_ADD_ORDERJUDGED	= "pointAddOrderJudged"; 	// 赠送积分数量（用户订单评价成功）
	public static final String MEMBER_SIGN_POINT 		= "memberSignPoint"; 		// 赠送积分数量（签到）
	
	
	
	public PointDetail() {
		super();
	}

	public PointDetail(String id){
		super(id);
	}

	public PointDetail(Member member) {
		this.member = member;
	}
	
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Length(min=1, max=2, message="变动类型长度必须介于 1 和 2 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	
	public Integer getChangePoint() {
		return changePoint;
	}

	public void setChangePoint(Integer changePoint) {
		this.changePoint = changePoint;
	}

	public Integer getLastPoint() {
		return lastPoint;
	}

	public void setLastPoint(Integer lastPoint) {
		this.lastPoint = lastPoint;
	}

	@Length(min=1, max=10, message="变动原因长度必须介于 1 和 10 之间")
	public String getChangeReasonType() {
		return changeReasonType;
	}

	public void setChangeReasonType(String changeReasonType) {
		this.changeReasonType = changeReasonType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="变动时间不能为空")
	public Date getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(Date changeTime) {
		this.changeTime = changeTime;
	}
	
	@Length(min=1, max=2, message="操作人类型长度必须介于 1 和 2 之间")
	public String getOperaterType() {
		return operaterType;
	}

	public void setOperaterType(String operaterType) {
		this.operaterType = operaterType;
	}
	
	@Length(min=0, max=64, message="来源业务编号长度必须介于 0 和 64 之间")
	public String getOperateSourceNo() {
		return operateSourceNo;
	}

	public void setOperateSourceNo(String operateSourceNo) {
		this.operateSourceNo = operateSourceNo;
	}
	
}