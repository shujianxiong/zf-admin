/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 产品变更记录Entity
 * @author 张金俊
 * @version 2017-07-11
 */
public class ProduceItem extends DataEntity<ProduceItem> {
	
	private static final long serialVersionUID = 1L;
	private Integer serialNo;				// 序列号
	private Produce produce;				// 产品
	private String srcType;					// 来源类型
	private String srcId;					// 来源ID
	private ProduceItem preItem;			// 原记录
	private String code;					// 产品编码
	private String propertyStr;				// 属性字符串
	private String propertySkuStr;			// SKU属性字符串
	private String factoryCode;				// 产品原厂编码
	private String name;					// 产品名称
	private String styleType;				// 风格类型
	private String status;					// 产品状态
	private BigDecimal standardWeight;		// 标准克重
	
	private BigDecimal pricePurchase;		// 采购价
	private BigDecimal priceOperation;		// 运算成本价
	private BigDecimal ratioOperation;		// 运算加价系数
	private BigDecimal priceSrc;			// 销售价
	private BigDecimal scaleExperienceFee;		// 体验费收取比例
	
	private BigDecimal scaleExperienceDeposit;  // 体验押金比例
	private BigDecimal priceDecPoint;           // 积分可低金额
	
	private BigDecimal discountPrice;		// 促销特价
	private BigDecimal discountScale;		// 促销折扣
	private BigDecimal discountFilterScale;	// 促销筛选折扣
	private Date discountFilterStart;		// 促销筛选生效时间
	private Date discountFilterEnd;			// 促销筛选失效时间
	private String isBuy;					// 是否可购买
	private String isExperience;			// 是否可体验
	private String isForebuy;				// 是否可预购
	private String isForeexperience;		// 是否可预约体验
	private String isForeexperienceDate;	// 是否可预约体验日期
	private Integer sellNum;				// 销量

	/******************************************** 自定义常量  *********************************************/
	
	// 产品变更记录来源类型 lgt_ps_produce_item_srcType
	public static final String SRCTYPE_PRODUCE_EDIT	= "1";	// 产品编辑
	public static final String SRCTYPE_DISCOUNT		= "2";	// 产品促销
	
	
	
	public ProduceItem() {
		super();
	}

	public ProduceItem(String id){
		super(id);
	}

	public ProduceItem(Produce produce) {
		super();
		this.produce = produce;
	}
	
	
	
	public Integer getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(Integer serialNo) {
		this.serialNo = serialNo;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	public String getSrcType() {
		return srcType;
	}

	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}

	public String getSrcId() {
		return srcId;
	}

	public void setSrcId(String srcId) {
		this.srcId = srcId;
	}

	@Length(min=0, max=64, message="原记录ID长度必须介于 0 和 64 之间")
	public ProduceItem getPreItem() {
		return preItem;
	}

	public void setPreItem(ProduceItem preItem) {
		this.preItem = preItem;
	}
	
	@Length(min=0, max=100, message="产品编码长度必须介于 0 和 100 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=0, max=2000, message="属性字符串长度必须介于 0 和 2000 之间")
	public String getPropertyStr() {
		return propertyStr;
	}

	public void setPropertyStr(String propertyStr) {
		this.propertyStr = propertyStr;
	}
	
	@Length(min=0, max=2000, message="SKU属性字符串长度必须介于 0 和 2000 之间")
	public String getPropertySkuStr() {
		return propertySkuStr;
	}

	public void setPropertySkuStr(String propertySkuStr) {
		this.propertySkuStr = propertySkuStr;
	}
	
	@Length(min=0, max=100, message="产品原厂编码长度必须介于 0 和 100 之间")
	public String getFactoryCode() {
		return factoryCode;
	}

	public void setFactoryCode(String factoryCode) {
		this.factoryCode = factoryCode;
	}
	
	@Length(min=1, max=100, message="产品名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=2, message="风格类型长度必须介于 0 和 2 之间")
	public String getStyleType() {
		return styleType;
	}

	public void setStyleType(String styleType) {
		this.styleType = styleType;
	}
	
	@Length(min=1, max=2, message="产品状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public BigDecimal getStandardWeight() {
		return standardWeight;
	}

	public void setStandardWeight(BigDecimal standardWeight) {
		this.standardWeight = standardWeight;
	}
	
	public BigDecimal getPricePurchase() {
		return pricePurchase;
	}

	public void setPricePurchase(BigDecimal pricePurchase) {
		this.pricePurchase = pricePurchase;
	}
	
	public BigDecimal getPriceOperation() {
		return priceOperation;
	}

	public void setPriceOperation(BigDecimal priceOperation) {
		this.priceOperation = priceOperation;
	}
	
	public BigDecimal getRatioOperation() {
		return ratioOperation;
	}

	public void setRatioOperation(BigDecimal ratioOperation) {
		this.ratioOperation = ratioOperation;
	}
	
	public BigDecimal getPriceSrc() {
		return priceSrc;
	}

	public void setPriceSrc(BigDecimal priceSrc) {
		this.priceSrc = priceSrc;
	}

	public BigDecimal getScaleExperienceFee() {
		return scaleExperienceFee;
	}

	public void setScaleExperienceFee(BigDecimal scaleExperienceFee) {
		this.scaleExperienceFee = scaleExperienceFee;
	}

	public BigDecimal getScaleExperienceDeposit() {
		return scaleExperienceDeposit;
	}

	public void setScaleExperienceDeposit(BigDecimal scaleExperienceDeposit) {
		this.scaleExperienceDeposit = scaleExperienceDeposit;
	}

	public BigDecimal getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(BigDecimal discountPrice) {
		this.discountPrice = discountPrice;
	}
	
	public BigDecimal getDiscountScale() {
		return discountScale;
	}

	public void setDiscountScale(BigDecimal discountScale) {
		this.discountScale = discountScale;
	}
	
	public BigDecimal getDiscountFilterScale() {
		return discountFilterScale;
	}

	public void setDiscountFilterScale(BigDecimal discountFilterScale) {
		this.discountFilterScale = discountFilterScale;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDiscountFilterStart() {
		return discountFilterStart;
	}

	public void setDiscountFilterStart(Date discountFilterStart) {
		this.discountFilterStart = discountFilterStart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDiscountFilterEnd() {
		return discountFilterEnd;
	}

	public void setDiscountFilterEnd(Date discountFilterEnd) {
		this.discountFilterEnd = discountFilterEnd;
	}
	
	@Length(min=0, max=1, message="是否可购买长度必须介于 0 和 1 之间")
	public String getIsBuy() {
		return isBuy;
	}

	public void setIsBuy(String isBuy) {
		this.isBuy = isBuy;
	}
	
	@Length(min=0, max=1, message="是否可体验长度必须介于 0 和 1 之间")
	public String getIsExperience() {
		return isExperience;
	}

	public void setIsExperience(String isExperience) {
		this.isExperience = isExperience;
	}
	
	@Length(min=0, max=1, message="是否可预购长度必须介于 0 和 1 之间")
	public String getIsForebuy() {
		return isForebuy;
	}

	public void setIsForebuy(String isForebuy) {
		this.isForebuy = isForebuy;
	}
	
	@Length(min=0, max=1, message="是否可预约体验长度必须介于 0 和 1 之间")
	public String getIsForeexperience() {
		return isForeexperience;
	}

	public void setIsForeexperience(String isForeexperience) {
		this.isForeexperience = isForeexperience;
	}
	
	@Length(min=0, max=1, message="是否可预约体验日期长度必须介于 0 和 1 之间")
	public String getIsForeexperienceDate() {
		return isForeexperienceDate;
	}

	public void setIsForeexperienceDate(String isForeexperienceDate) {
		this.isForeexperienceDate = isForeexperienceDate;
	}
	
	@NotNull(message="销量不能为空")
	public Integer getSellNum() {
		return sellNum;
	}

	public void setSellNum(Integer sellNum) {
		this.sellNum = sellNum;
	}

	public BigDecimal getPriceDecPoint() {
		return priceDecPoint;
	}

	public void setPriceDecPoint(BigDecimal priceDecPoint) {
		this.priceDecPoint = priceDecPoint;
	}
	
}