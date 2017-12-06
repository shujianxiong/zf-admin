/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity.gold;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 实时金价采集列表Entity
 * @author 贾斌
 * @version 2015-11-04
 */
public class BasGoldPriceGather extends DataEntity<BasGoldPriceGather> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 显示名称
	private String priceType;		// 采集类型（999金价/等）
	private String price;		// 价格
	private Date gatherTime;		// 获取时间
	private Date beginGatherTime;		// 开始 获取时间
	private Date endGatherTime;		// 结束 获取时间
	
	public BasGoldPriceGather() {
		super();
	}

	public BasGoldPriceGather(String id){
		super(id);
	}

	@Length(min=1, max=64, message="显示名称长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2, message="采集类型（999金价/等）长度必须介于 1 和 2 之间")
	public String getPriceType() {
		return priceType;
	}

	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="获取时间不能为空")
	public Date getGatherTime() {
		return gatherTime;
	}

	public void setGatherTime(Date gatherTime) {
		this.gatherTime = gatherTime;
	}
	
	public Date getBeginGatherTime() {
		return beginGatherTime;
	}

	public void setBeginGatherTime(Date beginGatherTime) {
		this.beginGatherTime = beginGatherTime;
	}
	
	public Date getEndGatherTime() {
		return endGatherTime;
	}

	public void setEndGatherTime(Date endGatherTime) {
		this.endGatherTime = endGatherTime;
	}
		
}