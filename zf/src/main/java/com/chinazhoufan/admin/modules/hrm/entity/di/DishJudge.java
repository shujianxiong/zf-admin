/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.entity.di;

import org.hibernate.validator.constraints.Length;
import com.chinazhoufan.admin.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 日常菜品评价Entity
 * @author 张金俊
 * @version 2016-11-28
 */
public class DishJudge extends DataEntity<DishJudge> {
	
	private static final long serialVersionUID = 1L;
	private Dish dish;				// 日常菜品
	private User judgeBy;			// 评价人
	private String judgeLevel;		// 评价级别
	
	// 评价级别 [hrm_di_judgeLevel]
	
	
	
	public DishJudge() {
		super();
	}

	public DishJudge(String id){
		super(id);
	}
	

	public Dish getDish() {
		return dish;
	}

	public void setDish(Dish dish) {
		this.dish = dish;
	}
	
	@NotNull(message="评价人不能为空")
	public User getJudgeBy() {
		return judgeBy;
	}

	public void setJudgeBy(User judgeBy) {
		this.judgeBy = judgeBy;
	}
	
	@Length(min=1, max=2, message="评价级别长度必须介于 1 和 2 之间")
	public String getJudgeLevel() {
		return judgeLevel;
	}

	public void setJudgeLevel(String judgeLevel) {
		this.judgeLevel = judgeLevel;
	}
	
}