/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ob;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 购买产品Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class BuyProduce extends DataEntity<BuyProduce> {
	
	private static final long serialVersionUID = 1L;
	private BuyOrder buyOrder;						// 购买单
	private ExperienceProduce experienceProduce;	// 体验产品
	private Produce produce;						// 产品
	private Integer num;							// 数量
	private String goodsTitle;						// 商品标题
	private String produceName;						// 产品名称
	private BigDecimal priceSrc;					// 购买原价
	private BigDecimal discountBuy;					// 购买折扣
	private BigDecimal priceBuy;					// 购买价
	
	
	public BuyProduce() {
		super();
	}

	public BuyProduce(String id){
		super(id);
	}
	

	@Length(min=1, max=64, message="购买单ID长度必须介于 1 和 64 之间")
	public BuyOrder getBuyOrder() {
		return buyOrder;
	}

	public void setBuyOrder(BuyOrder buyOrder) {
		this.buyOrder = buyOrder;
	}
	
	@Length(min=1, max=64, message="体验产品ID长度必须介于 1 和 64 之间")
	public ExperienceProduce getExperienceProduce() {
		return experienceProduce;
	}

	public void setExperienceProduce(ExperienceProduce experienceProduce) {
		this.experienceProduce = experienceProduce;
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
	
	@NotNull(message="购买原价不能为空")
	public BigDecimal getPriceSrc() {
		return priceSrc;
	}

	public void setPriceSrc(BigDecimal priceSrc) {
		this.priceSrc = priceSrc;
	}
	
	@NotNull(message="购买折扣不能为空")
	public BigDecimal getDiscountBuy() {
		return discountBuy;
	}

	public void setDiscountBuy(BigDecimal discountBuy) {
		this.discountBuy = discountBuy;
	}
	
	@NotNull(message="购买价不能为空")
	public BigDecimal getPriceBuy() {
		return priceBuy;
	}

	public void setPriceBuy(BigDecimal priceBuy) {
		this.priceBuy = priceBuy;
	}
	
}