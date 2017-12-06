/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.List;

import com.google.common.collect.Lists;

/**
 * 货品质检单管理Entity
 * @author 刘晓东
 * @version 2015-10-13
 */
public class QualitycheckOrder extends DataEntity<QualitycheckOrder> {
	
	private static final long serialVersionUID = 1L;
	private String qcBusinessType;		// 质检类型（出库/交货）
	private String qcBusinessId;     //质检业务类型对应的单据编号
	private String qcStatus;		// 质检状态 0 待质检 1 质检中  2 质检完
	private User qcUser;		// 质检员工
	private Date qcTime;		// 质检时间
	private String weighFlag;		// 是否称重 1 是  0 否
	private String surfacecheckFlag;		// 是否检验外观 1 是  0 否
	private String codecheckFlag;		// 是否核对裸石编码 1 是  0 否
	private Date finishTime;		// 完成时间
	private String qcResult;		// 质检结果  0 不合格 1 部分合格 2 不合格
	
	//====仅供查询使用的字段，非数据库中对应的
	private Date beginQcTime;		// 开始 质检时间
	private Date endQcTime;		// 结束 质检时间
	private Date beginFinishTime;		// 开始 完成时间
	private Date endFinishTime;		// 结束 完成时间 
	
	private List<QualitycheckDetail> qualitycheckDetailList = Lists.newArrayList();		// 子表列表
	
	
	public static final String QCSTATUS_WAIT = "0";//待质检
	public static final String QCSTATUS_ING = "1"; //质检中
	public static final String QCSTATUS_OVER = "2";//质检完成
	
	public static final String QCRESULT_FAIL = "0"; //不合格
	public static final String QCRESULT_LITTLEOK = "1";//部分合格
	public static final String QCRESULT_OK = "2";	//全部合格
	
	public static final String QCBUSINESSTYPE_OUT = "1";//出库质检
	public static final String QCBUSINESSTYPE_IN = "2";//交货质检
	
	//供显示用的对象
	private String batchNo;//质检单对应的批次编号
	
	public QualitycheckOrder() {
		super();
	}

	public QualitycheckOrder(String id){
		super(id);
	}

	@NotEmpty(message="质检类型不能为空")
	@Length(min=1, max=2, message="质检类型长度必须介于 1 和 2 之间")
	public String getQcBusinessType() {
		return qcBusinessType;
	}

	public void setQcBusinessType(String qcBusinessType) {
		this.qcBusinessType = qcBusinessType;
	}
	
	public String getQcStatus() {
		return qcStatus;
	}

	public void setQcStatus(String qcStatus) {
		this.qcStatus = qcStatus;
	}
	
	public User getQcUser() {
		return qcUser;
	}

	public void setQcUser(User qcUser) {
		this.qcUser = qcUser;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getQcTime() {
		return qcTime;
	}

	public void setQcTime(Date qcTime) {
		this.qcTime = qcTime;
	}
	
	@NotEmpty(message="是否称重不能为空")
	@Length(min=1, max=1, message="是否称重长度必须介于 1 和 1 之间")
	public String getWeighFlag() {
		return weighFlag;
	}

	public void setWeighFlag(String weighFlag) {
		this.weighFlag = weighFlag;
	}
	
	@NotEmpty(message="是否检验外观长度不能为空")
	@Length(min=1, max=1, message="是否检验外观长度必须介于 1 和 1 之间")
	public String getSurfacecheckFlag() {
		return surfacecheckFlag;
	}

	public void setSurfacecheckFlag(String surfacecheckFlag) {
		this.surfacecheckFlag = surfacecheckFlag;
	}
	
	@NotEmpty(message="是否核对裸石编码不能为空")
	@Length(min=1, max=1, message="是否核对裸石编码长度必须介于 1 和 1 之间")
	public String getCodecheckFlag() {
		return codecheckFlag;
	}

	public void setCodecheckFlag(String codecheckFlag) {
		this.codecheckFlag = codecheckFlag;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}
	
	public String getQcResult() {
		return qcResult;
	}

	public void setQcResult(String qcResult) {
		this.qcResult = qcResult;
	}
	
	public Date getBeginQcTime() {
		return beginQcTime;
	}

	public void setBeginQcTime(Date beginQcTime) {
		this.beginQcTime = beginQcTime;
	}
	
	public Date getEndQcTime() {
		return endQcTime;
	}

	public void setEndQcTime(Date endQcTime) {
		this.endQcTime = endQcTime;
	}
		
	public Date getBeginFinishTime() {
		return beginFinishTime;
	}

	public void setBeginFinishTime(Date beginFinishTime) {
		this.beginFinishTime = beginFinishTime;
	}
	
	public Date getEndFinishTime() {
		return endFinishTime;
	}

	public void setEndFinishTime(Date endFinishTime) {
		this.endFinishTime = endFinishTime;
	}

	public List<QualitycheckDetail> getQualitycheckDetailList() {
		return qualitycheckDetailList;
	}

	public void setQualitycheckDetailList(
			List<QualitycheckDetail> qualitycheckDetailList) {
		this.qualitycheckDetailList = qualitycheckDetailList;
	}

	public String getQcBusinessId() {
		return qcBusinessId;
	}

	public void setQcBusinessId(String qcBusinessId) {
		this.qcBusinessId = qcBusinessId;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	
	
}