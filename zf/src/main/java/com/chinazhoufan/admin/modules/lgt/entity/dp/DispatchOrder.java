/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.dp;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * 调货单Entity
 * @author 贾斌
 * @version 2016-03-16
 */
public class DispatchOrder extends DataEntity<DispatchOrder> {
	
	private static final long serialVersionUID = 1L;
	private DispatchMission dispatchMission;	// 调货任务ID
	private Warehouse outWarehouse;				// 调出仓库
	private User outUser;						// 调出责任人
	private String orderStatus;					// 调货单状态
	private String postType;					//物流类型
	private User postUserId;					//送货人
	private String postCompany; 				//快递公司
	private String postNo;						//快递单号、
	private String posterName;					//快递员姓名
	private String posterTel;					//快递员电话
	private Date postStartTime;					//送货起始时间
	private Date postEndTime;					//送货结束时间
	//调货单状态
	public static final String ORDERSTATUS_WAITCONFIRMED = "1";//待确认
	public static final String ORDERSTATUS_WAITCALLOUT = "2";//已接收
	public static final String ORDERSTATUS_WAITSEND = "3";//待派送
	public static final String ORDERSTATUS_WAITCALLIN = "4";//派送中
	public static final String ORDERSTATUS_WAITQC = "5";//已到货，待质检
	public static final String ORDERSTATUS_PENDINGSTOCK = "6";//待入库
	public static final String ORDERSTATUS_COMPLETE = "7";//完成
	
	//传值用
	private DispatchProduce dispatchProduce;	//调货产品
	private DispatchProduct dispatchProduct;	//调货货品
	private WhProduce whProduce;				//库存数量
	private User qcUser;                        //质检人
	
	
	//一个调货单对应一个仓库，一个仓库对应N种调货产品，而产品和货品是一一对应的，故一个仓库也对应N种货品
	private List<DispatchProduce> dispatchProduceList = Lists.newArrayList();
	private List<DispatchProduct> dispatchProductList = Lists.newArrayList();
	
	//物流类型
	public static final String POSTTYPEAUTO = "1";//自主配送
	public static final String POSTTYPEBYTHREE = "2";//第三方配送
	
	
	public DispatchOrder() {
		super();
	}
	public DispatchOrder(String id,String orderStatus) {
		super(id);
		this.orderStatus = orderStatus;
	}

	public DispatchOrder(String id){
		super(id);
	}

	public DispatchProduce getDispatchProduce() {
		return dispatchProduce;
	}

	public void setDispatchProduce(DispatchProduce dispatchProduce) {
		this.dispatchProduce = dispatchProduce;
	}

	public DispatchProduct getDispatchProduct() {
		return dispatchProduct;
	}

	public void setDispatchProduct(DispatchProduct dispatchProduct) {
		this.dispatchProduct = dispatchProduct;
	}

	@Length(min=1, max=64, message="调货任务ID长度必须介于 1 和 64 之间")
	public DispatchMission getDispatchMission() {
		return dispatchMission;
	}

	public void setDispatchMission(DispatchMission dispatchMission) {
		this.dispatchMission = dispatchMission;
	}
	
	@Length(min=1, max=64, message="调出仓库长度必须介于 1 和 64 之间")
	public Warehouse getOutWarehouse() {
		return outWarehouse;
	}

	public void setOutWarehouse(Warehouse outWarehouse) {
		this.outWarehouse = outWarehouse;
	}
	
	@Length(min=1, max=64, message="调出责任人长度必须介于 1 和 64 之间")
	public User getOutUser() {
		return outUser;
	}

	public void setOutUser(User outUser) {
		this.outUser = outUser;
	}
	
	@Length(min=1, max=2, message="调货单状态长度必须介于 1 和 2 之间")
	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	@Length(min=1, max=2, message="物流类型长度必须介于 1 和 2 之间")
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	
	@Length(min=1, max=64, message="送货人长度必须介于 1 和64 之间")
	public User getPostUserId() {
		return postUserId;
	}
	public void setPostUserId(User postUserId) {
		this.postUserId = postUserId;
	}
	
	@Length(min=1, max=2, message="快递公司长度必须介于 1 和 2 之间")
	public String getPostCompany() {
		return postCompany;
	}
	public void setPostCompany(String postCompany) {
		this.postCompany = postCompany;
	}
	
	@Length(min=1, max=50, message="快递单号长度必须介于 1 和 50 之间")
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	
	@Length(min=1, max=50, message="快递员姓名长度必须介于 1 和 50 之间")
	public String getPosterName() {
		return posterName;
	}
	public void setPosterName(String posterName) {
		this.posterName = posterName;
	}
	
	@Length(min=1, max=11, message="快递员电话长度必须介于 1 和 11 之间")
	public String getPosterTel() {
		return posterTel;
	}
	public void setPosterTel(String posterTel) {
		this.posterTel = posterTel;
	}
	
	public Date getPostStartTime() {
		return postStartTime;
	}
	public void setPostStartTime(Date postStartTime) {
		this.postStartTime = postStartTime;
	}
	
	public Date getPostEndTime() {
		return postEndTime;
	}
	public void setPostEndTime(Date postEndTime) {
		this.postEndTime = postEndTime;
	}
	
	public WhProduce getWhProduce() {
		return whProduce;
	}

	public void setWhProduce(WhProduce whProduce) {
		this.whProduce = whProduce;
	}
	public User getQcUser() {
		return qcUser;
	}
	public void setQcUser(User qcUser) {
		this.qcUser = qcUser;
	}
	public List<DispatchProduce> getDispatchProduceList() {
		return dispatchProduceList;
	}
	public void setDispatchProduceList(List<DispatchProduce> dispatchProduceList) {
		this.dispatchProduceList = dispatchProduceList;
	}
	public List<DispatchProduct> getDispatchProductList() {
		return dispatchProductList;
	}
	public void setDispatchProductList(List<DispatchProduct> dispatchProductList) {
		this.dispatchProductList = dispatchProductList;
	}
	
}