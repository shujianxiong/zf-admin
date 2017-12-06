/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.di;

import java.math.BigDecimal;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.di.DietJudge;

/**
 * 日常菜谱评价DAO接口
 * @author 张金俊
 * @version 2016-11-28
 */
@MyBatisDao
public interface DietJudgeDao extends CrudDao<DietJudge> {
	
	/**
	 * 根据菜谱ID获取该菜谱评价级别的平均值（四舍五入保留两位小数）
	 * @param dietId	菜谱ID
	 * @return
	 */
	public BigDecimal getComputedScoreByDietId(String dietId);
}