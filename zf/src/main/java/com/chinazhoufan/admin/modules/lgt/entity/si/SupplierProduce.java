/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.si;

import java.math.BigDecimal;
import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 供应商产品表Entity
 * @author liut
 * @version 2016-11-21
 */
public class SupplierProduce extends DataEntity<SupplierProduce> {
	
	private static final long serialVersionUID = 1L;
	private Supplier supplier;						// 供应商ID
	private Goods goods;							// 商品ID
	private Produce produce;						// 产品ID
	
	// 供应商商品相关属性
	private String goodsFactoryCode; 				// 商品原厂编码
	private BigDecimal workFee;						// 工费
	private BigDecimal templetFee;					// 起版费
	private String electrolyticGoldCrafts; 			// 电金工艺
	private String electrolyticGoldColour; 			// 电金颜色
	private BigDecimal electrolyticGoldThickness;	// 电金厚度
	private BigDecimal electrolyticGoldPrice; 		// 电金价格
	// 供应商产品相关属性
	private BigDecimal inlayFee;					// 镶口费
	private Integer inlayNum;       				// 镶口数
	private BigDecimal goldPrice;					// 金价
	private BigDecimal lossFee;						// 损耗
	private BigDecimal goldWeightMin;   			// 金重下限
	private BigDecimal goldWeightMax;   			// 金重上限
	private BigDecimal mainStoneWeight;				// 主石重量
	private BigDecimal mainStonePrice;				// 主石价格
	private BigDecimal subsidiaryStoneWeight;		// 辅石重量
	private BigDecimal subsidiaryStonePrice;		// 辅石价格
	private BigDecimal pricePurchaseMin;			// 采购价下限( = 镶口费*镶口数 + 金价*损耗 + 金价*金重下限 + 主石价格 + 辅石价格)
	private BigDecimal pricePurchaseMax;			// 采购价上限( = 镶口费*镶口数 + 金价*损耗 + 金价*金重上限 + 主石价格 + 辅石价格)
	
	//--------便于传参
	private List<SupplierProduce> spList; 			// 产品供货价信息

	/******************************************** 自定义常量  *********************************************/
	// 供应商产品电金工艺 lgt_si_supplier_produce_egCrafts
	// 供应商产品电金颜色 lgt_si_supplier_produce_egColour
	
	
	public SupplierProduce() {
		super();
	}

	public SupplierProduce(String id){
		super(id);
	}
	
	
	// method
	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	public String getGoodsFactoryCode() {
		return goodsFactoryCode;
	}

	public void setGoodsFactoryCode(String goodsFactoryCode) {
		this.goodsFactoryCode = goodsFactoryCode;
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

	public BigDecimal getPricePurchaseMin() {
		return pricePurchaseMin;
	}

	public void setPricePurchaseMin(BigDecimal pricePurchaseMin) {
		this.pricePurchaseMin = pricePurchaseMin;
	}

	public BigDecimal getPricePurchaseMax() {
		return pricePurchaseMax;
	}

	public void setPricePurchaseMax(BigDecimal pricePurchaseMax) {
		this.pricePurchaseMax = pricePurchaseMax;
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

	public List<SupplierProduce> getSpList() {
		return spList;
	}

	public void setSpList(List<SupplierProduce> spList) {
		this.spList = spList;
	}

	public Integer getInlayNum() {
		return inlayNum;
	}

	public void setInlayNum(Integer inlayNum) {
		this.inlayNum = inlayNum;
	}

	public BigDecimal getGoldWeightMin() {
		return goldWeightMin;
	}

	public void setGoldWeightMin(BigDecimal goldWeightMin) {
		this.goldWeightMin = goldWeightMin;
	}

	public BigDecimal getGoldWeightMax() {
		return goldWeightMax;
	}

	public void setGoldWeightMax(BigDecimal goldWeightMax) {
		this.goldWeightMax = goldWeightMax;
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
	
}