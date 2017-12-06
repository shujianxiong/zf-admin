/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.as;

import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

import java.math.BigDecimal;

/**
 * 质检工单货品表Entity
 * @author 舒剑雄
 * @version 2017-10-13
 */
public class QualityWorkordProduct extends DataEntity<QualityWorkordProduct> {
	
	private static final long serialVersionUID = 1L;
	private String workOrderId;		// 退货单ID
	private String returnProduceId;		// 退货产品ID
	private Product product;				// 货品
	private String damageType;		// 损坏类型
	private BigDecimal decMoney;		// 扣减金额
	private String responsibilityType;		// 责任人类型
	private String problemDescription; //损坏类型描述
	/************************************自定义变量*******************************************/
	private BigDecimal priceSrc;			// 产品销售价

	private Boolean readOnly;			// 前台损坏金额禁止输入

	private Integer produceNormal;			// 产品正常库存
	// 退货质检货品损坏类型 bus_or_repair_order_breakdownType
	public static final String Dt_1	= "1";	// 轻微损坏
	public static final String Dt_2	= "2";	// 重度损坏扣款
	public static final String Dt_3	= "3";	// 重度损坏换新
	public static final String Dt_4	= "4";	// 正常
	public static final String Dt_5	= "5";	// 货品遗失

	// 退货质检货品损坏责任人类型 bus_ol_return_product_responsibilityType
	public static final String RT_MEMBER		= "M";	// 会员责任
	public static final String RT_COMPANY		= "C";	// 我方责任
	public static final String RT_EXPRESS		= "E";	// 快递责任
	public QualityWorkordProduct() {
		super();
	}

	public QualityWorkordProduct(String id){
		super(id);
	}

	@Length(min=1, max=64, message="退货单ID长度必须介于 1 和 64 之间")
	public String getWorkOrderId() {
		return workOrderId;
	}

	public void setWorkOrderId(String workOrderId) {
		this.workOrderId = workOrderId;
	}
	
	@Length(min=1, max=64, message="退货产品ID长度必须介于 1 和 64 之间")
	public String getReturnProduceId() {
		return returnProduceId;
	}

	public void setReturnProduceId(String returnProduceId) {
		this.returnProduceId = returnProduceId;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@Length(min=0, max=2, message="损坏类型长度必须介于 0 和 2 之间")
	public String getDamageType() {
		return damageType;
	}

	public void setDamageType(String damageType) {
		this.damageType = damageType;
	}
	
	public BigDecimal getDecMoney() {
		return decMoney;
	}

	public void setDecMoney(BigDecimal decMoney) {
		this.decMoney = decMoney;
	}
	
	@Length(min=0, max=2, message="责任人类型长度必须介于 0 和 2 之间")
	public String getResponsibilityType() {
		return responsibilityType;
	}

	public void setResponsibilityType(String responsibilityType) {
		this.responsibilityType = responsibilityType;
	}

	public BigDecimal getPriceSrc() {
		return priceSrc;
	}

	public void setPriceSrc(BigDecimal priceSrc) {
		this.priceSrc = priceSrc;
	}

	public Integer getProduceNormal() {
		return produceNormal;
	}

	public void setProduceNormal(Integer produceNormal) {
		this.produceNormal = produceNormal;
	}

	public String getProblemDescription() {
		return problemDescription;
	}

	public void setProblemDescription(String problemDescription) {
		this.problemDescription = problemDescription;
	}

	public Boolean getReadOnly() {
		return readOnly;
	}

	public void setReadOnly(Boolean readOnly) {
		this.readOnly = readOnly;
	}
}