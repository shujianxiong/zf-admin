package com.chinazhoufan.mobile.index.modules.usercenter.vo;

import java.util.List;

import javax.xml.bind.annotation.XmlTransient;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsCollect;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsView;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;


@SuppressWarnings("unused")
public class GoodsViewListVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Page page;
	public static final int PAGE_SIZE = 10;//分页默认大小
	private int goPage;
	private Member member;//会员
	private int goodsStatus;//商品状态（3表示 只看上架的商品）
	public static final String DELFLAG="0";//0表示没有被删除的
	private List<GoodsView> goodsViewList;//收藏商品集合
	
	public GoodsViewListVO(){
	}
	
	public List<GoodsView> getGoodsViewList() {
		return goodsViewList;
	}

	public void setGoodsViewList(List<GoodsView> goodsViewList) {
		this.goodsViewList = goodsViewList;
	}
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public int getGoPage() {
		return goPage;
	}

	public void setGoPage(int goPage) {
		this.goPage = goPage;
	}


	public int getGoodsStatus() {
		return goodsStatus;
	}

	public void setGoodsStatus(int goodsStatus) {
		this.goodsStatus = goodsStatus;
	}

	@JsonIgnore
	@XmlTransient
	public Page getPage() {
		if (page == null){
			page = new Page();
		}
		return page;
	}
	
	public Page setPage(Page page) {
		this.page = page;
		return page;
	}

}
