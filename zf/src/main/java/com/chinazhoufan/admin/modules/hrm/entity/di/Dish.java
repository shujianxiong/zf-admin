/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.entity.di;

import java.math.BigDecimal;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 日常菜品Entity
 * @author 张金俊
 * @version 2016-11-28
 */
public class Dish extends DataEntity<Dish> {
	
	private static final long serialVersionUID = 1L;
	private Diet diet;					// 日常菜谱
	private String type;				// 三餐类型
	private String name;				// 菜品名称
	private BigDecimal score;			// 评价得分
	
	// 三餐类型 [hrm_di_mealType]
	/******************************* 自定义查询条件  ********************************/
	private BigDecimal beginScore;		// 开始 评价得分
	private BigDecimal endScore;		// 结束 评价得分
	/******************************* 自定义关联对象  ********************************/
	private DishJudge dishJudge;		// 当前用户的菜品评价
	
	
	public Dish() {
		super();
	}

	public Dish(String id){
		super(id);
	}

	public Dish(Diet diet){
		super();
		this.diet = diet;
	}
	
	
	public Diet getDiet() {
		return diet;
	}

	public void setDiet(Diet diet) {
		this.diet = diet;
	}
	
	@Length(min=1, max=2, message="三餐类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=100, message="菜品名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public DishJudge getDishJudge() {
		return dishJudge;
	}

	public void setDishJudge(DishJudge dishJudge) {
		this.dishJudge = dishJudge;
	}
		
}