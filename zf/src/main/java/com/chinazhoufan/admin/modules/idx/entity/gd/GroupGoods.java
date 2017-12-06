/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.entity.gd;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;

/**
 * 搭配分组商品Entity
 * @author liut
 * @version 2017-03-15
 */
public class GroupGoods extends DataEntity<GroupGoods> {
	
	private static final long serialVersionUID = 1L;
	private Collocation collocation;	// 所属搭配ID
	private CollocationGroup group;		// 所属分组ID
	private Goods goods;				// 商品ID
	private Integer orderNo;			//排序序号
	
	
	
	public GroupGoods() {
		super();
	}

	public GroupGoods(String id){
		super(id);
	}
	
	

	@NotNull(message="所属搭配ID不能为空")
	public Collocation getCollocation() {
		return collocation;
	}

	public void setCollocation(Collocation collocation) {
		this.collocation = collocation;
	}
	
	@NotNull(message="所属分组ID不能为空")
	public CollocationGroup getGroup() {
		return group;
	}

	public void setGroup(CollocationGroup group) {
		this.group = group;
	}
	
	@NotNull(message="商品ID不能为空")
	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	
	
	
}