/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.dp;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 调货货品Entity
 * @author 刘晓东
 * @version 2015-10-21
 */
public class DispatchProduct extends DataEntity<DispatchProduct> {
	
	private static final long serialVersionUID = 1L;
	private DispatchProduce dispatchProduce;		// 调货产品ID
	private Product product;						// 货品ID
	private String status;							// 调货状态（调货中，调货完成）
	private Wareplace outWareplace;					// 调出货位编号
	private Wareplace inWareplace;					// 调入货位编号
	private ProductWpIo productWpIoOut;				// 货品出库记录ID  lgt_ps_product_warehouse_io
	private QualitycheckOrder productCheckOrder;	// 货品质检记录IDlgt_ps_qualitycheck_record
	private ProductWpIo productWpIoIn;				// 货品入库记录IDlgt_ps_product_warehouse_io
	
	//调货状态
	public static final String STATUS_ING = "1";//调货中
	public static final String STATUS_END = "2";//调货完成
	
	
	public DispatchProduct() {
		super();
	}

	public DispatchProduct(String id){
		super(id);
	}

	public DispatchProduct(DispatchProduce dispatchProduce) {
		this.dispatchProduce = dispatchProduce;
	}
	
	@Length(min=1, max=64, message="调货产品ID长度必须介于 1 和 64 之间")
	public DispatchProduce getDispatchProduce() {
		return dispatchProduce;
	}

	public void setDispatchProduce(DispatchProduce dispatchProduce) {
		this.dispatchProduce = dispatchProduce;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Wareplace getOutWareplace() {
		return outWareplace;
	}

	public void setOutWareplace(Wareplace outWareplace) {
		this.outWareplace = outWareplace;
	}

	public Wareplace getInWareplace() {
		return inWareplace;
	}

	public void setInWareplace(Wareplace inWareplace) {
		this.inWareplace = inWareplace;
	}

	@Length(min=1, max=2, message="调货状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public ProductWpIo getProductWpIoOut() {
		return productWpIoOut;
	}

	public void setProductWpIoOut(ProductWpIo productWpIoOut) {
		this.productWpIoOut = productWpIoOut;
	}

	public QualitycheckOrder getProductCheckOrder() {
		return productCheckOrder;
	}

	public void setProductCheckOrder(QualitycheckOrder productCheckOrder) {
		this.productCheckOrder = productCheckOrder;
	}

	public ProductWpIo getProductWpIoIn() {
		return productWpIoIn;
	}

	public void setProductWpIoIn(ProductWpIo productWpIoIn) {
		this.productWpIoIn = productWpIoIn;
	}

}