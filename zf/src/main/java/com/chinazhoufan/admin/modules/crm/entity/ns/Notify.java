/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.ns;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.vo.NotifyMemberVO;

/**
 * 消息Entity
 * @author 张金俊
 * @version 2017-07-18
 */
public class Notify extends DataEntity<Notify> {
	
	private static final long serialVersionUID = 1L;
	private String type;				// 类型（1：公告Announce、2：提醒Remind、3：信息Message）
	private String remindTargetType;	// 目标类型
	private String remindTargetAction;	// 目标动作类型
	private String messageCode;			// 信息编码
	private String status;				// 状态
	private String title;				// 标题
	private String content;				// 内容
	private String smsFlag;				// 短信标记

	/******************************************** 自定义常量  *********************************************/
	// 消息类型 crm_ns_notify_type
	public static final String TYPE_ANNOUNCE		= "1";	// 公告
	public static final String TYPE_REMIND			= "2";	// 提醒
	public static final String TYPE_MESSAGE			= "3";	// 信息
	public static final String TYPE_CUSTOM		= "4";	// 信息
	// 消息状态 crm_ns_notify_status
	public static final String STATUS_NEW			= "1";	// 新建
	public static final String STATUS_UNPUBLISH		= "2";	// 未发布
	public static final String STATUS_PUBLISHED		= "3";	// 已发布
	
	// 订阅目标类型 crm_ns_notify_remindTargetType
	public static final String RTT_PRODUCE						= "produce";						// 产品
	// 订阅目标动作类型 crm_ns_notify_remindTargetAction
	public static final String RTA_PRODUCE_PURCHASEFINISH		= "produce_purchaseFinish";			// 产品采购完成
	
	// 信息类消息编码
	public static final String MSG_ORDER_SENDED					= "00001";				// 00001、订单发货提醒
	public static final String MSG_ORDER_RECEIVE_CONFIRM		= "00002";				// 00002、收货确认体验规则提醒
	public static final String MSG_ORDER_NOTIFY_REMAIN_1			= "00003";				// 00003、客户归还消息提醒
	public static final String MSG_ORDER_SETTLE_AUTO			= "00004";				// 00004、体验订单结算通知
	public static final String MSG_ORDER_BUY_ALL			= "00005";				// 00005、购买结算通知


	public static final String MSG_ORDER_CANCEL_MEMBER			= "00006";				// 00006、客户申请取消订单结算通知（通用）
	public static final String MSG_ORDER_CANCEL_USER			= "00007";				// 00007、我方缺货取消订单结算通知（通用）
	public static final String MSG_ORDER_NOTIFY_PAST_1			= "00008";				// 00008、产生超期费通知（通用）

	public static final String MSG_ORDER_CANCEL_RELIEF			= "00009";				// 00009、免责定单取消通知（通用）
	public static final String MSG_ORDER_CANCEL_CLAIM			= "00011";				// 00011、客户责任退件订单取消后结算通知（通用）

	public static final String MSG_ORDER_OVERDUE_DEBT			= "00012";				// 00012、超期收费已结算通知（自付）

	public static final String MSG_ORDER_EXPIRED_BUY_AUTO		= "00013";		// 00013、自动转购买结算通知（自付）
	
	public static final String MSG_ORDER_SLIGHT_DAMAGE		= "00014";		// 00014、含商品轻微损坏赔偿结算通知（自付）


	public static final String MSG_ORDER_DUE			= "00015";			// 00015、轻度以上赔偿订单结算通知（自付）
	public static final String MSG_ORDER_DUE_FOR_NEW			= "00016";			// 00016、含轻度以上损坏转购买结算通知（自付）
	
	public static final String MSG_BEANS_DEC_EXCHANGE			= "00017";			// 00017、赔偿金退还结算通知（自付）



	public static final String MSG_DEBT_WARNING_ONE_DAY			= "00018";			// 00018、超期费用欠款缴费通知
	public static final String MSG_ORDER_AUTOBUY_DEBT		= "00019";			// 00019、自动转购买欠款催款通知


	public static final String MSG_DEBT_BACK			= "00020";			// "00020、商品轻微以上损坏补缴通知（含换新）"
	public static final String MSG_DEBT_BACK_FOR_NEW			= "00021";			// "00021、商品轻微以上损坏补缴通知（含换新）"
	
	public static final String MSG_DEBT_WARNING_ONE_WEEK			= "00022";			// 00022风险客户欠费警告通知
	public static final String MSG_EXPERIENCE_UP			= "00024";			// 00024、赠送体验包通知
	public static final String MSG_EXPERIENCE_REMIND			= "00025";			// 00025、体验提醒通知
	public static final String MSG_USAGE_GUIDANCE		= "00026";			// 00026、使用方法指导通知
	public static final String MSG_APPOINTORDER_GET_STOCK		= "00027";		// 00027、预约体验商品尾款支付通知
	public static final String MSG_APPOINTORDER_CLOSE_AUTO		= "00028";		// 00028、超期未支付取消订单通知


	public static final String MSG_LOST_PART		= "00032";		// 00032、部分丢失转购买结算通知
	public static final String MSG_LOST_PART_DEBT		= "00034";		// 00034、部分丢失转购买欠费通知（免全额押金）



	
//	public static final String MSG_EXPERIENCE_UP		= "ntf_experienceUp";					// 消息：体验包升级
	
	
	public static final String MSG_GOODS_SLIGHT_DAMAGE		= "ntf_goodsSlightDamage";		// 消息：商品轻微损坏赔偿结算通知（自付全额押金 和40%-50%押金）

//	public static final String MSG_ORDER_OVERDUE_DEBT		= "ntf_orderOverdueDebt";		// 消息：超期收费结算通知
	public static final String MSG_ORDER_OVERDUE_DEBT_ZMXY		= "ntf_orderOverdueDebt_Zmxy";		// 消息：超期收费欠费通知（免全额押金）
	
//	public static final String MSG_APPOINTORDER_CLOSE_AUTO		= "ntf_appointOrderCloseAuto";		// 消息：预约订单自动关闭
//	public static final String MSG_APPOINTORDER_GET_STOCK		= "ntf_appointOrderGetStock";		// 消息：预约订单已到货
//	public static final String MSG_ORDER_BUY_ALL				= "ntf_orderBuyAll";				// 消息：全部商品转购买
	public static final String MSG_ORDER_BUY_PART				= "ntf_orderBuyPart";				// 消息：部分商品转购买
//	public static final String MSG_ORDER_CANCEL_MEMBER			= "ntf_orderCancelFromMember";		// 消息：客户申请取消订单审核通过
//	public static final String MSG_ORDER_CANCEL_USER			= "ntf_orderCancelFromUser";		// 消息：员工申请取消订单审核通过
//	public static final String MSG_ORDER_EXPIRED_BUY_AUTO		= "ntf_orderExpiredBuyAuto";		// 消息：订单自动转购买
//	public static final String MSG_ORDER_DEBT_BUY_AUTO			= "ntf_orderDebtBuyAuto";		// 消息：订单自动转购买欠款
//	public static final String MSG_ORDER_NOTIFY_PAST_1			= "ntf_orderNotifyPastOneDay";		// 消息：客户归还消息提醒（体验期超期一天的体验订单）
//	public static final String MSG_ORDER_NOTIFY_REMAIN_1		= "ntf_orderNotifyRemindOneDay";	// 消息：客户归还消息提醒（体验期结束剩一天的体验订单）
//	public static final String MSG_ORDER_SETTLE_AUTO			= "ntf_orderSettleAuto";			// 消息：系统自动结算通知
	public static final String MSG_SERVICEAPPLY_REFUSE_MEMBER	= "ntf_serviceApplyRefuseFromMember";// 消息：客户服务申请审核拒绝
	public static final String MSG_EXPERIENCE_OVERDUE		= "ntf_experienceOverdue";			// 消息：体验包过期
	public static final String MSG_EXPERIENCE_REGIST		= "ntf_experienceRegist";					// 消息：体验包注册
	/******************************************** 自定义常量end  *********************************************/
	
	private String[] memberIds;
	private NotifyMemberVO notifyMemberVO;
	
	public Notify() {
		super();
	}

	public Notify(String id){
		super(id);
	}

	
	@Length(min=1, max=2, message="类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getRemindTargetType() {
		return remindTargetType;
	}

	public void setRemindTargetType(String remindTargetType) {
		this.remindTargetType = remindTargetType;
	}

	public String getRemindTargetAction() {
		return remindTargetAction;
	}

	public void setRemindTargetAction(String remindTargetAction) {
		this.remindTargetAction = remindTargetAction;
	}

	@Length(min=0, max=100, message="信息编码长度必须介于 0 和 100 之间")
	public String getMessageCode() {
		return messageCode;
	}

	public void setMessageCode(String messageCode) {
		this.messageCode = messageCode;
	}
	
	@Length(min=1, max=200, message="标题长度必须介于 1 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min=1, max=1, message="短信标记长度必须介于 1 和 1 之间")
	public String getSmsFlag() {
		return smsFlag;
	}

	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}

	public String[] getMemberIds() {
		return memberIds;
	}

	public void setMemberIds(String[] memberIds) {
		this.memberIds = memberIds;
	}

	public NotifyMemberVO getNotifyMemberVO() {
		return notifyMemberVO;
	}

	public void setNotifyMemberVO(NotifyMemberVO notifyMemberVO) {
		this.notifyMemberVO = notifyMemberVO;
	}
	
}