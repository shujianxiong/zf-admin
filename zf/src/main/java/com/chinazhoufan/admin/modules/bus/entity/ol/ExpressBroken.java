/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 快递包裹损坏记录Entity
 * @author 张金俊
 * @version 2017-08-14
 */
public class ExpressBroken extends DataEntity<ExpressBroken> {
	
	private static final long serialVersionUID = 1L;
	private ReturnOrder returnOrder;		// 退货单
	private String outsideBrokenType;		// 包裹损坏类型
	private String outsideBrokenPhotos;		// 包裹损坏照片
	private String insideBrokenType;		// 内包装损坏类型
	private String insideBrokenPhotos;		// 内包装损坏照片
	private BigDecimal insideBrokenPrice;	// 内包装损坏金额
	
	/******************************************** 自定义常量  *********************************************/
	// 包裹损坏类型 bus_ol_express_broken_outsideBrokenType
	public static final String OUT_BT_LIGHT	= "1";	// 轻微
	// 内包装损坏类型 bus_ol_express_broken_insideBrokenType
	public static final String IN_BT_LIGHT	= "1";	// 轻微
	
	
	// 构造
	public ExpressBroken() {
		super();
	}

	public ExpressBroken(String id){
		super(id);
	}

	
	// 方法
	@Length(min=1, max=64, message="退货单ID长度必须介于 1 和 64 之间")
	public ReturnOrder getReturnOrder() {
		return returnOrder;
	}

	public void setReturnOrder(ReturnOrder returnOrder) {
		this.returnOrder = returnOrder;
	}
	
	@Length(min=0, max=2, message="包裹损坏类型长度必须介于 0 和 2 之间")
	public String getOutsideBrokenType() {
		return outsideBrokenType;
	}

	public void setOutsideBrokenType(String outsideBrokenType) {
		this.outsideBrokenType = outsideBrokenType;
	}
	
	@Length(min=0, max=2000, message="包裹损坏照片长度必须介于 0 和 2000 之间")
	public String getOutsideBrokenPhotos() {
		return outsideBrokenPhotos;
	}

	public void setOutsideBrokenPhotos(String outsideBrokenPhotos) {
		this.outsideBrokenPhotos = outsideBrokenPhotos;
	}
	
	@Length(min=0, max=2, message="内包装损坏类型长度必须介于 0 和 2 之间")
	public String getInsideBrokenType() {
		return insideBrokenType;
	}

	public void setInsideBrokenType(String insideBrokenType) {
		this.insideBrokenType = insideBrokenType;
	}
	
	@Length(min=0, max=2000, message="内包装损坏照片长度必须介于 0 和 2000 之间")
	public String getInsideBrokenPhotos() {
		return insideBrokenPhotos;
	}

	public void setInsideBrokenPhotos(String insideBrokenPhotos) {
		this.insideBrokenPhotos = insideBrokenPhotos;
	}
	
	public BigDecimal getInsideBrokenPrice() {
		return insideBrokenPrice;
	}

	public void setInsideBrokenPrice(BigDecimal insideBrokenPrice) {
		this.insideBrokenPrice = insideBrokenPrice;
	}
	
}