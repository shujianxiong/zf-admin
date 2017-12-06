/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.ep;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

import java.math.BigDecimal;


/**
 * 体验包Entity
 * @author 舒剑雄
 * @version 2017-08-30
 */
public class ExperiencePack extends DataEntity<ExperiencePack> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String type;		// 类型（1、正常 2、注册 3.赠送 ）
	private String title;		// 标题
	private String photo;		// 背景图片
	private String summary;		// 简介
	private BigDecimal price;		// 价格
	private Integer persons;		// 邀请人数
	private BigDecimal discountScale;		// 优惠折扣
	private BigDecimal depositScale;		// 押金折扣
	private String expressMoney;		// 免回程运费(1、免运费 2、不免运费)
	private Integer days;		// 持续时间
	private String activeFlag;		// 启用状态
	private Integer times;		//体验次数
	private BigDecimal buyLimit;		// 购买上限
	private String cardId;		// 卡券ID
	// 类型 	experience_pack_type
	public static final String TYPE_NORMAL	= "1";	// 正常
	public static final String TYPE_REGIST		= "2";	// 注册赠送
	public static final String TYPE_gIVE		= "3";	// 邀请赠送


	// 回程运费是否可免 	express_money_type
	public static final String EXPRESS_YES	= "1";	// 免运费
	public static final String EXPRESS_NO		= "2";	// 不免运费




	public ExperiencePack() {
		super();
	}

	public ExperiencePack(String id){
		super(id);
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min=1, max=2, message="类型（1、正常 2、注册赠送 ）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min=1, max=100, message="标题长度必须介于 1 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Length(min=1, max=255, message="背景图片长度必须介于 1 和 255 之间")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Length(min=1, max=500, message="简介长度必须介于 1 和 500 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	@NotNull(message="价格不能为空")
	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	@NotNull(message="邀请人数不能为空")
	public Integer getPersons() {
		return persons;
	}

	public void setPersons(Integer persons) {
		this.persons = persons;
	}

	@NotNull(message="优惠折扣不能为空")
	public BigDecimal getDiscountScale() {
		return discountScale;
	}

	public void setDiscountScale(BigDecimal discountScale) {
		this.discountScale = discountScale;
	}

	@Length(min=1, max=1, message="免回程运费(1、免运费 2、不免运费)长度必须介于 1 和 1 之间")
	public String getExpressMoney() {
		return expressMoney;
	}

	public void setExpressMoney(String expressMoney) {
		this.expressMoney = expressMoney;
	}

	@Length(min=1, max=11, message="持续时间长度必须介于 1 和 11 之间")
	public Integer getDays() {
		return days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Integer getTimes() {
		return times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	public BigDecimal getDepositScale() {
		return depositScale;
	}

	public void setDepositScale(BigDecimal depositScale) {
		this.depositScale = depositScale;
	}

	public BigDecimal getBuyLimit() {
		return buyLimit;
	}

	public void setBuyLimit(BigDecimal buyLimit) {
		this.buyLimit = buyLimit;
	}

	public String getCardId() {
		return cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
}