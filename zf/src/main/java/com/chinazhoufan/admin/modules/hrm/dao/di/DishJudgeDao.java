/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.di;

import java.math.BigDecimal;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.di.DishJudge;

/**
 * 日常菜品评价DAO接口
 * @author 张金俊
 * @version 2016-11-28
 */
@MyBatisDao
public interface DishJudgeDao extends CrudDao<DishJudge> {
	
	/**
	 * 根据菜品ID获取该菜品评价级别的平均值（四舍五入保留两位小数）
	 * @param dishId	菜品ID
	 * @return
	 */
	public BigDecimal getComputedScoreByDishId(String dishId);
}