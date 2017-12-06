package com.chinazhoufan.mobile.index.modules.usercenter.vo;

import java.util.List;

import javax.xml.bind.annotation.XmlTransient;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsCollect;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;


@SuppressWarnings("unused")
public class GoodsCollectListVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Page page;
	public static final int PAGE_SIZE = 10;//分页默认大小
	private int goPage;
	private Member member;//会员
	public static final String DELFLAG="0";//0表示没有被删除的
	private List<GoodsCollect> goodsCollectList;//收藏商品集合
	
	public GoodsCollectListVO(){
	}
	
	
	public List<GoodsCollect> getGoodsCollectList() {
		return goodsCollectList;
	}

	public void setGoodsCollectList(List<GoodsCollect> goodsCollectList) {
		this.goodsCollectList = goodsCollectList;
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
