/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mb;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 会员魅力豆临时条目Entity
 * @author 张金俊
 * @version 2017-08-04
 */
public class BeansTemp extends DataEntity<BeansTemp> {
	
	private static final long serialVersionUID = 1L;
	private Beans beans;				// 魅力豆账户
	private Integer tempSerialNo;		// 账户条目序列号
	private String createType;			// 创建类型（U:员工 S:系统）
	private String changeType;			// 变动类型（增/减）
	private String changeReasonType;	// 变动原因
	private Integer num;				// 变动数量
	private String checkStatus;			// 审核状态
	private String checkBy;				// 审核者
	private Date checkTime;				// 审核时间

	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginTime;	//  变更 时间段查询
	private Date endTime;

	/******************************************** 自定义常量  *********************************************/
	public static final String STATUS_NEW		= "1";	//条目状态：新建
	public static final String STATUS_PASS 		= "2";	//条目状态：通过
	public static final String STATUS_REFUSE 	= "3";	//条目状态：拒绝
	
	
	public BeansTemp() {
		super();
	}

	public BeansTemp(String id){
		super(id);
	}

	
	@Length(min=1, max=64, message="魅力豆账户ID长度必须介于 1 和 64 之间")
	public Beans getBeans() {
		return beans;
	}

	public void setBeans(Beans beans) {
		this.beans = beans;
	}
	
	public Integer getTempSerialNo() {
		return tempSerialNo;
	}

	public void setTempSerialNo(Integer tempSerialNo) {
		this.tempSerialNo = tempSerialNo;
	}
	
	@Length(min=1, max=2, message="创建类型（U:员工 S:系统）长度必须介于 1 和 2 之间")
	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}
	
	@Length(min=1, max=2, message="变动类型（增/减）长度必须介于 1 和 2 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
	
	@Length(min=1, max=10, message="变动原因长度必须介于 1 和 10 之间")
	public String getChangeReasonType() {
		return changeReasonType;
	}

	public void setChangeReasonType(String changeReasonType) {
		this.changeReasonType = changeReasonType;
	}
	
	@NotNull(message="变动数量不能为空")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	@Length(min=1, max=2, message="审核状态长度必须介于 1 和 2 之间")
	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public String getCheckBy() {
		return checkBy;
	}

	public void setCheckBy(String checkBy) {
		this.checkBy = checkBy;
	}

	@Length(min=0, max=64, message="审核者长度必须介于 0 和 64 之间")

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
}