/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.po;

import java.math.BigDecimal;
import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 采购货品表Entity
 * @author 张金俊
 * @version 2015-11-02
 */
public class PurchaseProduct extends DataEntity<PurchaseProduct> {
	
	private static final long serialVersionUID = 1L;
	private PurchaseProduce purchaseProduce;		// 采购产品记录
	private Product product;						// 货品
	private String supplierBatchNo;					// 供应商批次编号
	private String factoryCode;						// 货品原厂编码
	private String certificateNo;					// 货品证书编号
	private Wareplace wareplace;					// 存放货位
	private BigDecimal weight;						// 货品克重
	private String scanCode;                        // 货品电子码
	private BigDecimal pricePurchase;               // 货品采购价
	private String regularFlag;						// 合格标记
	private Integer inBatchNo;                      // 入库批次编号
	private String photo;                      // 货品图片
	private Date enterTime;
	private String enterPerson ;
	
	public PurchaseProduct() {
		super();
	}

	public PurchaseProduct(String id){
		super(id);
	}

	
	//@Length(min=1, max=64, message="采购产品记录ID长度必须介于 1 和 64 之间")
	public PurchaseProduce getPurchaseProduce() {
		return purchaseProduce;
	}

	public void setPurchaseProduce(PurchaseProduce purchaseProduce) {
		this.purchaseProduce = purchaseProduce;
	}
	
	//@Length(min=1, max=64, message="货品ID长度必须介于 1 和 64 之间")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getSupplierBatchNo() {
		return supplierBatchNo;
	}

	public void setSupplierBatchNo(String supplierBatchNo) {
		this.supplierBatchNo = supplierBatchNo;
	}

	public String getFactoryCode() {
		return factoryCode;
	}

	public void setFactoryCode(String factoryCode) {
		this.factoryCode = factoryCode;
	}

	public String getCertificateNo() {
		return certificateNo;
	}

	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}

	public Wareplace getWareplace() {
		return wareplace;
	}

	public void setWareplace(Wareplace wareplace) {
		this.wareplace = wareplace;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}

	public String getScanCode() {
		return scanCode;
	}

	public void setScanCode(String scanCode) {
		this.scanCode = scanCode;
	}

	public BigDecimal getPricePurchase() {
		return pricePurchase;
	}

	public void setPricePurchase(BigDecimal pricePurchase) {
		this.pricePurchase = pricePurchase;
	}

	public String getRegularFlag() {
		return regularFlag;
	}

	public void setRegularFlag(String regularFlag) {
		this.regularFlag = regularFlag;
	}

	public Integer getInBatchNo() {
		return inBatchNo;
	}

	public void setInBatchNo(Integer inBatchNo) {
		this.inBatchNo = inBatchNo;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Date getEnterTime() {
		return enterTime;
	}

	public void setEnterTime(Date enterTime) {
		this.enterTime = enterTime;
	}

	public String getEnterPerson() {
		return enterPerson;
	}

	public void setEnterPerson(String enterPerson) {
		this.enterPerson = enterPerson;
	}
	
}