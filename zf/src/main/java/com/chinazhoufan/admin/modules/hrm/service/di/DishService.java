/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.service.di;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.hrm.entity.di.Dish;
import com.chinazhoufan.admin.modules.hrm.dao.di.DishDao;

/**
 * 日常菜品Service
 * @author 张金俊
 * @version 2016-11-28
 */
@Service
@Transactional(readOnly = true)
public class DishService extends CrudService<DishDao, Dish> {

	public Dish get(String id) {
		return super.get(id);
	}
	
	public List<Dish> findList(Dish dish) {
		return super.findList(dish);
	}
	
	/**
	 * 查询菜品列表及当前登录人对应的评价
	 * @param dish
	 * @return
	 */
	public List<Dish> findListWithCurrentJudge(Dish dish) {
		return dao.findListWithCurrentJudge(dish);
	}
	
	public Page<Dish> findPage(Page<Dish> page, Dish dish) {
		return super.findPage(page, dish);
	}
	
	/**
	 * 查询菜品分页及当前登录人对应的评价
	 * @param page
	 * @param dish
	 * @return
	 */
	public Page<Dish> findPageWithCurrentJudge(Page<Dish> page, Dish dish) {
		dish.setPage(page);
		page.setList(dao.findListWithCurrentJudge(dish));
		return page;
	}
	
	/**
	 * 统计一段时间周期内菜品平均得分
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<Dish> countScore(Date beginDate, Date endDate) {
		List<Dish> dishs = dao.countScore(beginDate, endDate);
		return dishs;
	}
	
	@Transactional(readOnly = false)
	public void save(Dish dish) {
		super.save(dish);
	}
	
	@Transactional(readOnly = false)
	public void delete(Dish dish) {
		super.delete(dish);
	}
	
}