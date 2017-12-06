/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.di;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.di.Dish;

/**
 * 日常菜品DAO接口
 * @author 张金俊
 * @version 2016-11-28
 */
@MyBatisDao
public interface DishDao extends CrudDao<Dish> {
	
	/**
	 * 查询菜品列表及当前登录人对应的评价
	 * @param dish
	 * @return
	 */
	public List<Dish> findListWithCurrentJudge(Dish dish);
	
	/**
	 * 统计一段时间周期内菜品平均得分
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<Dish> countScore(@Param("beginDate") Date beginDate, @Param("endDate") Date endDate);
}