/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 货品出入库记录Entity
 * @author 张金俊
 * @version 2015-11-09
 */
public class ProductWpIo extends DataEntity<ProductWpIo> {
	
	private static final long serialVersionUID = 1L;
	private Product product;			// 货品
	private String ioType;				// 操作类型（1:入库 	2:出库）
	private String ioReasonType;		// 操作原因类型（11:采购入库	21：体验出库）
	private Wareplace ioWareplace;		// 出入库货位
	private User ioHoldUser;			// 出入库持有人
	private String inType;				// 货品入库类型（正常：Warearea.TYPE_NORMAL	坏货：Warearea.TYPE_BROKEN）（lgt_ps_warearea_type）
	private String inStatus;			// 货品入库状态
	private User ioUser;				// 操作人
	private Date ioTime;				// 操作时间
	private String ioBusinessorderId;	// 来源业务单号
	
	private Supplier supplier;          // 来源供应商
	
	/********************************************************************************/
	/**操作类型 lgt_ps_product_wp_io_ioType*/
	public static final String IOTYPE_IN  = "1";		// 入库
	public static final String IOTYPE_OUT = "2";		// 出库
	
	/**操作原因类型 lgt_ps_product_wp_io_ioReasonType*/
	public static final String IOREASIONTYPE_IN_PURCHASE	= "11";		// 采购入库
	public static final String IOREASIONTYPE_IN_RETURN		= "12";		// 退货入库
	public static final String IOREASIONTYPE_IN_INVENTORY	= "13";		// 盘点入库
	public static final String IOREASIONTYPE_IN_DISPATCH	= "14";		// 调货入库
	public static final String IOREASIONTYPE_OUT_SALE		= "21";		// 销售出库
	public static final String IOREASIONTYPE_OUT_INVENTORY	= "22";		// 盘点出库
	public static final String IOREASIONTYPE_OUT_DISPATCH	= "23";		// 调货出库
	public static final String IOREASIONTYPE_OUT_REPAIR	= "24";			// 维修出库
	public static final String IOREASIONTYPE_OUT_REFUR	= "25";			// 翻新出库
	/** 货品入库后的状态 lgt_ps_product_status 参见Product.java*/
	public static final String INSTATUS_NORMAL	= "1";  // 正常（在库）
	public static final String INSTATUS_LOCKED 	= "2";	// 锁定（维修、调拨、出入库等操作可能导致货品锁定。锁定的货品不支持新的体验和销售。锁定的货品在锁定库存中，解锁后纳入正常库存，即解锁后系统锁定库存-1、正常库存+1）
	public static final String INSTATUS_SOLD    = "4";	// 已售出（售出的货品保留货品记录，但是不占库存，即库存数量不包含已售出的货品）
	public static final String INSTATUS_REMOVED	= "5";	// 已移除（货品遗失、彻底损坏等状况下，从系统移除。移除的货品保留货品记录，但是不占库存，即库存数量不包含已移除的货品）

	// 货品入库类型 lgt_ps_product_wp_io_inType
	public static final String INTYPE_NORMAL			= "1";	// 正常
	public static final String INTYPE_BROKEN_PURCHASE	= "2";	// 采购坏货
	public static final String INTYPE_BROKEN_STOCK		= "3";	// 库存坏货（需承担维修费用的库存坏货或用户退回、返修坏货）
	
	
	
	public ProductWpIo() {
		super();
	}

	public ProductWpIo(String id){
		super(id);
	}

	
	
	@NotNull
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public String getIoType() {
		return ioType;
	}

	public void setIoType(String ioType) {
		this.ioType = ioType;
	}
	

	@Length(min=0, max=2, message="出入库原因类型长度必须介于 0 和 2 之间")
	public String getIoReasonType() {
		return ioReasonType;
	}

	public void setIoReasonType(String ioReasonType) {
		this.ioReasonType = ioReasonType;
	}
	
	public String getInType() {
		return inType;
	}

	public void setInType(String inType) {
		this.inType = inType;
	}

	public String getInStatus() {
		return inStatus;
	}

	public void setInStatus(String inStatus) {
		this.inStatus = inStatus;
	}

	public Wareplace getIoWareplace() {
		return ioWareplace;
	}

	public void setIoWareplace(Wareplace ioWareplace) {
		this.ioWareplace = ioWareplace;
	}
	
	public User getIoHoldUser() {
		return ioHoldUser;
	}

	public void setIoHoldUser(User ioHoldUser) {
		this.ioHoldUser = ioHoldUser;
	}
	
	public User getIoUser() {
		return ioUser;
	}

	public void setIoUser(User ioUser) {
		this.ioUser = ioUser;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getIoTime() {
		return ioTime;
	}

	public void setIoTime(Date ioTime) {
		this.ioTime = ioTime;
	}
	
	public String getIoBusinessorderId() {
		return ioBusinessorderId;
	}

	public void setIoBusinessorderId(String ioBusinessorderId) {
		this.ioBusinessorderId = ioBusinessorderId;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	
}