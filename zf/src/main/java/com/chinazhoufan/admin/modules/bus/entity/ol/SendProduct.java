/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 发货货品Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class SendProduct extends DataEntity<SendProduct> {
	
	private static final long serialVersionUID = 1L;
	private SendOrder sendOrder;		// 发货单
	private SendProduce sendProduce;	// 发货产品
	private Product product;			// 货品
	private Wareplace outWareplace;		// 出库货位
	
	
	public SendProduct() {
		super();
	}

	public SendProduct(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="发货单ID长度必须介于 1 和 64 之间")
	public SendOrder getSendOrder() {
		return sendOrder;
	}

	public void setSendOrder(SendOrder sendOrder) {
		this.sendOrder = sendOrder;
	}
	
	@Length(min=1, max=64, message="发货产品ID长度必须介于 1 和 64 之间")
	public SendProduce getSendProduce() {
		return sendProduce;
	}

	public void setSendProduce(SendProduce sendProduce) {
		this.sendProduce = sendProduce;
	}
	
	@Length(min=1, max=64, message="货品ID长度必须介于 1 和 64 之间")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	@Length(min=1, max=64, message="出库货位长度必须介于 1 和 64 之间")
	public Wareplace getOutWareplace() {
		return outWareplace;
	}

	public void setOutWareplace(Wareplace outWareplace) {
		this.outWareplace = outWareplace;
	}
	
}