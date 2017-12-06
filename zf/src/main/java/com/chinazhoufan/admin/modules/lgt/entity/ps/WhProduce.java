/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;


import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.google.common.collect.Lists;

/**
 * 仓库产品库存表Entity
 * @author 刘晓东
 * @version 2016-03-17
 */
public class WhProduce extends DataEntity<WhProduce> {
	
	private static final long serialVersionUID = 1L;
	private Warehouse warehouse;			// 仓库ID
	private Produce produce;				// 产品ID
	private Integer stockNormal;			// 正常库存
	private Integer stockLock;				// 锁定库存
	private Integer stockDebt;				// 负债库存
	private String motinorStatus;			// 监控状态
	private Integer stockStandard;			// 标准库存
	private Integer stockSafe;				// 安全库存
	private Integer stockWarning;			// 警戒库存
	private List<Produce> produceLists = Lists.newArrayList();
	
	/***************************************************************************/
	//监控状态（0：未启用	1：监控中		2：已失效）
	public static final String MOTINORSTATUS_UNUSED 	= "0";	// 未启用
	public static final String MOTINORSTATUS_WORKING 	= "1";	// 监控中
	public static final String MOTINORSTATUS_EXPIRE 	= "2";	// 已失效
	
	
	/**Constructor**/
	public WhProduce() {
		super();
	}

	public WhProduce(String id){
		super(id);
	}

	public WhProduce(Produce produce){
		this.produce = produce;
	}
	
	public WhProduce(Warehouse warehouse){
		this.warehouse = warehouse;
	}

	
	/**method**/
	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	public Integer getStockNormal() {
		return stockNormal;
	}

	public void setStockNormal(Integer stockNormal) {
		this.stockNormal = stockNormal;
	}

	public Integer getStockLock() {
		return stockLock;
	}

	public void setStockLock(Integer stockLock) {
		this.stockLock = stockLock;
	}

	public Integer getStockDebt() {
		return stockDebt;
	}

	public void setStockDebt(Integer stockDebt) {
		this.stockDebt = stockDebt;
	}

	public String getMotinorStatus() {
		return motinorStatus;
	}

	public void setMotinorStatus(String motinorStatus) {
		this.motinorStatus = motinorStatus;
	}

	public Integer getStockStandard() {
		return stockStandard;
	}

	public void setStockStandard(Integer stockStandard) {
		this.stockStandard = stockStandard;
	}

	public Integer getStockSafe() {
		return stockSafe;
	}

	public void setStockSafe(Integer stockSafe) {
		this.stockSafe = stockSafe;
	}

	public Integer getStockWarning() {
		return stockWarning;
	}

	public void setStockWarning(Integer stockWarning) {
		this.stockWarning = stockWarning;
	}

	public List<Produce> getProduceLists() {
		return produceLists;
	}

	public void setProduceLists(List<Produce> produceLists) {
		this.produceLists = produceLists;
	}
	
}