/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.po;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 采购任务Entity
 * @author 陈适
 * @version 2016-03-31
 */
public class PurchaseMission extends DataEntity<PurchaseMission> {
	
	private static final long serialVersionUID = 1L;
	private String batchNo;			// 批次编号
	private String missionStatus;	// 任务状态
	
	// 2016-12-2  添加审核信息
	private User checkBy;//审核人
	private Date checkTime;//审核时间
	private String checkRemarks;//审核备注
	
	private List<PurchaseMissionDetail> detailList 	= Lists.newArrayList();	// 采购任务产品
	private List<PurchaseOrder> 		orderList 	= Lists.newArrayList();	// 采购单
	
	/***==============查询条件 ===============**/
	private PurchaseOrder purchaseOrder;
	private int startMissionStatus;		// 起始任务状态（查询条件，查询出该状态及之后状态的任务）
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;			// 结束 创建时间
	private String  produceCode;				// 关联产品编码
	
	/**********************************************************************/
	// 采购任务状态 lgt_po_purchase_mission_missionStatus	新建（提交审批）》待审批（审批通过/拒绝）》已发布（分单）》采购中（确认完成）》采购完成
	public static final String MISSIONSTATUS_NEW 		= "1";	// 新建（待发布）
	public static final String MISSIONSTATUS_WAITCHECK  = "2";  // 待审批
	public static final String MISSIONSTATUS_SUBMIT 	= "3";	// 已发布（待分单）<分单操作后进入“采购中”状态，同时生成采购订单，采购订单进入“待接单（已提交）”状态>
	public static final String MISSIONSTATUS_PURCHASING = "4";	// 采购中（已提交）<采购执行>
	public static final String MISSIONSTATUS_FINISH 	= "5";	// 采购完成
	
	public static final String MISSIONSTATUS_CLOSE = "99";//审核不通过，采购任务关闭
	
	public static final String GENERATECODE_BATCHNO = "lgt_po_purchase_mission_batchNo";	//根据此字段获取采购批次编号生成规则
	
	
	
	/**Constructor*/
	public PurchaseMission() {}
	
	public PurchaseMission(String id){
		super(id);
	}

	public PurchaseMission(String batchNo, String missionStatus) {
		this.batchNo = batchNo;
		this.missionStatus = missionStatus;
	}



	@Length(min=1, max=64, message="批次编号长度必须介于 1 和 64 之间")
	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}
	
	@Length(min=1, max=2, message="任务状态长度必须介于 1 和 2 之间")
	public String getMissionStatus() {
		return missionStatus;
	}

	public void setMissionStatus(String missionStatus) {
		this.missionStatus = missionStatus;
	}
	
	public List<PurchaseMissionDetail> getDetailList() {
		return detailList;
	}
	
	public void setDetailList(List<PurchaseMissionDetail> detailList) {
		this.detailList = detailList;
	}

	public List<PurchaseOrder> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<PurchaseOrder> orderList) {
		this.orderList = orderList;
	}

	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}
	
	public int getStartMissionStatus() {
		return startMissionStatus;
	}

	public void setStartMissionStatus(int startMissionStatus) {
		this.startMissionStatus = startMissionStatus;
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

	public String getProduceCode() {
		return produceCode;
	}

	public void setProduceCode(String produceCode) {
		this.produceCode = produceCode;
	}
}