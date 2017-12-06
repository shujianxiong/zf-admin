/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.entity.di;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 日常菜谱Entity
 * @author 张金俊
 * @version 2016-11-28
 */
public class Diet extends DataEntity<Diet> {
	
	private static final long serialVersionUID = 1L;
	private Date date;					// 所属日期
	private BigDecimal score;			// 评价得分
	
	/******************************* 自定义查询条件  ********************************/
	private BigDecimal beginScore;		// 开始 评价得分
	private BigDecimal endScore;		// 结束 评价得分
	/******************************* 自定义关联对象  ********************************/
	private DietJudge dietJudge;		// 当前用户的菜谱评价
	
	
	public Diet() {
		super();
	}

	public Diet(String id){
		super(id);
	}
	

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="所属日期不能为空")
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public BigDecimal getScore() {
		return score;
	}

	public void setScore(BigDecimal score) {
		this.score = score;
	}
	
	public BigDecimal getBeginScore() {
		return beginScore;
	}

	public void setBeginScore(BigDecimal beginScore) {
		this.beginScore = beginScore;
	}
	
	public BigDecimal getEndScore() {
		return endScore;
	}

	public void setEndScore(BigDecimal endScore) {
		this.endScore = endScore;
	}

	public DietJudge getDietJudge() {
		return dietJudge;
	}

	public void setDietJudge(DietJudge dietJudge) {
		this.dietJudge = dietJudge;
	}
		
}