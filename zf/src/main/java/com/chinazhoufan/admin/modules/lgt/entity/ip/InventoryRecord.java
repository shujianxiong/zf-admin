/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ip;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 盘点记录Entity
 * @author 张金俊
 * @version 2016-03-17
 */
public class InventoryRecord extends DataEntity<InventoryRecord> {
	
	private static final long serialVersionUID = 1L;
	private InventoryMission inventoryMission;	// 盘点任务
	private User inventoryUser;					// 盘点人
	private String status;						// 盘点状态
	private Wareplace wareplace;				// 货位
	private Integer systemNum;					// 系统库存数量
	private Integer inventoryNum;				// 盘点库存数量
	private String resultType;					// 盘点结果
	private String inventoryRemarks;			// 盘点备注
	
	private List<Product> productList = Lists.newArrayList();	// 盘点记录列表
	
	/****************************************/
	//盘点状态（1：新建	2：盘点中（已提交）	3：盘点完成）
	public static final String STATUS_NEW = "1";			// 新建
	public static final String STATUS_INVENTORYING = "2";	// 盘点中
	public static final String STATUS_FINISHED = "3";		// 盘点完成
	
	//盘点结果（1：正常	2：盘点缺失	3：盘点多出）
	public static final String RESULTTYPE_NORMAL = "1";		// 正常
	public static final String RESULTTYPE_LESS = "2";		// 盘点缺失
	public static final String RESULTTYPE_MORE = "3";		// 盘点多出
	
	
	
	public InventoryRecord() {
		super();
	}

	public InventoryRecord(String id){
		super(id);
	}

	@Length(min=1, max=64, message="盘点任务ID长度必须介于 1 和 64 之间")
	public InventoryMission getInventoryMission() {
		return inventoryMission;
	}

	public void setInventoryMission(InventoryMission inventoryMission) {
		this.inventoryMission = inventoryMission;
	}
	
	@Length(min=1, max=64, message="盘点人长度必须介于 1 和 64 之间")
	public User getInventoryUser() {
		return inventoryUser;
	}

	public void setInventoryUser(User inventoryUser) {
		this.inventoryUser = inventoryUser;
	}
	
	@Length(min=1, max=2, message="盘点状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=64, message="货位ID长度必须介于 1 和 64 之间")
	public Wareplace getWareplace() {
		return wareplace;
	}

	public void setWareplace(Wareplace wareplace) {
		this.wareplace = wareplace;
	}
	
	@NotNull(message="系统库存数量不能为空")
	public Integer getSystemNum() {
		return systemNum;
	}

	public void setSystemNum(Integer systemNum) {
		this.systemNum = systemNum;
	}
	
	@NotNull(message="盘点库存数量不能为空")
	public Integer getInventoryNum() {
		return inventoryNum;
	}

	public void setInventoryNum(Integer inventoryNum) {
		this.inventoryNum = inventoryNum;
	}
	
	@Length(min=1, max=2, message="盘点结果长度必须介于 1 和 2 之间")
	public String getResultType() {
		return resultType;
	}

	public void setResultType(String resultType) {
		this.resultType = resultType;
	}
	
	@Length(min=0, max=255, message="盘点备注长度必须介于 0 和 255 之间")
	public String getInventoryRemarks() {
		return inventoryRemarks;
	}

	public void setInventoryRemarks(String inventoryRemarks) {
		this.inventoryRemarks = inventoryRemarks;
	}

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}
	
}