/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import com.google.common.collect.Lists;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

import java.util.List;

/**
 * 退货产品Entity
 * @author 张金俊
 * @version 2017-08-14
 */
public class ReturnProduce extends DataEntity<ReturnProduce> {
	
	private static final long serialVersionUID = 1L;
	private ReturnOrder returnOrder;	// 退货单
	private String orderProduceId;		// 来源订单产品ID
	private Produce produce;			// 产品
	private String produceFullName;   //产品全称
	private Integer num;				// 数量
	
	private List<ReturnProduct> returnProductList = Lists.newArrayList();
	
	public ReturnProduce() {
		super();
	}

	public ReturnProduce(String id){
		super(id);
	}

	
	
	@Length(min=1, max=64, message="退货单ID长度必须介于 1 和 64 之间")
	public ReturnOrder getReturnOrder() {
		return returnOrder;
	}

	public void setReturnOrder(ReturnOrder returnOrder) {
		this.returnOrder = returnOrder;
	}
	
	@Length(min=1, max=64, message="来源订单产品ID长度必须介于 1 和 64 之间")
	public String getOrderProduceId() {
		return orderProduceId;
	}

	public void setOrderProduceId(String orderProduceId) {
		this.orderProduceId = orderProduceId;
	}
	
	@Length(min=1, max=64, message="产品ID长度必须介于 1 和 64 之间")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	@NotNull(message="数量不能为空")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getProduceFullName() {
		return produceFullName;
	}

	public void setProduceFullName(String produceFullName) {
		this.produceFullName = produceFullName;
	}

	public List<ReturnProduct> getReturnProductList() {
		return returnProductList;
	}

	public void setReturnProductList(List<ReturnProduct> returnProductList) {
		this.returnProductList = returnProductList;
	}
}