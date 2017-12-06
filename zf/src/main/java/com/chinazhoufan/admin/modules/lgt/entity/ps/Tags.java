/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 商品标签Entity
 * @author 贾斌
 * @version 2016-01-05
 */
public class Tags extends DataEntity<Tags> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 标签名称
	private String hotFlag;		// 是否热门
	private String orderNo;		// 排列序号
	
	private String goodsId;//临时定义
	
	public static final String IS_HOT_TRUE = "1"; // 是热门标签
	public static final String IS_HOT_FALSE = "0"; // 不是热门标签
	
	public Tags() {
		super();
	}

	
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}


	public Tags(String id){
		super(id);
	}

	@Length(min=1, max=50, message="标签名称长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=1, message="是否热门长度必须介于 1 和 1 之间")
	public String getHotFlag() {
		return hotFlag;
	}

	public void setHotFlag(String hotFlag) {
		this.hotFlag = hotFlag;
	}
	
	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
}