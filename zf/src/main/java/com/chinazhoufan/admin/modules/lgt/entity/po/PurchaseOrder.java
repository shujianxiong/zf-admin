/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.po;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.common.utils.excel.annotation.ExcelField;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 采购任务单Entity
 * @author 张金俊
 * @version 2015-10-16
 */
public class PurchaseOrder extends DataEntity<PurchaseOrder> {
	
	private static final long serialVersionUID = 1L;
	private PurchaseMission purchaseMission;// 采购任务ID
	private String orderNo;					// 采购单编号
	private Supplier supplier;				// 选定供应商id
	private String orderStatus;				// 采购订单状态	1：新建	2：已提交	3：采购中	4：采购完成
	private User purchaseUser;				// 采购员工编号
	private BigDecimal payableAmount;		// 应付采购金额
	private BigDecimal paidAmount;			// 实付采购金额
	private Date requiredTime;				// 要求完成时间
	private Date finishTime;				// 实际完成时间
	private BigDecimal clearingGoldprice;	// 结算金价
	
	private Date receiveTime;				// 入库时间
	// 2016-12-2  添加审核信息
	private User checkBy;//审核人
	private Date checkTime;//审核时间
	private String checkRemarks;//审核备注
	
	private Date beginEnterTime;		// 开始 录入时间
	private Date endEnterTime;			// 结束 录入时间
	
	private List<PurchaseProduce> purchaseProduceList = Lists.newArrayList();		// 采购产品列表
	
	private String flag;					// 是否删除标识
	
	/****************************** 查询条件 ****************************************/
	private int startOrderStatus;			// 起始订单状态（查询条件，查询出该状态及之后状态的订单）
	private Date beginRequiredTime;				// 要求完成开始时间
	private Date endRequiredTime;				// 要求完成结束时间

	private Integer inBatchNo;				// 货品录入的批次

	private String  productCode;				// 关联货品编码
	
	/******************************* 常量  *****************************************/
	// 采购状态（1：新建	2：已提交	3：采购中	4：采购完成）
	public static final String ORDERSTATUS_NEW 			= "1";	// 新建		（  PS：任务分单后，生成的采购订单直接进入待接单状态，故“新建”状态未启用）
	public static final String ORDERSTATUS_SUBMITED		= "2";	// 待接单		（任务状态：已提交）
	public static final String ORDERSTATUS_PURCHASING	= "3";	// 采购中		（任务状态：已提交采购中）
	public static final String ORDERSTATUS_FINISHED 	= "4";	// 采购完成	（任务状态：已提交采购中/采购完成）
	
	public static final String ORDERSTATUS_CLOSE = "99";  //审核不通过，采购单关闭
	
	
	public static final String GENERATECODE_ORDERNO = "lgt_po_purchase_order_orderNo";	// 获取采购单编号 字段
	
	/**原状态：
	 * 	1已创建待接单
	 * 	2已接单采购中
	 * 	3已受理生产中
	 * 	4生产完成待结算
	 * 	5已结算待取货
	 * 	6已取货待分货（待质检）
	 * 	7已分货待入库
	 * 	8已入库确认完成 */
	

	
	public PurchaseOrder() {
		super();
	}
	public PurchaseOrder(String id){
		super(id);
	}
	

	public PurchaseMission getPurchaseMission() {
		return purchaseMission;
	}

	public void setPurchaseMission(PurchaseMission purchaseMission) {
		this.purchaseMission = purchaseMission;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@ExcelField(title="供应商名称", value = "supplier.name",  align=2, sort=1)
	public Supplier getSupplier() {
		return supplier;
	}
	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	@NotNull(message="采购员工不能为空")
	public User getPurchaseUser() {
		return purchaseUser;
	}

	public void setPurchaseUser(User purchaseUser) {
		this.purchaseUser = purchaseUser;
	}

	public BigDecimal getPayableAmount() {
		return payableAmount;
	}

	public void setPayableAmount(BigDecimal payableAmount) {
		this.payableAmount = payableAmount;
	}
	
	public BigDecimal getPaidAmount() {
		return paidAmount;
	}

	public void setPaidAmount(BigDecimal paidAmount) {
		this.paidAmount = paidAmount;
	}
	

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="要求完成时间不能为空")
	public Date getRequiredTime() {
		return requiredTime;
	}

	public void setRequiredTime(Date requiredTime) {
		this.requiredTime = requiredTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}
	
	public BigDecimal getClearingGoldprice() {
		return clearingGoldprice;
	}

	public void setClearingGoldprice(BigDecimal clearingGoldprice) {
		this.clearingGoldprice = clearingGoldprice;
	}

	public List<PurchaseProduce> getPurchaseProduceList() {
		return purchaseProduceList;
	}

	public void setPurchaseProduceList(List<PurchaseProduce> purchaseProduceList) {
		this.purchaseProduceList = purchaseProduceList;
	}

	public Date getBeginRequiredTime() {
		return beginRequiredTime;
	}

	public void setBeginRequiredTime(Date beginRequiredTime) {
		this.beginRequiredTime = beginRequiredTime;
	}

	public Date getEndRequiredTime() {
		return endRequiredTime;
	}

	public void setEndRequiredTime(Date endRequiredTime) {
		this.endRequiredTime = endRequiredTime;
	}
	
	public String getFlag() {
		return flag;
	}
	
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public int getStartOrderStatus() {
		return startOrderStatus;
	}
	
	public void setStartOrderStatus(int startOrderStatus) {
		this.startOrderStatus = startOrderStatus;
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
	public String getCheckRemarks() {
		return checkRemarks;
	}
	public void setCheckRemarks(String checkRemarks) {
		this.checkRemarks = checkRemarks;
	}

	public Integer getInBatchNo() {
		return inBatchNo;
	}

	public void setInBatchNo(Integer inBatchNo) {
		this.inBatchNo = inBatchNo;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public Date getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	public Date getBeginEnterTime() {
		return beginEnterTime;
	}
	public void setBeginEnterTime(Date beginEnterTime) {
		this.beginEnterTime = beginEnterTime;
	}
	public Date getEndEnterTime() {
		return endEnterTime;
	}
	public void setEndEnterTime(Date endEnterTime) {
		this.endEnterTime = endEnterTime;
	}
	
}