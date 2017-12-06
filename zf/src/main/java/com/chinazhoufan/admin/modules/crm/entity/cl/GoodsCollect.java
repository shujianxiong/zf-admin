/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.cl;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;

/**
 * 会员商品收藏表Entity
 * @author 刘晓东
 * @version 2015-11-20
 */
public class GoodsCollect extends DataEntity<GoodsCollect> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private Goods goods;		// 商品ID
	
	/************************* 自定义查询参数  **************************/
	private Date beginCollectTime;		// 开始 收藏时间
	private Date endCollectTime;		// 结束 收藏时间
	
	
	/** 构造 */
	public GoodsCollect() {
		super();
	}

	public GoodsCollect(String id){
		super(id);
	}

	public GoodsCollect(Member member) {
		super();
		this.member = member;
	}

	
	/** 方法 */
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Date getBeginCollectTime() {
		return beginCollectTime;
	}

	public void setBeginCollectTime(Date beginCollectTime) {
		this.beginCollectTime = beginCollectTime;
	}

	public Date getEndCollectTime() {
		return endCollectTime;
	}

	public void setEndCollectTime(Date endCollectTime) {
		this.endCollectTime = endCollectTime;
	}
	
}