/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.si;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 供应商信誉分流水Entity
 * @author 张金俊
 * @version 2017-05-03
 */
public class CreditPointDetail extends DataEntity<CreditPointDetail> {
	
	private static final long serialVersionUID = 1L;
	private Supplier supplier;			// 供应商
	private String changeType;			// 变动类型（增/减）
	private Integer changeCreditPoint;	// 变动信誉分数量
	private Integer lastCreditPoint;	// 变动后信誉分
	private String changeReasonType;	// 变动原因
	private Date changeTime;			// 变动时间
	private String operaterType;		// 操作人类型（员工/系统）
	private String operateSourceNo;		// 来源业务编号
	
	/******************************************** 自定义常量  *********************************************/
	//变动类型 [add_decrease]
	public static final String CHANGE_TYPE_ADD 		= "A";	// 增加
	public static final String CHANGE_TYPE_DECREASE = "D";	// 减少
	//操作人类型 [operater_type_admin]
	public static final String OPERATER_TYPE_STAFF 	= "U";	// 员工
	public static final String OPERATER_TYPE_SYS 	= "S";	// 系统
	//供应商信誉分变动原因 [lgt_si_credit_point_detail_changeReasonType]
	public static final String CRT_SUPPLIER_QUALIFIED 	= "A01";	// 供货合格
	public static final String CRT_SUPPLIER_UNQUALIFIED = "D01";	// 供货不合格
	
	public static final String CRT_SUPPLIER_ONTIME 	= "A02";	// 按时到货
	public static final String CRT_SUPPLIER_LATER = "D02";	// 延期到货
	
	public static final String SUPPLIER_DEFAULT_CREDIT_POINT = "DEFAULT"; //新增供应商时，默认供应商信誉积分
	
	public CreditPointDetail() {
		super();
	}

	public CreditPointDetail(String id){
		super(id);
	}

	@Length(min=1, max=64, message="供应商ID长度必须介于 1 和 64 之间")
	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=1, max=2, message="变动类型（增/减）长度必须介于 1 和 2 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	
	@NotNull(message="变动信誉分数量不能为空")
	public Integer getChangeCreditPoint() {
		return changeCreditPoint;
	}

	public void setChangeCreditPoint(Integer changeCreditPoint) {
		this.changeCreditPoint = changeCreditPoint;
	}
	
	@NotNull(message="变动后信誉分不能为空")
	public Integer getLastCreditPoint() {
		return lastCreditPoint;
	}

	public void setLastCreditPoint(Integer lastCreditPoint) {
		this.lastCreditPoint = lastCreditPoint;
	}
	
	@Length(min=1, max=10, message="变动原因长度必须介于 1 和 10 之间")
	public String getChangeReasonType() {
		return changeReasonType;
	}

	public void setChangeReasonType(String changeReasonType) {
		this.changeReasonType = changeReasonType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="变动时间不能为空")
	public Date getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(Date changeTime) {
		this.changeTime = changeTime;
	}
	
	@Length(min=1, max=2, message="操作人类型（员工/系统）长度必须介于 1 和 2 之间")
	public String getOperaterType() {
		return operaterType;
	}

	public void setOperaterType(String operaterType) {
		this.operaterType = operaterType;
	}
	
	@Length(min=0, max=64, message="来源业务编号长度必须介于 0 和 64 之间")
	public String getOperateSourceNo() {
		return operateSourceNo;
	}

	public void setOperateSourceNo(String operateSourceNo) {
		this.operateSourceNo = operateSourceNo;
	}
	
}