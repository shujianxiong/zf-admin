/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.service.di;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.hrm.entity.di.Diet;
import com.chinazhoufan.admin.modules.hrm.dao.di.DietDao;

/**
 * 日常菜谱Service
 * @author 张金俊
 * @version 2016-11-28
 */
@Service
@Transactional(readOnly = true)
public class DietService extends CrudService<DietDao, Diet> {

	public Diet get(String id) {
		return super.get(id);
	}
	
	public List<Diet> findList(Diet diet) {
		return super.findList(diet);
	}
	
	/**
	 * 查询菜谱列表及当前登录人对应的评价
	 * @param diet
	 * @return
	 */
	public List<Diet> findListWithCurrentJudge(Diet diet) {
		return dao.findListWithCurrentJudge(diet);
	}
	
	public Page<Diet> findPage(Page<Diet> page, Diet diet) {
		return super.findPage(page, diet);
	}
	
	/**
	 * 查询菜谱分页及当前登录人对应的评价
	 * @param page
	 * @param diet
	 * @return
	 */
	public Page<Diet> findPageWithCurrentJudge(Page<Diet> page, Diet diet) {
		diet.setPage(page);
		page.setList(dao.findListWithCurrentJudge(diet));
		return page;
	}
	
	/**
	 * 统计一段时间周期内菜谱平均得分
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public BigDecimal countScore(Date beginDate, Date endDate) {
		BigDecimal dietScore = dao.countScore(beginDate, endDate);
		return dietScore;
	}
	
	@Transactional(readOnly = false)
	public void save(Diet diet) {
		super.save(diet);
	}
	
	@Transactional(readOnly = false)
	public void delete(Diet diet) {
		super.delete(diet);
	}
	
}