/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 货品质检单管理Entity
 * @author 刘晓东
 * @version 2015-10-13
 */
public class QualitycheckDetail extends DataEntity<QualitycheckDetail> {
	
	private static final long serialVersionUID = 1L;
	private Product product;		// 货品
	private QualitycheckOrder qualitycheckOrder;		// 质检单ID 父类
	private float weightOriginal;		// 货品原重数据
	private float weightCheck;		// 货品称重数据
	private String weightResult;		// 货品称重结果
	private String surfaceCheck;		// 货品质检外观
	private String surfaceCheckUrls;		// 货品外观质检照片urls
	private String codeOriginal;		// 原裸石编码
	private String codeCheck;		// 核对裸石编码
	private String codeResult;		// 裸石编码核对结果
	private String qcVoucher;		// 质检凭证
	private String qcResult;		// 质检结果
	private float lossEvaluation;		// 损耗估算
	
	public QualitycheckDetail() {
		super();
	}

	public QualitycheckDetail(String id){
		super(id);
	}

	public QualitycheckDetail(QualitycheckOrder qualitycheckOrder){
		this.qualitycheckOrder = qualitycheckOrder;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public QualitycheckOrder getQualitycheckOrder() {
		return qualitycheckOrder;
	}

	public void setQualitycheckOrder(QualitycheckOrder qualitycheckOrder) {
		this.qualitycheckOrder = qualitycheckOrder;
	}
	
	public float getWeightOriginal() {
		return weightOriginal;
	}

	public void setWeightOriginal(float weightOriginal) {
		this.weightOriginal = weightOriginal;
	}
	
	public float getWeightCheck() {
		return weightCheck;
	}

	public void setWeightCheck(float weightCheck) {
		this.weightCheck = weightCheck;
	}
	
	public String getWeightResult() {
		return weightResult;
	}

	public void setWeightResult(String weightResult) {
		this.weightResult = weightResult;
	}
	
	public String getSurfaceCheck() {
		return surfaceCheck;
	}

	public void setSurfaceCheck(String surfaceCheck) {
		this.surfaceCheck = surfaceCheck;
	}
	
	public String getSurfaceCheckUrls() {
		return surfaceCheckUrls;
	}

	public void setSurfaceCheckUrls(String surfaceCheckUrls) {
		this.surfaceCheckUrls = surfaceCheckUrls;
	}

	public String getCodeOriginal() {
		return codeOriginal;
	}

	public void setCodeOriginal(String codeOriginal) {
		this.codeOriginal = codeOriginal;
	}
	
	public String getCodeCheck() {
		return codeCheck;
	}

	public void setCodeCheck(String codeCheck) {
		this.codeCheck = codeCheck;
	}
	
	public String getCodeResult() {
		return codeResult;
	}

	public void setCodeResult(String codeResult) {
		this.codeResult = codeResult;
	}
	
	public String getQcVoucher() {
		return qcVoucher;
	}

	public void setQcVoucher(String qcVoucher) {
		this.qcVoucher = qcVoucher;
	}
	
	public String getQcResult() {
		return qcResult;
	}

	public void setQcResult(String qcResult) {
		this.qcResult = qcResult;
	}
	
	public float getLossEvaluation() {
		return lossEvaluation;
	}

	public void setLossEvaluation(float lossEvaluation) {
		this.lossEvaluation = lossEvaluation;
	}
	
}