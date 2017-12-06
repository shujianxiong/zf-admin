/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.oe;

import java.math.BigDecimal;

import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduce;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 体验产品Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class ExperienceProduce extends DataEntity<ExperienceProduce> {
	
	private static final long serialVersionUID = 1L;
	private ExperienceOrder experienceOrder;	// 体验单
	private Produce produce;					// 产品
	private Integer num;						// 数量
	private Integer buyNum;						// 自动转购买数量
	private Integer changeNewNum;				//换新数量
	private String goodsTitle;					// 商品标题
	private String produceName;					// 产品名称
	private BigDecimal priceSrcExperience;		// 体验原价
	private BigDecimal scaleExperienceDeposit;	// 体验押金比例
	private BigDecimal priceExperienceDeposit;	// 体验押金
	private String status;						// 体验状态
	private String decisionType;				// 消费决策（退/买/换购/预购）
	private BuyOrder decisionBuyOrder;			// 消费购买单
	private BigDecimal moneyCheckDec;			// 质检扣减金额
	private BigDecimal moneySettDec;			// 结算扣减金额
	private BigDecimal moneySettDecableBeans;	// 魅力豆可抵金额
	private BigDecimal priceSrcBuy;				// 购买原价
	private BigDecimal discountBuy;				// 购买折扣
	private BigDecimal priceBuy;				// 购买价
	private String   damageType;                // 质检存在损坏货品的类型
	/******************************************** 自定义常量  *********************************************/
	// 体验状态 bus_oe_experience_produce_status
	public static final String STATUS_TOEXPERIENCE		= "1";	// 待体验
	public static final String STATUS_EXPERIENCING		= "2";	// 体验中
	public static final String STATUS_RETURNING			= "3";	// 退货中
	public static final String STATUS_TOSETTLEMENT		= "4";	// 待结算
	public static final String STATUS_FINISH			= "5";	// 体验结束
	public static final String STATUS_CLOSED			= "99";	// 订单关闭
	
	// 消费决策 bus_oe_experience_produce_decisionType
	public static final String DECISIONTYPE_RETURN		= "1";	// 退货
	public static final String DECISIONTYPE_BUY			= "2";	// 购买
	public static final String DECISIONTYPE_CHANGEBUY	= "3";	// 换购
	public static final String DECISIONTYPE_APPOINTBUY	= "4";	// 预购
	
	
	private ReturnProduce returnProduce;					// 退货产品
	
	public ExperienceProduce() {
		super();
	}

	public ExperienceProduce(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="体验单ID长度必须介于 1 和 64 之间")
	public ExperienceOrder getExperienceOrder() {
		return experienceOrder;
	}

	public void setExperienceOrder(ExperienceOrder experienceOrder) {
		this.experienceOrder = experienceOrder;
	}
	
	@Length(min=1, max=64, message="产品ID长度必须介于 1 和 64 之间")
	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
	@NotNull(message="数量不能为空")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	@Length(min=1, max=255, message="商品标题长度必须介于 1 和 255 之间")
	public String getGoodsTitle() {
		return goodsTitle;
	}

	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	
	@Length(min=1, max=100, message="产品名称长度必须介于 1 和 100 之间")
	public String getProduceName() {
		return produceName;
	}

	public void setProduceName(String produceName) {
		this.produceName = produceName;
	}
	
	@NotNull(message="购买价格不能为空")
	public BigDecimal getPriceBuy() {
		return priceBuy;
	}

	public void setPriceBuy(BigDecimal priceBuy) {
		this.priceBuy = priceBuy;
	}
	
	@Length(min=1, max=2, message="体验状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=2, message="消费决策（退/买/换购/预购）长度必须介于 0 和 2 之间")
	public String getDecisionType() {
		return decisionType;
	}

	public void setDecisionType(String decisionType) {
		this.decisionType = decisionType;
	}
	
	@Length(min=0, max=64, message="消费购买单ID长度必须介于 0 和 64 之间")
	public BuyOrder getDecisionBuyOrder() {
		return decisionBuyOrder;
	}

	public void setDecisionBuyOrder(BuyOrder decisionBuyOrder) {
		this.decisionBuyOrder = decisionBuyOrder;
	}
	
	public BigDecimal getMoneySettDec() {
		return moneySettDec;
	}

	public void setMoneySettDec(BigDecimal moneySettDec) {
		this.moneySettDec = moneySettDec;
	}

	public BigDecimal getMoneySettDecableBeans() {
		return moneySettDecableBeans;
	}

	public void setMoneySettDecableBeans(BigDecimal moneySettDecableBeans) {
		this.moneySettDecableBeans = moneySettDecableBeans;
	}

	public BigDecimal getDiscountBuy() {
		return discountBuy;
	}

	public void setDiscountBuy(BigDecimal discountBuy) {
		this.discountBuy = discountBuy;
	}

	public BigDecimal getPriceSrcExperience() {
		return priceSrcExperience;
	}

	public void setPriceSrcExperience(BigDecimal priceSrcExperience) {
		this.priceSrcExperience = priceSrcExperience;
	}

	public BigDecimal getScaleExperienceDeposit() {
		return scaleExperienceDeposit;
	}

	public void setScaleExperienceDeposit(BigDecimal scaleExperienceDeposit) {
		this.scaleExperienceDeposit = scaleExperienceDeposit;
	}

	public BigDecimal getPriceExperienceDeposit() {
		return priceExperienceDeposit;
	}

	public void setPriceExperienceDeposit(BigDecimal priceExperienceDeposit) {
		this.priceExperienceDeposit = priceExperienceDeposit;
	}

	public BigDecimal getPriceSrcBuy() {
		return priceSrcBuy;
	}

	public void setPriceSrcBuy(BigDecimal priceSrcBuy) {
		this.priceSrcBuy = priceSrcBuy;
	}

	public BigDecimal getMoneyCheckDec() {
		return moneyCheckDec;
	}

	public void setMoneyCheckDec(BigDecimal moneyCheckDec) {
		this.moneyCheckDec = moneyCheckDec;
	}

	public Integer getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(Integer buyNum) {
		this.buyNum = buyNum;
	}

	public String getDamageType() {
		return damageType;
	}

	public void setDamageType(String damageType) {
		this.damageType = damageType;
	}

	public Integer getChangeNewNum() {
		return changeNewNum;
	}

	public void setChangeNewNum(Integer changeNewNum) {
		this.changeNewNum = changeNewNum;
	}

	public ReturnProduce getReturnProduce() {
		return returnProduce;
	}

	public void setReturnProduce(ReturnProduce returnProduce) {
		this.returnProduce = returnProduce;
	}
}