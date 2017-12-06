/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 产品更新审批Entity
 * @author liut
 * @version 2017-03-22
 */
public class ProduceUpdate extends DataEntity<ProduceUpdate> {
	
	private static final long serialVersionUID = 1L;
	private Produce produce;		// 产品ID
	private BigDecimal srcPricePurchase;		// 原采购价
	private BigDecimal desPricePurchase;		// 新采购价
	private BigDecimal srcPriceOperation;		// 原运算成本价
	private BigDecimal desPriceOperation;		// 新运算成本价
	private String srcIsBuy;		// 原是否可购买
	private String desIsBuy;		// 新是否可购买
	private BigDecimal srcPriceBuy;		// 原购买价格
	private BigDecimal desPriceBuy;		// 新购买价格
	
	private BigDecimal srcScaleDiscount;//原打折比例
	private BigDecimal desScaleDiscount;//新打折比例
	
	private String srcIsExperience;		// 原是否可体验
	private String desIsExperience;		// 新是否可体验
	private BigDecimal srcScaleExperience;		// 原体验费收取比例
	private BigDecimal desScaleExperience;		// 新体验费收取比例
	private String srcIsForebuy;		// 原是否可预购
	private String desIsForebuy;		// 新是否可预购
	private String srcIsForeexperience;		// 原是否可预约
	private String desIsForeexperience;		// 新是否可预约
	private User checkBy;		// 审批人
	private Date checkTime;		// 审批时间
	private String checkRemarks;		// 审批备注
	private String checkStatus;		// 审批状态    字典：lgt_ps_produce_update_checkStatus
	
	public static final String CHECK_STATUS_NEW = "1";//新建
	public static final String CHECK_STATUS_WAIT = "2";//待审批
	public static final String CHECK_STATUS_OK = "3";//审批通过
	
	public ProduceUpdate() {
		super();
	}

	public ProduceUpdate(String id){
		super(id);
	}

	@NotNull(message="产品ID不能为空")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	public BigDecimal getSrcPriceBuy() {
		return srcPriceBuy;
	}

	public BigDecimal getDesPriceBuy() {
		return desPriceBuy;
	}

	public User getCheckBy() {
		return checkBy;
	}

	public BigDecimal getSrcPricePurchase() {
		return srcPricePurchase;
	}

	public void setSrcPricePurchase(BigDecimal srcPricePurchase) {
		this.srcPricePurchase = srcPricePurchase;
	}

	public BigDecimal getDesPricePurchase() {
		return desPricePurchase;
	}

	public void setDesPricePurchase(BigDecimal desPricePurchase) {
		this.desPricePurchase = desPricePurchase;
	}

	public BigDecimal getSrcPriceOperation() {
		return srcPriceOperation;
	}

	public void setSrcPriceOperation(BigDecimal srcPriceOperation) {
		this.srcPriceOperation = srcPriceOperation;
	}

	public BigDecimal getDesPriceOperation() {
		return desPriceOperation;
	}

	public void setDesPriceOperation(BigDecimal desPriceOperation) {
		this.desPriceOperation = desPriceOperation;
	}

	public void setSrcPriceBuy(BigDecimal srcPriceBuy) {
		this.srcPriceBuy = srcPriceBuy;
	}

	public void setDesPriceBuy(BigDecimal desPriceBuy) {
		this.desPriceBuy = desPriceBuy;
	}

	public void setCheckBy(User checkBy) {
		this.checkBy = checkBy;
	}

	@Length(min=0, max=1, message="原是否可购买长度必须介于 0 和 1 之间")
	public String getSrcIsBuy() {
		return srcIsBuy;
	}

	public void setSrcIsBuy(String srcIsBuy) {
		this.srcIsBuy = srcIsBuy;
	}
	
	@Length(min=0, max=1, message="新是否可购买长度必须介于 0 和 1 之间")
	public String getDesIsBuy() {
		return desIsBuy;
	}

	public void setDesIsBuy(String desIsBuy) {
		this.desIsBuy = desIsBuy;
	}
	
	@Length(min=0, max=1, message="原是否可体验长度必须介于 0 和 1 之间")
	public String getSrcIsExperience() {
		return srcIsExperience;
	}

	public void setSrcIsExperience(String srcIsExperience) {
		this.srcIsExperience = srcIsExperience;
	}
	
	@Length(min=0, max=1, message="新是否可体验长度必须介于 0 和 1 之间")
	public String getDesIsExperience() {
		return desIsExperience;
	}

	public void setDesIsExperience(String desIsExperience) {
		this.desIsExperience = desIsExperience;
	}
	
	@Length(min=0, max=1, message="原是否可预购长度必须介于 0 和 1 之间")
	public String getSrcIsForebuy() {
		return srcIsForebuy;
	}

	public void setSrcIsForebuy(String srcIsForebuy) {
		this.srcIsForebuy = srcIsForebuy;
	}
	
	@Length(min=0, max=1, message="新是否可预购长度必须介于 0 和 1 之间")
	public String getDesIsForebuy() {
		return desIsForebuy;
	}

	public void setDesIsForebuy(String desIsForebuy) {
		this.desIsForebuy = desIsForebuy;
	}
	
	@Length(min=0, max=1, message="原是否可预约长度必须介于 0 和 1 之间")
	public String getSrcIsForeexperience() {
		return srcIsForeexperience;
	}

	public void setSrcIsForeexperience(String srcIsForeexperience) {
		this.srcIsForeexperience = srcIsForeexperience;
	}
	
	@Length(min=0, max=1, message="新是否可预约长度必须介于 0 和 1 之间")
	public String getDesIsForeexperience() {
		return desIsForeexperience;
	}

	public void setDesIsForeexperience(String desIsForeexperience) {
		this.desIsForeexperience = desIsForeexperience;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	
	public String getCheckRemarks() {
		return checkRemarks;
	}

	public void setCheckRemarks(String checkRemarks) {
		this.checkRemarks = checkRemarks;
	}
	
	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public BigDecimal getSrcScaleDiscount() {
		return srcScaleDiscount;
	}

	public void setSrcScaleDiscount(BigDecimal srcScaleDiscount) {
		this.srcScaleDiscount = srcScaleDiscount;
	}

	public BigDecimal getDesScaleDiscount() {
		return desScaleDiscount;
	}

	public void setDesScaleDiscount(BigDecimal desScaleDiscount) {
		this.desScaleDiscount = desScaleDiscount;
	}

	public BigDecimal getSrcScaleExperience() {
		return srcScaleExperience;
	}

	public void setSrcScaleExperience(BigDecimal srcScaleExperience) {
		this.srcScaleExperience = srcScaleExperience;
	}

	public BigDecimal getDesScaleExperience() {
		return desScaleExperience;
	}

	public void setDesScaleExperience(BigDecimal desScaleExperience) {
		this.desScaleExperience = desScaleExperience;
	}
	
	
	
}