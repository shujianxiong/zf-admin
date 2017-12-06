package com.chinazhoufan.admin.modules.msg.service.uw.aop;

import java.math.BigDecimal;

import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;

/**
 * 警报监控vo
 * @author chenshi
 * 
 *  所有需要报警监控的地方需要返回该对象(参数名必须和切入点指定的返回值一致)
 *
 */
public class WarningVO implements java.io.Serializable{
	
	private WhProduce whProduce = null;	//异常检测必须参数	
	
	private String productCode;	//货品编码 code		克重异常必须参数
	private BigDecimal weight;	//货品当前重量		克重异常必须参数
	
	private String warningCategory; //报警类别	
	private String warningType;	// 报警类型

	public WarningVO() {}

	
	public WarningVO(WhProduce whProduce) {
		this.whProduce = whProduce;
	}

	public WarningVO(WhProduce whProduce, String warningCategory, String warningType) {
		this.whProduce = whProduce;
		this.warningCategory = warningCategory;
		this.warningType = warningType;
	}

	public WhProduce getWhProduce() {
		return whProduce;
	}

	public void setWhProduce(WhProduce whProduce) {
		this.whProduce = whProduce;
	}

	public String getWarningCategory() {
		return warningCategory;
	}

	public void setWarningCategory(String warningCategory) {
		this.warningCategory = warningCategory;
	}

	public String getWarningType() {
		return warningType;
	}

	public void setWarningType(String warningType) {
		this.warningType = warningType;
	}


	public String getProductCode() {
		return productCode;
	}


	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}


	public BigDecimal getWeight() {
		return weight;
	}


	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}
}
