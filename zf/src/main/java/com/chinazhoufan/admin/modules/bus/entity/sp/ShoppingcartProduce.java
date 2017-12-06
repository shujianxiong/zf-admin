/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.sp;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 购物车产品表Entity
 * @author liut
 * @version 2016-12-02
 */
public class ShoppingcartProduce extends DataEntity<ShoppingcartProduce> {
	
	private static final long serialVersionUID = 1L;
	private Member member;		// 会员ID
	private Collocation collocation;		// 来源搭配ID
	private Produce produce;		// 产品ID
	private String num;		// 产品数量
	
	public ShoppingcartProduce() {
		super();
	}

	public ShoppingcartProduce(String id){
		super(id);
	}

	@Length(min=1, max=64, message="会员ID长度必须介于 1 和 64 之间")
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	public Collocation getCollocation() {
		return collocation;
	}

	public void setCollocation(Collocation collocation) {
		this.collocation = collocation;
	}

	
	@NotNull(message="产品ID不能为空")
	public Produce getProduce() {
		return produce;
	}
	
	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	
	@Length(min=1, max=11, message="产品数量长度必须介于 1 和 11 之间")
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	
}