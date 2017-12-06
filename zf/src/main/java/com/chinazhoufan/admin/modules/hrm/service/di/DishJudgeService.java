/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.service.di;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.hrm.entity.di.Dish;
import com.chinazhoufan.admin.modules.hrm.entity.di.DishJudge;
import com.chinazhoufan.admin.modules.hrm.dao.di.DishJudgeDao;

/**
 * 日常菜品评价Service
 * @author 张金俊
 * @version 2016-11-28
 */
@Service
@Transactional(readOnly = true)
public class DishJudgeService extends CrudService<DishJudgeDao, DishJudge> {
	
	@Autowired
	private DishService dishService;

	public DishJudge get(String id) {
		return super.get(id);
	}
	
	public List<DishJudge> findList(DishJudge dishJudge) {
		return super.findList(dishJudge);
	}
	
	public Page<DishJudge> findPage(Page<DishJudge> page, DishJudge dishJudge) {
		return super.findPage(page, dishJudge);
	}
	
	@Transactional(readOnly = false)
	public void save(DishJudge dishJudge) {
		super.save(dishJudge);
	}
	
	/**
	 * 保存菜品评价，更新对应菜品的评价得分
	 * @param dietJudge
	 */
	@Transactional(readOnly = false)
	public BigDecimal judgeSave(DishJudge dishJudge) {
		// 保存用户当前菜品评价
		super.save(dishJudge);
		
		// 更新菜品评价得分
		Dish dish = dishService.get(dishJudge.getDish());
		BigDecimal score = dao.getComputedScoreByDishId(dish.getId());
		dish.setScore(score);
		dishService.save(dish);
		return score;
	}
	
	@Transactional(readOnly = false)
	public void delete(DishJudge dishJudge) {
		super.delete(dishJudge);
	}
	
}