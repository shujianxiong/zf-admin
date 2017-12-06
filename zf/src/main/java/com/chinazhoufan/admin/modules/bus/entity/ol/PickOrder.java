/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.ol;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

/**
 * 拣货单Entity
 * @author 张金俊
 * @version 2017-04-12
 */
public class PickOrder extends DataEntity<PickOrder> {

	private static final long serialVersionUID = 1L;
	private String pickOrderNo;			// 拣货单编号
	private String plateNo;             // 拣货盘编号
	private User pickBy;				// 拣货人
	private Date pickStartTime;			// 拣货开始时间
	private Date pickEndTime;			// 拣货完成时间
	private User packageBy;				// 打包人
	private Date packageStartTime;		// 打包开始时间
	private Date packageEndTime;		// 打包完成时间
	
	
	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginPickStartTime;	// 开始 拣货开始时间
	private Date endPickStartTime;		// 结束 拣货开始时间
	private Date beginPackageStartTime;	// 开始 打包开始时间
	private Date endPackageStartTime;	// 结束 打包开始时间
	
	private String statType;//本日=CD， 本周=CW， 本月=CM， 上一个月当日=LD， 上一个月当周=LW，上一个月=LM
	
	/**发货单列表**/
	private List<SendOrder> sendOrderList = Lists.newArrayList();
	/**变量设置**/
	private String sendOrderId;
	
	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_ORDERNO = "bus_ol_pick_order_orderNo";	// 获取拣货单编号 字段
	
	public static final String STAT_TYPE_FOR_CD = "CD";//本日
	public static final String STAT_TYPE_FOR_CW = "CW";//本周
	public static final String STAT_TYPE_FOR_CM = "CM";//本月
	public static final String STAT_TYPE_FOR_LD = "LD";//上一个月本日
	public static final String STAT_TYPE_FOR_LW = "LW";//上一个月本周
	public static final String STAT_TYPE_FOR_LM = "LM";//上一月

	public PickOrder() {
		super();
	}

	public PickOrder(String id){
		super(id);
	}

	public PickOrder(User pickBy){
		super();
		this.pickBy = pickBy;
	}
	
	@Length(min=1, max=64, message="拣货单编号长度必须介于 1 和 64 之间")
	public String getPickOrderNo() {
		return pickOrderNo;
	}

	public void setPickOrderNo(String pickOrderNo) {
		this.pickOrderNo = pickOrderNo;
	}
	
	@Length(min=1, max=64, message="拣货人长度必须介于 1 和 64 之间")
	public User getPickBy() {
		return pickBy;
	}

	public void setPickBy(User pickBy) {
		this.pickBy = pickBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="拣货开始时间不能为空")
	public Date getPickStartTime() {
		return pickStartTime;
	}

	public void setPickStartTime(Date pickStartTime) {
		this.pickStartTime = pickStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPickEndTime() {
		return pickEndTime;
	}

	public void setPickEndTime(Date pickEndTime) {
		this.pickEndTime = pickEndTime;
	}
	
	@Length(min=0, max=64, message="打包人长度必须介于 0 和 64 之间")
	public User getPackageBy() {
		return packageBy;
	}

	public void setPackageBy(User packageBy) {
		this.packageBy = packageBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPackageStartTime() {
		return packageStartTime;
	}

	public void setPackageStartTime(Date packageStartTime) {
		this.packageStartTime = packageStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPackageEndTime() {
		return packageEndTime;
	}

	public void setPackageEndTime(Date packageEndTime) {
		this.packageEndTime = packageEndTime;
	}
	
	public Date getBeginPickStartTime() {
		return beginPickStartTime;
	}

	public void setBeginPickStartTime(Date beginPickStartTime) {
		this.beginPickStartTime = beginPickStartTime;
	}
	
	public Date getEndPickStartTime() {
		return endPickStartTime;
	}

	public void setEndPickStartTime(Date endPickStartTime) {
		this.endPickStartTime = endPickStartTime;
	}
		
	public Date getBeginPackageStartTime() {
		return beginPackageStartTime;
	}

	public void setBeginPackageStartTime(Date beginPackageStartTime) {
		this.beginPackageStartTime = beginPackageStartTime;
	}
	
	public Date getEndPackageStartTime() {
		return endPackageStartTime;
	}

	public void setEndPackageStartTime(Date endPackageStartTime) {
		this.endPackageStartTime = endPackageStartTime;
	}

	public List<SendOrder> getSendOrderList() {
		return sendOrderList;
	}

	public void setSendOrderList(List<SendOrder> sendOrderList) {
		this.sendOrderList = sendOrderList;
	}

	public String getPlateNo() {
		return plateNo;
	}

	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}

	public String getStatType() {
		return statType;
	}

	public void setStatType(String statType) {
		this.statType = statType;
	}

	public String getSendOrderId() {
		return sendOrderId;
	}

	public void setSendOrderId(String sendOrderId) {
		this.sendOrderId = sendOrderId;
	}
}