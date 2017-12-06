/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ob;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 购买单Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class BuyOrder extends DataEntity<BuyOrder> {
	
	private static final long serialVersionUID = 1L;
	private String orderNo;					// 订单编号
	private Member member;					// 会员
	private String type;					// 订单类型（购买/预购）
	private String buyType;					// 购买时机（体验中/后）
	private ExperienceOrder experienceOrder;// 来源体验单
	private String statusMember;			// 会员订单状态
	private String statusSystem;			// 系统订单状态
	private String statusPay;				// 支付状态
	private String statusInvoice;				// 发票状态
	private String statusJudge;				// 评价状态
	private String closeType;				// 订单关闭类型
	private Date closeTime;					// 订单关闭时间
	private String appointStockStatus;		// 预购到货状态
	private BigDecimal moneyProduce;		// 产品总额
	private BigDecimal moneyLgt;			// 物流费
	private BigDecimal moneyAppoint;		// 预购定金
	private BigDecimal moneyAppointService;	// 预约服务费
	private Integer numBeansDeduct;			// 魅力豆抵扣数量
	private BigDecimal moneyBeansDeduct;	// 魅力豆抵扣金额
	private BigDecimal moneyTotal;			// 总金额
	private BigDecimal moneyPaid;			// 已支付金额
	private Date payTime;					// 支付时间
	private String payType;					// 支付方式
	private String payChannel;				// 支付渠道
	private String receiveName;				// 收货人
	private String receiveTel;				// 收货电话
	private String receiveAreaStr;			// 收货地址省市区
	private String receiveAreaDetail;		// 收货地址详情
	private String memberRemarks;			// 用户备注
	private Warehouse outWarehouse;			// 出库仓库
	
	private List<BuyProduce> buyProduceList = Lists.newArrayList(); 	// 购买产品
	
	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginCreateDate;	// 开始创建时间
	private Date endCreateDate;		// 结束创建时间
	
	private Produce produce;        //  查询产品ID

	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "bus_ob_orderNo";	// 获取购买单编号 字段
	
	// 订单类型 bus_ob_buy_order_type
	public static final String TYPE_BUY					= "1";	// 购买
	public static final String TYPE_APPOINTBUY			= "2";	// 预购
	// 购买时机 bus_ob_buy_order_buyType
	public static final String BUYTYPE_ING				= "1";	// 体验中
	public static final String BUYTYPE_AFTER			= "2";	// 体验后
	// 会员订单状态 bus_ob_buy_order_statusMember
	public static final String STATUSMEMBER_TOSETTLEMENT= "0";	// 待结算
	public static final String STATUSMEMBER_TOPAY		= "1";	// 待支付
	public static final String STATUSMEMBER_TOSEND		= "2";	// 待发货
	public static final String STATUSMEMBER_TORECEIVE	= "3";	// 待收货
	public static final String STATUSMEMBER_FINISH		= "98";	// 交易完成
	public static final String STATUSMEMBER_CLOSE		= "99";	// 交易关闭
	// 系统订单状态 bus_ob_buy_order_statusSystem
	public static final String STATUSSYSTEM_TOSETTLEMENT= "0";	// 待结算
	public static final String STATUSSYSTEM_TOPAY		= "1";	// 待支付
	public static final String STATUSSYSTEM_TOOUT		= "2";	// 待发货
	public static final String STATUSSYSTEM_SENDING		= "3";	// 待收货
	public static final String STATUSSYSTEM_FINISH		= "98";	// 交易完成
	public static final String STATUSSYSTEM_CLOSE		= "99";	// 交易关闭
	// 订单支付状态 bus_order_statusPay
	public static final String STATUSPAY_TOPAY_TOTAL	= "1";	// 待支付（总额）
	public static final String STATUSPAY_TOPAY_APPOINT	= "2";	// 待付定金
	public static final String STATUSPAY_TOPAY_FINAL	= "3";	// 待付尾款
	public static final String STATUSPAY_PAID			= "98";	// 支付完成
	// 订单评价状态 bus_order_statusJudge
	public static final String STATUSJUDGE_TOJUDGE		= "1";	// 待评价
	public static final String STATUSJUDGE_TOCHECK		= "2";	// 评价待审核
	public static final String STATUSJUDGE_JUDGED		= "3";	// 已评价
	// 订单关闭类型 operater_type
	public static final String CLOSETYPE_SYSTEM			= "S";	// 系统关闭
	public static final String CLOSETYPE_MEMBER			= "M";	// 会员关闭
	public static final String CLOSETYPE_STAFF			= "U";	// 员工关闭
	// 预约预购到货状态 bus_order_appointStockStatus
	public static final String APPOINTSTOCKSTATUS_TODO	= "1";	// 待采购
	public static final String APPOINTSTOCKSTATUS_DOING	= "2";	// 采购中
	public static final String APPOINTSTOCKSTATUS_FINISH= "3";	// 已到货
	// 订单支付方式 bus_order_payType
	public static final String PAYTYPE_WECHAT			= "1";	// 微信支付
	// 订单支付渠道 bus_order_payChannel
	public static final String PAYCHANNEL_WECHAT		= "1";	// 微信
	
	
	public BuyOrder() {
		super();
	}

	public BuyOrder(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="订单编号长度必须介于 1 和 64 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Length(min=1, max=2, message="订单类型（购买/预购）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=2, message="购买时机（体验中/后）长度必须介于 1 和 2 之间")
	public String getBuyType() {
		return buyType;
	}

	public void setBuyType(String buyType) {
		this.buyType = buyType;
	}
	
	@Length(min=1, max=64, message="来源体验单ID长度必须介于 1 和 64 之间")
	public ExperienceOrder getExperienceOrder() {
		return experienceOrder;
	}

	public void setExperienceOrder(ExperienceOrder experienceOrder) {
		this.experienceOrder = experienceOrder;
	}
	
	@Length(min=1, max=2, message="会员订单状态长度必须介于 1 和 2 之间")
	public String getStatusMember() {
		return statusMember;
	}

	public void setStatusMember(String statusMember) {
		this.statusMember = statusMember;
	}
	
	@Length(min=1, max=2, message="系统订单状态长度必须介于 1 和 2 之间")
	public String getStatusSystem() {
		return statusSystem;
	}

	public void setStatusSystem(String statusSystem) {
		this.statusSystem = statusSystem;
	}
	
	@Length(min=1, max=2, message="支付状态长度必须介于 1 和 2 之间")
	public String getStatusPay() {
		return statusPay;
	}

	public void setStatusPay(String statusPay) {
		this.statusPay = statusPay;
	}
	
	@Length(min=1, max=2, message="评价状态长度必须介于 1 和 2 之间")
	public String getStatusJudge() {
		return statusJudge;
	}

	public void setStatusJudge(String statusJudge) {
		this.statusJudge = statusJudge;
	}

	@Length(min=0, max=2, message="订单关闭类型长度必须介于 0 和 2 之间")
	public String getCloseType() {
		return closeType;
	}

	public void setCloseType(String closeType) {
		this.closeType = closeType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(Date closeTime) {
		this.closeTime = closeTime;
	}
	
	@Length(min=0, max=2, message="预购到货状态长度必须介于 0 和 2 之间")
	public String getAppointStockStatus() {
		return appointStockStatus;
	}

	public void setAppointStockStatus(String appointStockStatus) {
		this.appointStockStatus = appointStockStatus;
	}
	
	@NotNull(message="产品总额不能为空")
	public BigDecimal getMoneyProduce() {
		return moneyProduce;
	}

	public void setMoneyProduce(BigDecimal moneyProduce) {
		this.moneyProduce = moneyProduce;
	}
	
	@NotNull(message="物流费不能为空")
	public BigDecimal getMoneyLgt() {
		return moneyLgt;
	}

	public void setMoneyLgt(BigDecimal moneyLgt) {
		this.moneyLgt = moneyLgt;
	}
	
	@NotNull(message="预购定金不能为空")
	public BigDecimal getMoneyAppoint() {
		return moneyAppoint;
	}

	public void setMoneyAppoint(BigDecimal moneyAppoint) {
		this.moneyAppoint = moneyAppoint;
	}
	
	@NotNull(message="总金额不能为空")
	public BigDecimal getMoneyTotal() {
		return moneyTotal;
	}

	public void setMoneyTotal(BigDecimal moneyTotal) {
		this.moneyTotal = moneyTotal;
	}
	
	@NotNull(message="已支付金额不能为空")
	public BigDecimal getMoneyPaid() {
		return moneyPaid;
	}

	public void setMoneyPaid(BigDecimal moneyPaid) {
		this.moneyPaid = moneyPaid;
	}
	
	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	@Length(min=0, max=2, message="支付方式长度必须介于 0 和 2 之间")
	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}
	
	@Length(min=0, max=2, message="支付渠道长度必须介于 0 和 2 之间")
	public String getPayChannel() {
		return payChannel;
	}

	public void setPayChannel(String payChannel) {
		this.payChannel = payChannel;
	}
	
	@Length(min=1, max=50, message="收货人长度必须介于 1 和 50 之间")
	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}
	
	@Length(min=1, max=50, message="收货电话长度必须介于 1 和 50 之间")
	public String getReceiveTel() {
		return receiveTel;
	}

	public void setReceiveTel(String receiveTel) {
		this.receiveTel = receiveTel;
	}
	
	@Length(min=1, max=100, message="收货地址省市区长度必须介于 1 和 100 之间")
	public String getReceiveAreaStr() {
		return receiveAreaStr;
	}

	public void setReceiveAreaStr(String receiveAreaStr) {
		this.receiveAreaStr = receiveAreaStr;
	}
	
	@Length(min=1, max=100, message="收货地址详情长度必须介于 1 和 100 之间")
	public String getReceiveAreaDetail() {
		return receiveAreaDetail;
	}

	public void setReceiveAreaDetail(String receiveAreaDetail) {
		this.receiveAreaDetail = receiveAreaDetail;
	}
	
	@Length(min=0, max=255, message="用户备注长度必须介于 0 和 255 之间")
	public String getMemberRemarks() {
		return memberRemarks;
	}

	public void setMemberRemarks(String memberRemarks) {
		this.memberRemarks = memberRemarks;
	}

	public List<BuyProduce> getBuyProduceList() {
		return buyProduceList;
	}

	public void setBuyProduceList(List<BuyProduce> buyProduceList) {
		this.buyProduceList = buyProduceList;
	}
	
	

	public Warehouse getOutWarehouse() {
		return outWarehouse;
	}

	public void setOutWarehouse(Warehouse outWarehouse) {
		this.outWarehouse = outWarehouse;
	}

	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public BigDecimal getMoneyAppointService() {
		return moneyAppointService;
	}

	public void setMoneyAppointService(BigDecimal moneyAppointService) {
		this.moneyAppointService = moneyAppointService;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	@NotNull(message="魅力豆抵扣数量不能为空")
	public Integer getNumBeansDeduct() {
		return numBeansDeduct;
	}

	public void setNumBeansDeduct(Integer numBeansDeduct) {
		this.numBeansDeduct = numBeansDeduct;
	}
	@NotNull(message="魅力豆抵扣金额不能为空")
	public BigDecimal getMoneyBeansDeduct() {
		return moneyBeansDeduct;
	}

	public void setMoneyBeansDeduct(BigDecimal moneyBeansDeduct) {
		this.moneyBeansDeduct = moneyBeansDeduct;
	}

	public String getStatusInvoice() {
		return statusInvoice;
	}

	public void setStatusInvoice(String statusInvoice) {
		this.statusInvoice = statusInvoice;
	}


}