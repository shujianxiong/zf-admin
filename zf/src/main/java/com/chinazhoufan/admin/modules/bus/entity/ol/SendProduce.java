/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.google.common.collect.Lists;

/**
 * 发货产品Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class SendProduce extends DataEntity<SendProduce> {
	
	private static final long serialVersionUID = 1L;
	private SendOrder sendOrder;	// 发货单
	private String orderProduceId;	// 来源订单产品ID（根据发货单的来源订单类型的不同，订单产品ID可能关联体验产品表ID或购买产品表ID）
	private Produce produce;		// 产品
	private Integer num;			// 数量

	/***************************************** 自定义查询条件属性  ******************************************/
	private List<Product> productList = Lists.newArrayList();	// 所关联发货货品集合
	
	
	
	public SendProduce() {
		super();
	}

	public SendProduce(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="发货单ID长度必须介于 1 和 64 之间")
	public SendOrder getSendOrder() {
		return sendOrder;
	}

	public void setSendOrder(SendOrder sendOrder) {
		this.sendOrder = sendOrder;
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

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}
	
	
	
}