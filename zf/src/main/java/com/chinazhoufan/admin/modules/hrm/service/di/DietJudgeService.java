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
import com.chinazhoufan.admin.modules.hrm.entity.di.Diet;
import com.chinazhoufan.admin.modules.hrm.entity.di.DietJudge;
import com.chinazhoufan.admin.modules.hrm.dao.di.DietJudgeDao;

/**
 * 日常菜谱评价Service
 * @author 张金俊
 * @version 2016-11-28
 */
@Service
@Transactional(readOnly = true)
public class DietJudgeService extends CrudService<DietJudgeDao, DietJudge> {

	@Autowired
	private DietService dietService;
	
	
	public DietJudge get(String id) {
		return super.get(id);
	}
	
	public List<DietJudge> findList(DietJudge dietJudge) {
		return super.findList(dietJudge);
	}
	
	public Page<DietJudge> findPage(Page<DietJudge> page, DietJudge dietJudge) {
		return super.findPage(page, dietJudge);
	}
	
	@Transactional(readOnly = false)
	public void save(DietJudge dietJudge) {
		super.save(dietJudge);
	}
	
	/**
	 * 保存菜谱评价，更新对应菜谱的评价得分
	 * @param dietJudge
	 */
	@Transactional(readOnly = false)
	public BigDecimal judgeSave(DietJudge dietJudge) {
		// 保存用户当前菜谱评价
		super.save(dietJudge);
		
		// 更新菜谱评价得分
		Diet diet = dietService.get(dietJudge.getDiet());
		BigDecimal score = dao.getComputedScoreByDietId(diet.getId());
		diet.setScore(score);
		dietService.save(diet);
		return score;
	}
	
	@Transactional(readOnly = false)
	public void delete(DietJudge dietJudge) {
		super.delete(dietJudge);
	}
	
}