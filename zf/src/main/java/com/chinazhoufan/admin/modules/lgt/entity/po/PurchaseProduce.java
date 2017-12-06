/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.po;

import java.math.BigDecimal;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.google.common.collect.Lists;

/**
 * 采购产品Entity
 * @author 张金俊
 * @version 2015-10-16
 */
public class PurchaseProduce extends DataEntity<PurchaseProduce> {
	
	private static final long serialVersionUID = 1L;
	private PurchaseOrder purchaseOrder;	// 采购单
	private Produce produce;				// 产品
	private Integer requiredNum;			// 要求采购数量
//	private BigDecimal expectPrice;			// 预算采购价格<单个价钱>
	private Integer realityNum;				// 实际采购数量
	private BigDecimal realityPrice;		// 实际采购价格
	private Integer inNum;					// 合格入库数量
	private Integer backNum;				// 不合格退回数量
	
	private BigDecimal workFee;						// 工费
	private BigDecimal templetFee;					// 起版费
	private String electrolyticGoldCrafts; 			// 电金工艺
	private String electrolyticGoldColour; 			// 电金颜色
	private BigDecimal electrolyticGoldThickness;	// 电金厚度
	private BigDecimal electrolyticGoldPrice; 		// 电金价格
	
	private BigDecimal inlayFee;					// 镶口费
	private Integer    inlayNum;  					// 镶口数
	private BigDecimal goldPrice;					// 金价
	private BigDecimal lossFee;						// 损耗
	private BigDecimal goldWeight;					// 金重
	private BigDecimal mainStoneWeight;				// 主石重量
	private BigDecimal mainStonePrice;				// 主石价格
	private BigDecimal subsidiaryStoneWeight;		// 辅石重量
	private BigDecimal subsidiaryStonePrice;		// 辅石价格
	
	private List<PurchaseProduct> purchaseProductList = Lists.newArrayList();		// 采购货品列表
	
	private Supplier supplier; //临时对象
	private String flag;	//是否删除标识
	
	private String goodsFactoryCode;               //商品原厂编码， 临时暂存字段
	
	/******************************************** 自定义常量  *********************************************/
	// 供应商产品电金工艺 lgt_si_supplier_produce_egCrafts
	// 供应商产品电金颜色 lgt_si_supplier_produce_egColour
	
	
	
	
	/**Constructors*/
	public PurchaseProduce() {
		super();
	}

	public PurchaseProduce(String id){
		super(id);
	}

	public PurchaseProduce(PurchaseOrder purchaseOrder){
		this.purchaseOrder = purchaseOrder;
	}
	
	

	@NotNull(message="采购单不能为空")
	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}
	
	@NotNull(message="产品不能为空")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	@NotNull(message="要求采购数量不能为空")
	@Length(min=0, max=11, message="要求采购数量长度必须介于 0 和 11 之间")
	public Integer getRequiredNum() {
		return requiredNum;
	}

	public void setRequiredNum(Integer requiredNum) {
		this.requiredNum = requiredNum;
	}
	
	@Length(min=0, max=11, message="实际采购数量长度必须介于 0 和 11 之间")
	public Integer getRealityNum() {
		return realityNum;
	}

	public void setRealityNum(Integer realityNum) {
		this.realityNum = realityNum;
	}
	
	public BigDecimal getRealityPrice() {
		return realityPrice;
	}

	public void setRealityPrice(BigDecimal realityPrice) {
		this.realityPrice = realityPrice;
	}
	
	public List<PurchaseProduct> getPurchaseProductList() {
		return purchaseProductList;
	}

	public void setPurchaseProductList(List<PurchaseProduct> purchaseProductList) {
		this.purchaseProductList = purchaseProductList;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Integer getInNum() {
		return inNum;
	}

	public void setInNum(Integer inNum) {
		this.inNum = inNum;
	}

	public Integer getBackNum() {
		return backNum;
	}

	public void setBackNum(Integer backNum) {
		this.backNum = backNum;
	}

	public BigDecimal getGoldPrice() {
		return goldPrice;
	}

	public void setGoldPrice(BigDecimal goldPrice) {
		this.goldPrice = goldPrice;
	}

	public BigDecimal getLossFee() {
		return lossFee;
	}

	public void setLossFee(BigDecimal lossFee) {
		this.lossFee = lossFee;
	}

	public BigDecimal getGoldWeight() {
		return goldWeight;
	}

	public void setGoldWeight(BigDecimal goldWeight) {
		this.goldWeight = goldWeight;
	}

	public BigDecimal getMainStoneWeight() {
		return mainStoneWeight;
	}

	public void setMainStoneWeight(BigDecimal mainStoneWeight) {
		this.mainStoneWeight = mainStoneWeight;
	}

	public BigDecimal getMainStonePrice() {
		return mainStonePrice;
	}

	public void setMainStonePrice(BigDecimal mainStonePrice) {
		this.mainStonePrice = mainStonePrice;
	}

	public BigDecimal getSubsidiaryStoneWeight() {
		return subsidiaryStoneWeight;
	}

	public void setSubsidiaryStoneWeight(BigDecimal subsidiaryStoneWeight) {
		this.subsidiaryStoneWeight = subsidiaryStoneWeight;
	}

	public BigDecimal getSubsidiaryStonePrice() {
		return subsidiaryStonePrice;
	}

	public void setSubsidiaryStonePrice(BigDecimal subsidiaryStonePrice) {
		this.subsidiaryStonePrice = subsidiaryStonePrice;
	}

	public BigDecimal getWorkFee() {
		return workFee;
	}

	public void setWorkFee(BigDecimal workFee) {
		this.workFee = workFee;
	}

	public BigDecimal getInlayFee() {
		return inlayFee;
	}

	public void setInlayFee(BigDecimal inlayFee) {
		this.inlayFee = inlayFee;
	}

	public BigDecimal getTempletFee() {
		return templetFee;
	}

	public void setTempletFee(BigDecimal templetFee) {
		this.templetFee = templetFee;
	}

	public Integer getInlayNum() {
		return inlayNum;
	}

	public void setInlayNum(Integer inlayNum) {
		this.inlayNum = inlayNum;
	}

	public String getElectrolyticGoldCrafts() {
		return electrolyticGoldCrafts;
	}

	public void setElectrolyticGoldCrafts(String electrolyticGoldCrafts) {
		this.electrolyticGoldCrafts = electrolyticGoldCrafts;
	}

	public String getElectrolyticGoldColour() {
		return electrolyticGoldColour;
	}

	public void setElectrolyticGoldColour(String electrolyticGoldColour) {
		this.electrolyticGoldColour = electrolyticGoldColour;
	}

	public BigDecimal getElectrolyticGoldThickness() {
		return electrolyticGoldThickness;
	}

	public void setElectrolyticGoldThickness(BigDecimal electrolyticGoldThickness) {
		this.electrolyticGoldThickness = electrolyticGoldThickness;
	}

	public BigDecimal getElectrolyticGoldPrice() {
		return electrolyticGoldPrice;
	}

	public void setElectrolyticGoldPrice(BigDecimal electrolyticGoldPrice) {
		this.electrolyticGoldPrice = electrolyticGoldPrice;
	}

	public String getGoodsFactoryCode() {
		return goodsFactoryCode;
	}

	public void setGoodsFactoryCode(String goodsFactoryCode) {
		this.goodsFactoryCode = goodsFactoryCode;
	}

	
}