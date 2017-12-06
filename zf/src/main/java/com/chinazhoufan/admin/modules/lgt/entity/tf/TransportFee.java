/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.tf;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.sys.entity.Area;

/**
 * 运费模板Entity
 * 前台计算运费时，根据“发货仓库”和收货地址中“区域”查询启用的运费模板记录
 *    如果没有则根据“发货仓库”和收货地址中“市”查询启用的运费模板记录
 *    如果还没有则根据“发货仓库”和收货地址中“省”查询启用的运费模板记录
 *    如果依然没有则根据“发货仓库”和收货地址中“国家”查询启用的运费模板记录
 * 后台设置运费时，先设置收货地区为“中国”的运费模板记录作为通用的运费模板记录
 *    然后再设置收货地址为各省的运费模板记录
 *    如果需要为市、区单独制定，则设置收货地区为市、区的运费模板记录，否则不用设置
 * @author 张金俊
 * @version 2016-12-03
 */
public class TransportFee extends DataEntity<TransportFee> {
	
	private static final long serialVersionUID = 1L;
	private Warehouse warehouse;		// 发货仓库
	private Area receiveArea;			// 收货地区
	private BigDecimal costMoney;		// 快递公司价格
	private BigDecimal money;			// 运费
	private Integer days;				// 寄送耗时
	private String usableFlag;			// 启用状态
	
	
	public TransportFee() {
		super();
	}

	public TransportFee(String id){
		super(id);
	}
	

	@Length(min=1, max=64, message="发货出库ID长度必须介于 1 和 64 之间")
	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}
	
	@Length(min=1, max=64, message="收货地区ID长度必须介于 1 和 64 之间")
	public Area getReceiveArea() {
		return receiveArea;
	}

	public void setReceiveArea(Area receiveArea) {
		this.receiveArea = receiveArea;
	}
	
	@NotNull(message="快递公司价格不能为空")
	public BigDecimal getCostMoney() {
		return costMoney;
	}

	public void setCostMoney(BigDecimal costMoney) {
		this.costMoney = costMoney;
	}
	
	@NotNull(message="运费不能为空")
	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	
	@NotNull(message="寄送耗时不能为空")
	public Integer getDays() {
		return days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}
	
	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}