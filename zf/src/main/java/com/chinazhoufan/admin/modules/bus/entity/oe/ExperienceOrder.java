/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.oe;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudge;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 体验单Entity123
 * @author 张金俊
 * @version 2017-04-12
 */
public class ExperienceOrder extends DataEntity<ExperienceOrder> {
	
	private static final long serialVersionUID = 1L;
	private String orderNo;					// 订单编号
	private Member member;					// 会员ID
	private String experiencePackId;        //体验包字段
	private String type;					// 订单类型（体验/预约）
	private String statusMember;			// 会员订单状态
	private String statusSystem;			// 系统订单状态
	private String statusPay;				// 支付状态
	private String statusJudge;				// 评价状态
	private String closeType;				// 订单关闭类型（系统/员工/会员）
	private Date closeTime;					// 订单关闭时间
	private String appointDateType;			// 预约时间类型（即刻/指定日期）
	private Date appointDate;				// 预约体验日期
	private String appointStockStatus;		// 预约到货状态
	private String statusLogistical;		// 物流状态
	private Date sendTime;					// 发货时间
	private Integer expressDays;			// 物流时长（天）
	private Date realExpDate;				// 实际体验日期（体验开始日期）
	private Date appointPickDate;			// 预约取件日期
	private BigDecimal moneyProduce;		// 产品总额(押金)
	private BigDecimal moneyLgt;			// 物流费
	private BigDecimal moneyBackLgt;		//回程运费原值
	private BigDecimal moneyExperience;		// 体验费
	private BigDecimal moneyAppoint;		// 预约定金
	private BigDecimal moneyAppointService;	// 预约服务费
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
	private String fullRefundFlag;			// 全额退款标记
	private BigDecimal moneySettSrcReturn;		// 结算原始应退金额
	private BigDecimal moneySettDec;			// 结算扣减金额
	private BigDecimal moneySettDecableBeans;	// 结算魅力豆可抵金额
	private BigDecimal moneySettDecBeans;		// 结算魅力豆抵扣金额
	private Integer numSettDecBeans;			// 结算魅力豆抵扣数量
	private BigDecimal moneySettOverdue;		// 结算滞纳金
	private BigDecimal moneySettReturnExpress;	// 结算退还回程快递费
	private BigDecimal moneySettReturn;			// 结算退款金额
	private Date settlementTime;				// 结算时间
	private String zmxyFlag;					// 是否使用芝麻信用免押金(0、未使用 1、已使用)
	private BigDecimal arrearageAmount;			// 欠费金额
	private String settBuy;						// 是否结算转购买(0、否 1、是)
	private ExperiencePack experiencePack;
	private Integer experienceTime;             //体验包时长
	//体验单关联的体验单产品信息
	private List<ExperienceProduce> epList = Lists.newArrayList();
	//体验单关联的订单评价信息
	private ProduceJudge produceJudge;
	
	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginCreateDate;		// 开始创建时间
	private Date endCreateDate;			// 结束创建时间
	
	private Date receiveTime;			// 预计到仓时间
	
	private Integer experienceDays;		// 正常体验天数
	private Integer experienceDaysMax;	// 可体验天数最大值（超过自动转购买）
	private Integer paramDays;			// 时长（天）
	
	private Produce produce;        	// 查询产品ID

	private String allBuyFalg;			//是否全部转购买标记

	private String isQuality;			//是否已质检

	private String isLightBroken;			//是否存在轻度损坏的货品

	private String isAutoBuy;				// 是否自动转购买

	private String prov;			//城市
	private String city;			//发货城市和县区，英文逗号分割
	
	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "bus_oe_orderNo";	// 获取体验单编号 字段

	public static final String CONFIG_APPOINT_MAX 			= "experienceOrderAppointDaysMax";			// 业务参数：最长可预约体验日期（天）
	public static final String CONFIG_APPOINT_MIN_NOSTOCK 	= "experienceOrderAppointDaysMinNoStock";	// 业务参数：最短可预约体验日期（天）（产品无货）
	public static final String CONFIG_APPOINT_MIN_HAVESTOCK = "experienceOrderAppointDaysMinHaveStock";	// 业务参数：最短可预约体验日期（天）（产品有货）
	public static final String CONFIG_DELAYABLEDAYS			= "experienceOrderDelayableDays";			// 业务参数：体验订单可延迟归还时长（天）
	public static final String CONFIG_EXPERIENCEDAYS		= "experienceOrderExperienceDays";			// 业务参数：体验订单可体验时长（天）
	
	// 订单类型 bus_oe_experience_order_type
	public static final String TYPE_EXPERIENCE			= "1";	// 体验
	public static final String TYPE_APPOINTEXPERIENCE	= "2";	// 预约体验
	// 会员订单状态 bus_oe_experience_order_statusMember
	public static final String STATUSMEMBER_TOPAY		= "1";	// 待支付
	public static final String STATUSMEMBER_TOSEND		= "2";	// 待发货
	public static final String STATUSMEMBER_TORECEIVE	= "3";	// 待收货
	public static final String STATUSMEMBER_EXPERIENCING= "5";	// 体验中
	public static final String STATUSMEMBER_RETURNING	= "7";	// 退货中
	public static final String STATUSMEMBER_FINISH		= "98";	// 交易完成
	public static final String STATUSMEMBER_CLOSE		= "99";	// 交易关闭
	public static final String STATUSMEMBER_DUE			= "100";	// 欠款
	// 系统订单状态 bus_oe_experience_order_statusSystem
	public static final String STATUSSYSTEM_TOPAY		= "1";	// 待支付
	public static final String STATUSSYSTEM_TOOUT		= "2";	// 待发货
	public static final String STATUSSYSTEM_SENDING		= "3";	// 待收货（送货中）
	public static final String STATUSSYSTEM_ARRIVED		= "4";	// 已送达
	public static final String STATUSSYSTEM_EXPERIENCING= "5";	// 体验中（已确认收货）
	public static final String STATUSSYSTEM_DECIDING	= "6";	// 决策中
	public static final String STATUSSYSTEM_RETURNING	= "7";	// 退货中
	public static final String STATUSSYSTEM_FINISH		= "98";	// 交易完成
	public static final String STATUSSYSTEM_CLOSE		= "99";	// 交易关闭
	public static final String STATUSSYSTEM_DUE			= "100";	// 欠款
	// 订单支付状态 bus_order_statusPay
	public static final String STATUSPAY_TOPAY_TOTAL	= "1";	// 待支付（总额）
	public static final String STATUSPAY_TOPAY_APPOINT	= "2";	// 待付定金
	public static final String STATUSPAY_TOPAY_FINAL	= "3";	// 待付尾款
	public static final String STATUSPAY_PAID			= "98";	// 支付完成
	// 订单评价状态 bus_order_statusJudge
	public static final String STATUSJUDGE_TOJUDGE		= "1";	// 待评价
	public static final String STATUSJUDGE_JUDGED		= "2";	// 已评价
	// 预约时间类型 bus_oe_experience_order_appointDateType
	public static final String APPOINTDATETYPE_NOW		= "1";	// 即刻
	public static final String APPOINTDATETYPE_APPOINT	= "2";	// 指定日期
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
	public static final String PAYTYPE_CMBC				= "2";	// 民生银行
	// 订单支付渠道 bus_order_payChannel
	public static final String PAYCHANNEL_WECHAT		= "1";	// 微信
	// 物流状态 	bus_oe_experience_order_statusLogistical
	public static final String EXPRESS_FAILED		= "FAILED";	// 拒收
	public static final String EXPRESS_SIGNED		= "SIGNED";	// 已签收
	
	public ExperienceOrder() {
		super();
	}

	public ExperienceOrder(String id){
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
	
	@Length(min=1, max=2, message="订单类型（体验/预约）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
	
	@Length(min=0, max=2, message="订单关闭类型（系统/会员）长度必须介于 0 和 2 之间")
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
	
	@Length(min=0, max=2, message="预约时间类型（即刻/指定日期）长度必须介于 0 和 2 之间")
	public String getAppointDateType() {
		return appointDateType;
	}

	public void setAppointDateType(String appointDateType) {
		this.appointDateType = appointDateType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAppointDate() {
		return appointDate;
	}

	public void setAppointDate(Date appointDate) {
		this.appointDate = appointDate;
	}
	
	@Length(min=0, max=2, message="预约到货状态长度必须介于 0 和 2 之间")
	public String getAppointStockStatus() {
		return appointStockStatus;
	}

	public void setAppointStockStatus(String appointStockStatus) {
		this.appointStockStatus = appointStockStatus;
	}
	
	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Integer getExpressDays() {
		return expressDays;
	}

	public void setExpressDays(Integer expressDays) {
		this.expressDays = expressDays;
	}

	public Date getRealExpDate() {
		return realExpDate;
	}

	public void setRealExpDate(Date realExpDate) {
		this.realExpDate = realExpDate;
	}

	public Date getAppointPickDate() {
		return appointPickDate;
	}

	public void setAppointPickDate(Date appointPickDate) {
		this.appointPickDate = appointPickDate;
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
	
	@NotNull(message="体验费不能为空")
	public BigDecimal getMoneyExperience() {
		return moneyExperience;
	}

	public void setMoneyExperience(BigDecimal moneyExperience) {
		this.moneyExperience = moneyExperience;
	}
	
	@NotNull(message="预约定金不能为空")
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

	public List<ExperienceProduce> getEpList() {
		return epList;
	}

	public void setEpList(List<ExperienceProduce> epList) {
		this.epList = epList;
	}

	public Warehouse getOutWarehouse() {
		return outWarehouse;
	}

	public void setOutWarehouse(Warehouse outWarehouse) {
		this.outWarehouse = outWarehouse;
	}

	public String getFullRefundFlag() {
		return fullRefundFlag;
	}

	public void setFullRefundFlag(String fullRefundFlag) {
		this.fullRefundFlag = fullRefundFlag;
	}

	public BigDecimal getMoneySettSrcReturn() {
		return moneySettSrcReturn;
	}

	public void setMoneySettSrcReturn(BigDecimal moneySettSrcReturn) {
		this.moneySettSrcReturn = moneySettSrcReturn;
	}

	public BigDecimal getMoneySettDec() {
		return moneySettDec;
	}

	public void setMoneySettDec(BigDecimal moneySettDec) {
		this.moneySettDec = moneySettDec;
	}

	public BigDecimal getMoneySettDecableBeans() {
		return moneySettDecableBeans;
	}

	public void setMoneySettDecableBeans(BigDecimal moneySettDecableBeans) {
		this.moneySettDecableBeans = moneySettDecableBeans;
	}

	public BigDecimal getMoneySettDecBeans() {
		return moneySettDecBeans;
	}

	public void setMoneySettDecBeans(BigDecimal moneySettDecBeans) {
		this.moneySettDecBeans = moneySettDecBeans;
	}

	public Integer getNumSettDecBeans() {
		return numSettDecBeans;
	}

	public void setNumSettDecBeans(Integer numSettDecBeans) {
		this.numSettDecBeans = numSettDecBeans;
	}

	public BigDecimal getMoneySettOverdue() {
		return moneySettOverdue;
	}

	public void setMoneySettOverdue(BigDecimal moneySettOverdue) {
		this.moneySettOverdue = moneySettOverdue;
	}

	public BigDecimal getMoneySettReturnExpress() {
		return moneySettReturnExpress;
	}

	public void setMoneySettReturnExpress(BigDecimal moneySettReturnExpress) {
		this.moneySettReturnExpress = moneySettReturnExpress;
	}

	public BigDecimal getMoneySettReturn() {
		return moneySettReturn;
	}

	public void setMoneySettReturn(BigDecimal moneySettReturn) {
		this.moneySettReturn = moneySettReturn;
	}

	public Date getSettlementTime() {
		return settlementTime;
	}

	public void setSettlementTime(Date settlementTime) {
		this.settlementTime = settlementTime;
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

	public Integer getExperienceDaysMax() {
		return experienceDaysMax;
	}

	public void setExperienceDaysMax(Integer experienceDaysMax) {
		this.experienceDaysMax = experienceDaysMax;
	}

	public Integer getExperienceDays() {
		return experienceDays;
	}

	public void setExperienceDays(Integer experienceDays) {
		this.experienceDays = experienceDays;
	}

	public Integer getParamDays() {
		return paramDays;
	}

	public void setParamDays(Integer paramDays) {
		this.paramDays = paramDays;
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

	public ProduceJudge getProduceJudge() {
		return produceJudge;
	}

	public void setProduceJudge(ProduceJudge produceJudge) {
		this.produceJudge = produceJudge;
	}

	public String getZmxyFlag() {
		return zmxyFlag;
	}

	public void setZmxyFlag(String zmxyFlag) {
		this.zmxyFlag = zmxyFlag;
	}

	public ExperiencePack getExperiencePack() {
		return experiencePack;
	}

	public void setExperiencePack(ExperiencePack experiencePack) {
		this.experiencePack = experiencePack;
	}

	public BigDecimal getArrearageAmount() {
		return arrearageAmount;
	}

	public void setArrearageAmount(BigDecimal arrearageAmount) {
		this.arrearageAmount = arrearageAmount;
	}

	public String getStatusLogistical() {
		return statusLogistical;
	}

	public void setStatusLogistical(String statusLogistical) {
		this.statusLogistical = statusLogistical;
	}

	public String getAllBuyFalg() {
		return allBuyFalg;
	}

	public void setAllBuyFalg(String allBuyFalg) {
		this.allBuyFalg = allBuyFalg;
	}

	public BigDecimal getMoneyBackLgt() {
		return moneyBackLgt;
	}

	public void setMoneyBackLgt(BigDecimal moneyBackLgt) {
		this.moneyBackLgt = moneyBackLgt;
	}

	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}

	public String getExperiencePackId() {
		return experiencePackId;
	}

	public void setExperiencePackId(String experiencePackId) {
		this.experiencePackId = experiencePackId;
	}
	

	public String getIsQuality() {
		return isQuality;
	}

	public void setIsQuality(String isQuality) {
		this.isQuality = isQuality;
	}

	public String getIsLightBroken() {
		return isLightBroken;
	}

	public void setIsLightBroken(String isLightBroken) {
		this.isLightBroken = isLightBroken;
	}

	public String getIsAutoBuy() {
		return isAutoBuy;
	}

	public void setIsAutoBuy(String isAutoBuy) {
		this.isAutoBuy = isAutoBuy;
	}

	public String getSettBuy() {
		return settBuy;
	}

	public void setSettBuy(String settBuy) {
		this.settBuy = settBuy;
	}

	public Integer getExperienceTime() {
		return experienceTime;
	}

	public void setExperienceTime(Integer experienceTime) {
		this.experienceTime = experienceTime;
	}

	public String getProv() {
		return prov;
	}

	public void setProv(String prov) {
		this.prov = prov;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
}