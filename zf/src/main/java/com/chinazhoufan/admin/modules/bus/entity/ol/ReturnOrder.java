/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 退货单Entity
 * @author 张金俊
 * @version 2017-04-19
 */
public class ReturnOrder extends DataEntity<ReturnOrder> {
	
	private static final long serialVersionUID = 1L;
	private String returnOrderNo;	// 退货单编号
	private String orderType;		// 来源订单类型（体验/预约..）
	private String orderId;			// 来源订单ID
	private String orderNo;			// 来源订单编号
	private String status;			// 退货状态		bus_ol_return_order_status
	private String reasonType;		// 退货原因类型	bus_ol_return_order_reasonType
	private String reasonDetail;	// 退货原因详情
	private String sendName;		// 发货人
	private String sendTel;			// 发货电话
	private String sendAreaStr;		// 发货地址省市区
	private String sendAreaDetail;	// 发货地址详情
	private String expressCompany;	// 快递公司	express_company
	private String expressNo;		// 快递单号
	private BigDecimal expressPrice;// 快递费用
	private User receiveBy;         // 回货收货人
	private Date receiveTime;       // 回货收货时间
	private User checkBy;         	// 质检人
	private Date checkTime;       	// 质检时间
	private List<ReturnProduct> returnProductList = Lists.newArrayList();

	/******************************************** 自定义变量  *********************************************/
	private String productNo;
	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginReceiveTime;			// 开始收货时间
	private Date endReceiveTime;			// 结束收货时间
	/******************************************** 自定义常量  *********************************************/
	// 来源订单类型 bus_order_type：枚举类OrderType
	
	// 退货状态 bus_ol_return_order_status
	public static final String STATUS_TORETURN		= "1";	// 待退货
	public static final String STATUS_RETURNING		= "2";	// 退货中
	public static final String STATUS_TOCHECK		= "3";	// 待质检
	public static final String STATUS_TOACCOUNT		= "4";	// 待结算
	public static final String STATUS_FINISH		= "5";	// 退货完成
	public static final String STATUS_HANG			= "99";	// 挂起
	public static final String STATUS_REFUSE		= "98";	// 拒收退货
	// 退货原因类型 bus_ol_return_order_reasonType
	public static final String REASONTYPE_EXPERIENCE_FINISH		= "1";	// 体验结束退货
	public static final String REASONTYPE_EXPERIENCE_CHANGEBUY	= "2";	// 体验结束换购
	public static final String REASONTYPE_EXPERIENCE_APPOINTBUY	= "3";	// 体验结束预购
	public static final String REASONTYPE_REFUSE				= "99";	// 拒收退货
	
	public ReturnOrder() {
		super();
	}

	public ReturnOrder(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="退货单编号长度必须介于 1 和 64 之间")
	public String getReturnOrderNo() {
		return returnOrderNo;
	}

	public void setReturnOrderNo(String returnOrderNo) {
		this.returnOrderNo = returnOrderNo;
	}
	
	@Length(min=1, max=2, message="来源订单类型长度必须介于 1 和 2 之间")
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
	
	@Length(min=1, max=2, message="退货状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=2, message="退货原因类型长度必须介于 1 和 2 之间")
	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}
	
	@Length(min=0, max=255, message="退货原因详情长度必须介于 0 和 255 之间")
	public String getReasonDetail() {
		return reasonDetail;
	}

	public void setReasonDetail(String reasonDetail) {
		this.reasonDetail = reasonDetail;
	}
	
	public String getSendName() {
		return sendName;
	}

	public void setSendName(String sendName) {
		this.sendName = sendName;
	}

	public String getSendTel() {
		return sendTel;
	}

	public void setSendTel(String sendTel) {
		this.sendTel = sendTel;
	}

	public String getSendAreaStr() {
		return sendAreaStr;
	}

	public void setSendAreaStr(String sendAreaStr) {
		this.sendAreaStr = sendAreaStr;
	}

	public String getSendAreaDetail() {
		return sendAreaDetail;
	}

	public void setSendAreaDetail(String sendAreaDetail) {
		this.sendAreaDetail = sendAreaDetail;
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

	@NotNull(message="快递费用不能为空")
	public BigDecimal getExpressPrice() {
		return expressPrice;
	}

	public void setExpressPrice(BigDecimal expressPrice) {
		this.expressPrice = expressPrice;
	}

	public List<ReturnProduct> getReturnProductList() {
		return returnProductList;
	}

	public void setReturnProductList(List<ReturnProduct> returnProductList) {
		this.returnProductList = returnProductList;
	}

	public User getReceiveBy() {
		return receiveBy;
	}

	public void setReceiveBy(User receiveBy) {
		this.receiveBy = receiveBy;
	}

	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}

	public User getCheckBy() {
		return checkBy;
	}

	public void setCheckBy(User checkBy) {
		this.checkBy = checkBy;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getProductNo() {
		return productNo;
	}

	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}

	public Date getBeginReceiveTime() {
		return beginReceiveTime;
	}

	public void setBeginReceiveTime(Date beginReceiveTime) {
		this.beginReceiveTime = beginReceiveTime;
	}

	public Date getEndReceiveTime() {
		return endReceiveTime;
	}

	public void setEndReceiveTime(Date endReceiveTime) {
		this.endReceiveTime = endReceiveTime;
	}
}