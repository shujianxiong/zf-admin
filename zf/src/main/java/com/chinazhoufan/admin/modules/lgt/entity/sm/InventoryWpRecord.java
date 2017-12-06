/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.sm;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 货位盘点记录Entity
 * @author 张金俊
 * @version 2015-11-09
 */
public class InventoryWpRecord extends DataEntity<InventoryWpRecord> {
	
	private static final long serialVersionUID = 1L;
	private String inventoryNo;			// 盘点编号
	private String reasonType;			// 盘点原因类型
	private String status;				// 盘点状态	1:待处理	2：已完成
	private Wareplace wareplace;		// 货位
	private User inventoryUser;			// 盘点人
	private Integer systemNum;			// 系统库存数量
	private Integer inventoryNum;		// 盘点库存数量
	private String resultType;			// 盘点结果
	private String exceptionRemarks;	// 异常备注
	
	public static final String STATUS_DEALING  = "1";		// 待处理
	public static final String STATUS_FINISHED = "2";		// 已完成
	
	public static final String RESULTTYPE_NORMAL = "1";		// 正常 
	public static final String RESULTTYPE_MORE 	 = "2";		// 货品多出
	public static final String RESULTTYPE_LESS 	 = "3";		// 货品缺失
	
	public InventoryWpRecord() {
		super();
	}

	public InventoryWpRecord(String id){
		super(id);
	}

	public String getInventoryNo() {
		return inventoryNo;
	}

	public void setInventoryNo(String inventoryNo) {
		this.inventoryNo = inventoryNo;
	}
	
	@Length(min=1, max=2, message="盘点原因类型长度必须介于 1 和 2 之间")
	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}
	
//	@Length(min=1, max=2, message="盘点状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@NotNull(message="货位不能为空")
	public Wareplace getWareplace() {
		return wareplace;
	}

	public void setWareplace(Wareplace wareplace) {
		this.wareplace = wareplace;
	}
	
//	@NotNull(message="盘点人不能为空")
	public User getInventoryUser() {
		return inventoryUser;
	}

	public void setInventoryUser(User inventoryUser) {
		this.inventoryUser = inventoryUser;
	}
	
	public Integer getSystemNum() {
		return systemNum;
	}

	public void setSystemNum(Integer systemNum) {
		this.systemNum = systemNum;
	}
	
	@NotNull(message="盘点库存数量不能为空")
	public Integer getInventoryNum() {
		return inventoryNum;
	}

	public void setInventoryNum(Integer inventoryNum) {
		this.inventoryNum = inventoryNum;
	}
	
//	@Length(min=1, max=2, message="盘点结果长度必须介于 1 和 2 之间")
	public String getResultType() {
		return resultType;
	}

	public void setResultType(String resultType) {
		this.resultType = resultType;
	}
	
	@Length(min=0, max=255, message="异常备注长度必须介于 0 和 255 之间")
	public String getExceptionRemarks() {
		return exceptionRemarks;
	}

	public void setExceptionRemarks(String exceptionRemarks) {
		this.exceptionRemarks = exceptionRemarks;
	}
	
}