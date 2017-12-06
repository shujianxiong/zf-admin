/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.dao.di;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.hrm.entity.di.Diet;

/**
 * 日常菜谱DAO接口
 * @author 张金俊
 * @version 2016-11-28
 */
@MyBatisDao
public interface DietDao extends CrudDao<Diet> {
	
	/**
	 * 查询菜谱列表及当前登录人对应的评价
	 * @param diet
	 * @return
	 */
	public List<Diet> findListWithCurrentJudge(Diet diet);
	
	/**
	 * 统计一段时间周期内菜谱平均得分
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public BigDecimal countScore(@Param("beginDate") Date beginDate, @Param("endDate") Date endDate);
}