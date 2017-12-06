/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ip;

import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 盘点任务Entity
 * @author 张金俊
 * @version 2016-03-17
 */
public class InventoryMission extends DataEntity<InventoryMission> {
	
	private static final long serialVersionUID = 1L;
	private String batchNo;			// 盘点批次编号
	private Warehouse warehouse;	// 盘点仓库
	private String type;			// 盘点类型（日常/月度）
	private String style;			// 盘点方式（产品/位置）
	private String status;			// 盘点状态
	private Date startTime;			// 盘点起始时间
	private Date endTime;			// 盘点结束时间
	private String resultType;		// 盘点结果
	private List<InventoryRecord> inventoryRecordList = Lists.newArrayList();	// 盘点记录列表
	
	/****************************************/
	//盘点状态（1：新建	2：盘点中（已提交）	3：盘点完成）
	public static final String STATUS_NEW = "1";			// 新建
	public static final String STATUS_INVENTORYING = "2";	// 盘点中
	public static final String STATUS_FINISHED = "3";		// 盘点完成
	
	//盘点结果（1：正常	2：异常）
	public static final String RESULTTYPE_NORMAL = "1";		// 结果正常
	public static final String RESULTTYPE_EXCEPTION = "2";	// 结果异常
	
	
	
	public InventoryMission() {
		super();
	}

	public InventoryMission(String id){
		super(id);
	}

//	@Length(min=1, max=64, message="盘点批次编号长度必须介于 1 和 64 之间")
	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}
	
	@Length(min=1, max=64, message="盘点仓库ID长度必须介于 1 和 64 之间")
	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}
	
	@Length(min=1, max=2, message="盘点类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=2, message="盘点方式长度必须介于 1 和 2 之间")
	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}
	
//	@Length(min=1, max=2, message="盘点状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//	@NotNull(message="盘点起始时间不能为空")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
//	@Length(min=0, max=2, message="盘点结果长度必须介于 0 和 2 之间")
	public String getResultType() {
		return resultType;
	}

	public void setResultType(String resultType) {
		this.resultType = resultType;
	}

	public List<InventoryRecord> getInventoryRecordList() {
		return inventoryRecordList;
	}

	public void setInventoryRecordList(List<InventoryRecord> inventoryRecordList) {
		this.inventoryRecordList = inventoryRecordList;
	}
	
}