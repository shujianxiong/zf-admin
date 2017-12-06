/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.cl;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;

/**
 * 会员商品浏览记录Entity
 * @author 贾斌
 * @version 2016-01-11
 */
public class GoodsView extends DataEntity<GoodsView> {
	
	private static final long serialVersionUID = 1L;
	private Member member;				// 会员
	private Goods goods;				// 商品
	private int viewCount;				// 商品浏览次数
	/************************自定义常量***********************/
	public static final int FLAG_1=1;	
	
	
	public GoodsView() {
		super();
	}
	
	public GoodsView(String id){
		super(id);
	}
	
	
	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

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
	
}