package com.chinazhoufan.admin.modules.lgt.entity.wr;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;

public class WorkRecord extends DataEntity<WorkRecord>{
	private static final long serialVersionUID = 1L;
	public String name;           //姓名
	public String packageCount;   //包裹入库
	public String purchaseCount;  //采购质检
	public String returnCount;       //回货质检
	public String pickOrderCount; // 拣货
	public String sendOrderCount; // 发货
	public String errProblemCount; // 异常问题登记
	
	private Date beginCreateDate;	// 开始创建时间
	private Date endCreateDate;		// 结束创建时间
	

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPackageCount() {
		return packageCount;
	}
	public void setPackageCount(String packageCount) {
		this.packageCount = packageCount;
	}
	public String getPurchaseCount() {
		return purchaseCount;
	}
	public void setPurchaseCount(String purchaseCount) {
		this.purchaseCount = purchaseCount;
	}
	public String getReturnCount() {
		return returnCount;
	}
	public void setReturnCount(String returnCount) {
		this.returnCount = returnCount;
	}
	public String getSendOrderCount() {
		return sendOrderCount;
	}
	public void setSendOrderCount(String sendOrderCount) {
		this.sendOrderCount = sendOrderCount;
	}
	public String getPickOrderCount() {
		return pickOrderCount;
	}
	public void setPickOrderCount(String pickOrderCount) {
		this.pickOrderCount = pickOrderCount;
	}
	public String getErrProblemCount() {
		return errProblemCount;
	}
	public void setErrProblemCount(String errProblemCount) {
		this.errProblemCount = errProblemCount;
	}
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}
	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	public Date getEndCreateDate() {
		return endCreateDate;
	}
	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
	
}

