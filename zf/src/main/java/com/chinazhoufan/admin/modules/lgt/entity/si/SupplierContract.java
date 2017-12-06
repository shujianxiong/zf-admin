/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.si;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bas.entity.FileLibrary;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;

/**
 * 供应商合同Entity
 * @author liut
 * @version 2016-04-29
 */
public class SupplierContract extends DataEntity<SupplierContract> {
	
	private static final long serialVersionUID = 1L;
	private Supplier supplier;				// 供应商ID
	private PurchaseOrder purchaseOrder;	// 采购单ID
	private FileLibrary fileLibrary;		// 合同文件文件库
	private String name;   					// 合同文件名称集合,比如a
	private String type;					// 合同类型
	private String contractNo;				// 合同编号
	private Date effectStartTime;			// 生效时间
	private Date effectEndTime;				// 失效时间
	
	
	private Date beginRequiredTime;			// 失效开始时间
	private Date endRequiredTime;			// 失效结束时间

	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_BATCHNO = "lgt_si_supplier_contract_contractNo";//合同编码自动生成的业务编码
	
	// 供应商合同类型 lgt_si_supplier_contract_type
	public static final String TYPE_INTENTION		= "1";	// 意向合同
	public static final String TYPE_COOPERATION		= "2";	// 合作战略合同
	public static final String TYPE_PURCHASE		= "3";	// 单批次采购合同
	
	//传递参数字段
	private String fileUrl;//用于存放文件上传成功后返回的key，即文件地址
	
	
	public SupplierContract() {
		super();
	}

	public SupplierContract(String id){
		super(id);
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}

	public FileLibrary getFileLibrary() {
		return fileLibrary;
	}

	public void setFileLibrary(FileLibrary fileLibrary) {
		this.fileLibrary = fileLibrary;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public Date getEffectStartTime() {
		return effectStartTime;
	}

	public void setEffectStartTime(Date effectStartTime) {
		this.effectStartTime = effectStartTime;
	}

	public Date getEffectEndTime() {
		return effectEndTime;
	}

	public void setEffectEndTime(Date effectEndTime) {
		this.effectEndTime = effectEndTime;
	}

	public Date getBeginRequiredTime() {
		return beginRequiredTime;
	}

	public void setBeginRequiredTime(Date beginRequiredTime) {
		this.beginRequiredTime = beginRequiredTime;
	}

	public Date getEndRequiredTime() {
		return endRequiredTime;
	}

	public void setEndRequiredTime(Date endRequiredTime) {
		this.endRequiredTime = endRequiredTime;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	
	
}