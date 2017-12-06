/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.dp;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.google.common.collect.Lists;

/**
 * 调货产品Entity
 * @author 刘晓东
 * @version 2015-10-20
 */
public class DispatchProduce extends DataEntity<DispatchProduce> {
	
	private static final long serialVersionUID = 1L;
	private DispatchOrder dispatchOrder;			// 调货单Id
	private Produce produce;						// 产品ID
	private Integer planNum;							// 安排调货数量
	private Integer actualNum;							// 实际调货数量
	private String actualRemarks;					//实调说明
	private List<DispatchProduct> dispatchProductList = Lists.newArrayList();		// 子表列表

	
	//自定义参数
	private Warehouse outWarehouse;				// 调出仓库传值用
	public static final String STATUS_WAITCONFIRMED = "1";//调货中
	public static final String STATUS_WAITCALLOUT = "2";//调货完成
	
	//传值
	private WhProduce whProduce;				//库存数量
	
	
	public DispatchProduce() {
		super();
	}

	public DispatchProduce(String id){
		super(id);
	}
	
	@Length(min=1, max=64, message="调货单ID长度必须介于 1 和 64 之间")
	public DispatchOrder getDispatchOrder() {
		return dispatchOrder;
	}

	public void setDispatchOrder(DispatchOrder dispatchOrder) {
		this.dispatchOrder = dispatchOrder;
	}

	public String getActualRemarks() {
		return actualRemarks;
	}

	public void setActualRemarks(String actualRemarks) {
		this.actualRemarks = actualRemarks;
	}
	
	@Length(min=1, max=64, message="产品ID长度必须介于 1 和 64 之间")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	public Integer getPlanNum() {
		return planNum;
	}

	public void setPlanNum(Integer planNum) {
		this.planNum = planNum;
	}

	public Integer getActualNum() {
		return actualNum;
	}

	public void setActualNum(Integer actualNum) {
		this.actualNum = actualNum;
	}

	public List<DispatchProduct> getDispatchProductList() {
		return dispatchProductList;
	}

	public void setDispatchProductList(List<DispatchProduct> dispatchProductList) {
		this.dispatchProductList = dispatchProductList;
	}

	public Warehouse getOutWarehouse() {
		return outWarehouse;
	}

	public void setOutWarehouse(Warehouse outWarehouse) {
		this.outWarehouse = outWarehouse;
	}

	public WhProduce getWhProduce() {
		return whProduce;
	}

	public void setWhProduce(WhProduce whProduce) {
		this.whProduce = whProduce;
	}
	
}