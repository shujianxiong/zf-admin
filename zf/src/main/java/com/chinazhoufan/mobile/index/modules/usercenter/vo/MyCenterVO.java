package com.chinazhoufan.mobile.index.modules.usercenter.vo;

import java.math.BigDecimal;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;


public class MyCenterVO {
	
	private Member member; //当前用户

	private int messageNum;	//消息提醒
	
	private  int goodsNum;	//收藏商品
	
	private int goodsViewNum;//浏览过的商品
	
	private int point;//当前积分
	
	private BigDecimal usableBalance;	// 可用余额
	private BigDecimal frozenBalance;	// 冻结余额
	
	
	
	public MyCenterVO() {}
	
	public MyCenterVO(Member member){
		this.member=member;
	}

	public MyCenterVO(Member member, int messageNum) {
		this.member = member;
		this.messageNum = messageNum;
	}
	
	public MyCenterVO(Member member, int point,
			BigDecimal usableBalance, BigDecimal frozenBalance) {
		super();
		this.member = member;
		this.point = point;
		this.usableBalance = usableBalance;
		this.frozenBalance = frozenBalance;
	}

	
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public int getMessageNum() {
		return messageNum;
	}

	public void setMessageNum(int messageNum) {
		this.messageNum = messageNum;
	}

	public int getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(int goodsNum) {
		this.goodsNum = goodsNum;
	}

	public int getGoodsViewNum() {
		return goodsViewNum;
	}

	public void setGoodsViewNum(int goodsViewNum) {
		this.goodsViewNum = goodsViewNum;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public BigDecimal getUsableBalance() {
		return usableBalance;
	}

	public void setUsableBalance(BigDecimal usableBalance) {
		this.usableBalance = usableBalance;
	}

	public BigDecimal getFrozenBalance() {
		return frozenBalance;
	}

	public void setFrozenBalance(BigDecimal frozenBalance) {
		this.frozenBalance = frozenBalance;
	}
}
