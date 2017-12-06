/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.entity.fd;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 免押金活动配置表Entity
 * @author liuxiaodong
 * @version 2017-10-15
 */
public class FreeDeposit extends DataEntity<FreeDeposit> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private String summary;		// 简介
	private Date startTime;		// 开始时间
	private Date endTime;		// 结束时间
	private Integer registerPlaces;		// 注册名额比例
	private Integer places;		// 总名额
	private Integer initPlaces;		// 初始名额
	private Integer surplusPlaces;		// 剩余名额
	private Integer registerNum;
	private String activeFlag;		// 启用状态
	
	public FreeDeposit() {
		super();
	}

	public FreeDeposit(String id){
		super(id);
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=500, message="简介长度必须介于 1 和 500 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开始时间不能为空")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=1, max=1, message="启用状态长度必须介于 1 和 1 之间")
	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Integer getRegisterPlaces() {
		return registerPlaces;
	}

	public void setRegisterPlaces(Integer registerPlaces) {
		this.registerPlaces = registerPlaces;
	}

	public Integer getPlaces() {
		return places;
	}

	public void setPlaces(Integer places) {
		this.places = places;
	}

	public Integer getInitPlaces() {
		return initPlaces;
	}

	public void setInitPlaces(Integer initPlaces) {
		this.initPlaces = initPlaces;
	}

	public Integer getSurplusPlaces() {
		return surplusPlaces;
	}

	public void setSurplusPlaces(Integer surplusPlaces) {
		this.surplusPlaces = surplusPlaces;
	}

	public Integer getRegisterNum() {
		return registerNum;
	}

	public void setRegisterNum(Integer registerNum) {
		this.registerNum = registerNum;
	}
	
	
}