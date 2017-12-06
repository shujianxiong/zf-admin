/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 发货单Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class SendOrder extends DataEntity<SendOrder> {
	
	private static final long serialVersionUID = 1L;
	private String sendOrderNo;			// 发货单编号
	private String orderType;			// 来源订单类型（体验/预约/购买/预购）
	private String orderId;				// 来源订单ID
	private String orderNo;				// 来源订单编号
	private String status;				// 发货状态（待发货/发货中/发货完成）
	private String activeFlag;          // 激活标志（0挂起，1激活，默认为1）
	private Date sendDate;				// 发货日期
	private String receiveName;			// 收货人
	private String receiveTel;			// 收货电话
	private String receiveAreaStr;		// 收货地址省市区
	private String receiveAreaDetail;	// 收货地址详情
	private String memberRemarks;		// 用户备注
	private PickOrder pickOrder;		// 所属拣货单
	private String pickNo;				// 所属拣货序号
	private String expressCompany;		// 快递公司
	private String expressNo;			// 快递单号
	private Date expressTime;			// 发货时间
	
	private String returnExpressNo;     // 回货快递单号
	private String returnExpressCompany;// 回货快递公司
	private String type;// 发货单类型(1、体验发货单 2、换新发货单 3、维修发货单)
	
	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginSendDate;		// 开始 可发货日期
	private Date endSendDate;		// 结束 可发货日期

	private Date beginExpressTime;		// 开始 发货时间
	private Date endExpressTime;		// 结束 发货时间
	
	private Date beginCreateTime;       // 开始创建时间
	private Date endCreateTime;         // 截止创建时间
	
	private Date beginUpdateTime;       // 更新开始时间
	private Date endUpdateTime;         // 更新截止时间

	private String courtType;       	// 商品数量类型(单件/多件)

	private Produce produce;            // 关联产品id
	private List<SendProduce> sendProduceList = Lists.newArrayList();	// 所关联发货产品集合
	
	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "bus_ol_send_order_orderNo";	// 获取发货单编号 字段
	/******************************************** 自定义变量  *********************************************/
	private String productNo;
	private String orderCancelFlag; //取消订单申请
	// 来源订单类型 bus_order_type：枚举类OrderType
	
	// 发货状态 bus_ol_send_order_status
	public static final String STATUS_TOPICK 		= "1";	// 待拣货
	public static final String STATUS_PICKING 		= "2";	// 拣货中
	public static final String STATUS_PACKAGEING 	= "3";	// 打包中
	public static final String STATUS_SENDING 		= "4";	// 送货中
	public static final String STATUS_FINISH 		= "5";	// 发货完成
	public static final String STATUS_WAITSEND 		= "7";	// 待发货
	public static final String STATUS_SIGNED		= "8";	// 已签收
	public static final String STATUS_CANCEL		= "99";	// 发货取消
	
	private String destCode;      //快递编码
	// 快递公司 express_company
	public static final String EXPRESS_COMPANY_SF	= "1";	// 顺丰快递
	public static final String EXPRESS_COMPANY_YD	= "2";	// 韵达快递
	public static final String EXPRESS_COMPANY_ZT	= "3";	// 中通快递
	public static final String EXPRESS_COMPANY_ST	= "4";	// 申通快递
	public static final String EXPRESS_COMPANY_YT	= "5";	// 圆通快递
	public static final String EXPRESS_COMPANY_TT	= "6";	// 天天快递
	public static final String EXPRESS_COMPANY_ZJS	= "7";	// 宅急送
	
	// 来源订单类型 bus_order_type
	public static final String ORDERTYPE_EXPERIENCE		= "1";	// 体验
	public static final String ORDERTYPE_FOREEXPERIENCE	= "2";	// 预约体验
	public static final String ORDERTYPE_BUY 			= "3";	// 购买
	public static final String ORDERTYPE_FORBUY 		= "4";	// 预约购买

	// 发货单类型 send_order_type
	public static final String SENDTYPE_EXPERIENCE		= "1";	// 体验单发货
	public static final String ORDERTYPE_CHANGE			= "2";	// 换新发货
	public static final String ORDERTYPE_REPAIR 			= "3";	//维修发货
	public SendOrder() {
		super();
	}

	public SendOrder(String id){
		super(id);
	}
	

	@Length(min=1, max=64, message="发货单编号长度必须介于 1 和 64 之间")
	public String getSendOrderNo() {
		return sendOrderNo;
	}

	public void setSendOrderNo(String sendOrderNo) {
		this.sendOrderNo = sendOrderNo;
	}
	
	@Length(min=1, max=2, message="来源订单类型（体验/预约/购买/预购）长度必须介于 1 和 2 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=1, max=64, message="来源订单ID长度必须介于 1 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=1, max=64, message="来源订单编号长度必须介于 1 和 64 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Length(min=1, max=2, message="发货状态（待发货/发货中/发货完成）长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
	
	@Length(min=0, max=64, message="所属拣货单ID长度必须介于 0 和 64 之间")
	public PickOrder getPickOrder() {
		return pickOrder;
	}

	public void setPickOrder(PickOrder pickOrder) {
		this.pickOrder = pickOrder;
	}
	
	@Length(min=0, max=11, message="所属拣货序号长度必须介于 0 和 11 之间")
	public String getPickNo() {
		return pickNo;
	}

	public void setPickNo(String pickNo) {
		this.pickNo = pickNo;
	}
	
	@Length(min=0, max=2, message="快递公司长度必须介于 0 和 2 之间")
	public String getExpressCompany() {
		return expressCompany;
	}

	public void setExpressCompany(String expressCompany) {
		this.expressCompany = expressCompany;
	}
	
	@Length(min=0, max=50, message="快递单号长度必须介于 0 和 50 之间")
	public String getExpressNo() {
		return expressNo;
	}

	public void setExpressNo(String expressNo) {
		this.expressNo = expressNo;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getBeginSendDate() {
		return beginSendDate;
	}

	public void setBeginSendDate(Date beginSendDate) {
		this.beginSendDate = beginSendDate;
	}

	public Date getEndSendDate() {
		return endSendDate;
	}

	public void setEndSendDate(Date endSendDate) {
		this.endSendDate = endSendDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getExpressTime() {
		return expressTime;
	}

	public void setExpressTime(Date expressTime) {
		this.expressTime = expressTime;
	}
	
	public Date getBeginExpressTime() {
		return beginExpressTime;
	}

	public void setBeginExpressTime(Date beginExpressTime) {
		this.beginExpressTime = beginExpressTime;
	}
	
	public Date getEndExpressTime() {
		return endExpressTime;
	}

	public void setEndExpressTime(Date endExpressTime) {
		this.endExpressTime = endExpressTime;
	}

	public List<SendProduce> getSendProduceList() {
		return sendProduceList;
	}

	public void setSendProduceList(List<SendProduce> sendProduceList) {
		this.sendProduceList = sendProduceList;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	public String getReturnExpressNo() {
		return returnExpressNo;
	}

	public void setReturnExpressNo(String returnExpressNo) {
		this.returnExpressNo = returnExpressNo;
	}

	public String getReturnExpressCompany() {
		return returnExpressCompany;
	}

	public void setReturnExpressCompany(String returnExpressCompany) {
		this.returnExpressCompany = returnExpressCompany;
	}

	public Date getBeginCreateTime() {
		return beginCreateTime;
	}

	public void setBeginCreateTime(Date beginCreateTime) {
		this.beginCreateTime = beginCreateTime;
	}

	public Date getEndCreateTime() {
		return endCreateTime;
	}

	public void setEndCreateTime(Date endCreateTime) {
		this.endCreateTime = endCreateTime;
	}

	public String getCourtType() {
		return courtType;
	}

	public void setCourtType(String courtType) {
		this.courtType = courtType;
	}

	public Date getBeginUpdateTime() {
		return beginUpdateTime;
	}

	public void setBeginUpdateTime(Date beginUpdateTime) {
		this.beginUpdateTime = beginUpdateTime;
	}

	public Date getEndUpdateTime() {
		return endUpdateTime;
	}

	public void setEndUpdateTime(Date endUpdateTime) {
		this.endUpdateTime = endUpdateTime;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	public String getProductNo() {
		return productNo;
	}

	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}

	public String getOrderCancelFlag() {
		return orderCancelFlag;
	}

	public void setOrderCancelFlag(String orderCancelFlag) {
		this.orderCancelFlag = orderCancelFlag;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDestCode() {
		return destCode;
	}

	public void setDestCode(String destCode) {
		this.destCode = destCode;
	}
	
}