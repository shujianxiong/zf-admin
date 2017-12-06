/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.pd;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceItem;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 产品促销表Entity
 * @author liut
 * @version 2017-07-04
 */
public class Discount extends DataEntity<Discount> {
	
	private static final long serialVersionUID = 1L;
	private String title;						// 标题
	private BigDecimal scaleExperienceDeposit;	// 体验押金比例
	private BigDecimal discountFilterScale;		// 筛选促销折扣
	private Date discountFilterStart;			// 筛选促销生效时间
	private Date discountFilterEnd;				// 筛选促销失效时间
	private BigDecimal priceDecPoint;			// 积分可抵金额
	private Integer produceNum;					// 执行产品数量
	
	//****************************** 参数条件 ****************************************/
	private String propertyArr;      // 属性条件集合
	private String produceIdList;    // 受影响产品ID集合
	
	//****************************** 组装参数 ****************************************/
	private List<DiscountProperty> discountPropertyList = Lists.newArrayList();
	
	private List<Property> propertyList = Lists.newArrayList();
	
	private List<ProduceItem> produceItemList = Lists.newArrayList();
	
	
	
	public Discount() {
		super();
	}

	public Discount(String id){
		super(id);
	}

	
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public BigDecimal getScaleExperienceDeposit() {
		return scaleExperienceDeposit;
	}

	public void setScaleExperienceDeposit(BigDecimal scaleExperienceDeposit) {
		this.scaleExperienceDeposit = scaleExperienceDeposit;
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

	public BigDecimal getPriceDecPoint() {
		return priceDecPoint;
	}

	public void setPriceDecPoint(BigDecimal priceDecPoint) {
		this.priceDecPoint = priceDecPoint;
	}

	public Integer getProduceNum() {
		return produceNum;
	}

	public void setProduceNum(Integer produceNum) {
		this.produceNum = produceNum;
	}

	public String getPropertyArr() {
		return propertyArr;
	}

	public void setPropertyArr(String propertyArr) {
		this.propertyArr = propertyArr;
	}

	public String getProduceIdList() {
		return produceIdList;
	}

	public void setProduceIdList(String produceIdList) {
		this.produceIdList = produceIdList;
	}

	public List<DiscountProperty> getDiscountPropertyList() {
		return discountPropertyList;
	}

	public void setDiscountPropertyList(List<DiscountProperty> discountPropertyList) {
		this.discountPropertyList = discountPropertyList;
	}

	public List<Property> getPropertyList() {
		return propertyList;
	}

	public void setPropertyList(List<Property> propertyList) {
		this.propertyList = propertyList;
	}

	public List<ProduceItem> getProduceItemList() {
		return produceItemList;
	}

	public void setProduceItemList(List<ProduceItem> produceItemList) {
		this.produceItemList = produceItemList;
	}
	
}