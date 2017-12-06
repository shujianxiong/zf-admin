/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.dp;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 调货任务Entity
 * @author 刘晓东
 * @version 2015-10-20
 */
public class DispatchMission extends BasMission<DispatchMission> {
	
	private static final long serialVersionUID = 1L;
	private String batchNo;				//调货任务批次编号
	private String reasonType;			// 调货原因类型（补货/售出）
	private String missionStatus;		// 任务状态（新建/ 已确认/执行中,已完成）
	private Warehouse inWarehouse;		// 调入仓库
	private User inUser;				// 接收责任人
	private Warehouse outWarehouse;		// 调出仓库
	private User outUser;				// 调出责任人
	private List<DispatchProduce> dispatchProduceList = Lists.newArrayList();;// 调货产品
	private List<DispatchOrder> dispatchOrderList = Lists.newArrayList();;//调货单
	private List<DispatchProduct> dispatchProductList = Lists.newArrayList();//货品信息
	
	private DispatchOrder dispatchOrder;//调货单信息
	private Wareplace wareplace;		// 货位编号
	//调货原因类型
	public static final String REASON_TYPE_ONE = "1";//补货
	public static final String REASON_TYPE_TWO = "2";//售出
	//调货任务状态
	public static final String MISSION_WAITCONFIRMED = "1";//新建
	public static final String MISSION_WAITCALLOUT = "2";//已确认
	public static final String MISSION_WAITCALLIN = "3";//执行中
	public static final String MISSION_WAITCAFOUR = "4";//已完成
	
	
	public DispatchMission() {
		super();
	}

	public DispatchMission(String id){
		super(id);
	}
	public DispatchOrder getDispatchOrder() {
		return dispatchOrder;
	}

	public void setDispatchOrder(DispatchOrder dispatchOrder) {
		this.dispatchOrder = dispatchOrder;
	}
	
	public Wareplace getWareplace() {
		return wareplace;
	}

	public void setWareplace(Wareplace wareplace) {
		this.wareplace = wareplace;
	}

	@Length(min=1, max=2, message="调货原因类型（补货/售出）长度必须介于 1 和 2 之间")
	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}
	
	@Length(min=1, max=2, message="调货任务状态（新建/完成）长度必须介于 1 和 2 之间")
	public String getMissionStatus() {
		return missionStatus;
	}

	public void setMissionStatus(String missionStatus) {
		this.missionStatus = missionStatus;
	}
	
	
	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}


	public Warehouse getInWarehouse() {
		return inWarehouse;
	}

	public void setInWarehouse(Warehouse inWarehouse) {
		this.inWarehouse = inWarehouse;
	}

	public User getInUser() {
		return inUser;
	}

	public void setInUser(User inUser) {
		this.inUser = inUser;
	}
	
	public Warehouse getOutWarehouse() {
		return outWarehouse;
	}

	public void setOutWarehouse(Warehouse outWarehouse) {
		this.outWarehouse = outWarehouse;
	}

	public User getOutUser() {
		return outUser;
	}

	public void setOutUser(User outUser) {
		this.outUser = outUser;
	}

	public List<DispatchProduce> getDispatchProduceList() {
		return dispatchProduceList;
	}

	public void setDispatchProduceList(List<DispatchProduce> dispatchProduceList) {
		this.dispatchProduceList = dispatchProduceList;
	}
	
	public List<DispatchProduct> getDispatchProductList() {
		return dispatchProductList;
	}

	public void setDispatchProductList(List<DispatchProduct> dispatchProductList) {
		this.dispatchProductList = dispatchProductList;
	}

	public List<DispatchOrder> getDispatchOrderList() {
		return dispatchOrderList;
	}

	public void setDispatchOrderList(List<DispatchOrder> dispatchOrderList) {
		this.dispatchOrderList = dispatchOrderList;
	}

}