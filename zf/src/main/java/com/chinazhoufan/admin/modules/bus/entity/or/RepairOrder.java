/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.or;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.sys.entity.User;

import javax.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 货品维修单Entity
 * @author 张金俊
 * @version 2016-11-19
 */
public class RepairOrder extends DataEntity<RepairOrder> {
	
	private static final long serialVersionUID = 1L;
	private Product product;				// 货品
	private String status;					// 维修单状态（）
	private String breakdownType;			// 问题类型（破损/刮花）（bus_or_repair_order_breakdownType）
	private String breakdownDescription;	// 问题说明
	private String breakdownPhotos;			// 问题图片
	private BigDecimal moneyLoss;			// 货品估损
	private String applyType;				// 申请处理类型（维修/返厂）
	private User applyBy;					// 申请人
	private Date applyTime;					// 申请时间
	private String dealType;				// 处理类型（维修/返厂）
	private String dealDescription;			// 处理说明
	private String dealPhotos;				// 处理图片
	private User dealBy;					// 处理人
	private Date dealStartTime;				// 处理起始时间
	private Date dealEndTime;				// 处理结束时间
	
	/********************************* 自定义常量  *********************************/
	private String bussinessId;             // 来源业务ID，目前这里主要是为了传递退货单ID
	
	
	
	// “问题类型”数据字典类型
	public static final String DICT_BREAKDOWNTYPE = "bus_or_repair_order_breakdownType";
	
	// 维修单状态 [bus_or_repair_order_status]
	public static final String STATUS_WAIT_REPAIR 		= "1";	// 待维修
	public static final String STATUS_WAIT_BACK_FACTORY = "2";	// 待返厂
	public static final String STATUS_REPAIRING 		= "3";	// 维修中
	public static final String STATUS_REPAIRED 			= "4";	// 已维修
	public static final String STATUS_BACKED 			= "5";	// 已交还
	
	// （申请）处理类型 [bus_or_repair_order_dealType]
	public static final String DEALTYPE_SELF_REPAIR		= "1";	// 维修
	public static final String DEALTYPE_BACK_FACTORY	= "2";	// 返厂
	
	
	
	public RepairOrder() {
		super();
	}

	public RepairOrder(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="货品ID长度必须介于 1 和 64 之间")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min=1, max=2, message="问题类型（破损/刮花）长度必须介于 1 和 2 之间")
	public String getBreakdownType() {
		return breakdownType;
	}

	public void setBreakdownType(String breakdownType) {
		this.breakdownType = breakdownType;
	}
	
	@Length(min=0, max=255, message="问题说明长度必须介于 0 和 255 之间")
	public String getBreakdownDescription() {
		return breakdownDescription;
	}

	public void setBreakdownDescription(String breakdownDescription) {
		this.breakdownDescription = breakdownDescription;
	}
	
	@Length(min=0, max=2000, message="问题图片长度必须介于 0 和 2000 之间")
	public String getBreakdownPhotos() {
		return breakdownPhotos;
	}

	public void setBreakdownPhotos(String breakdownPhotos) {
		this.breakdownPhotos = breakdownPhotos;
	}
	
	public BigDecimal getMoneyLoss() {
		return moneyLoss;
	}

	public void setMoneyLoss(BigDecimal moneyLoss) {
		this.moneyLoss = moneyLoss;
	}

	@Length(min=1, max=2, message="申请处理类型（返厂/自修）长度必须介于 1 和 2 之间")
	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}
	
	@NotNull(message="申请人不能为空")
	public User getApplyBy() {
		return applyBy;
	}

	public void setApplyBy(User applyBy) {
		this.applyBy = applyBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请时间不能为空")
	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	
	@Length(min=0, max=2, message="处理类型（返厂/自修）长度必须介于 0 和 2 之间")
	public String getDealType() {
		return dealType;
	}

	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
	
	@Length(min=0, max=255, message="处理说明长度必须介于 0 和 255 之间")
	public String getDealDescription() {
		return dealDescription;
	}

	public void setDealDescription(String dealDescription) {
		this.dealDescription = dealDescription;
	}
	
	@Length(min=0, max=2000, message="处理图片长度必须介于 0 和 2000 之间")
	public String getDealPhotos() {
		return dealPhotos;
	}

	public void setDealPhotos(String dealPhotos) {
		this.dealPhotos = dealPhotos;
	}
	
	public User getDealBy() {
		return dealBy;
	}

	public void setDealBy(User dealBy) {
		this.dealBy = dealBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDealStartTime() {
		return dealStartTime;
	}

	public void setDealStartTime(Date dealStartTime) {
		this.dealStartTime = dealStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDealEndTime() {
		return dealEndTime;
	}

	public void setDealEndTime(Date dealEndTime) {
		this.dealEndTime = dealEndTime;
	}

	public String getBussinessId() {
		return bussinessId;
	}

	public void setBussinessId(String bussinessId) {
		this.bussinessId = bussinessId;
	}
	
}