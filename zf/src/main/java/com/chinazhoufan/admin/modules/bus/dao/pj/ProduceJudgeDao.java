/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.pj;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudge;

/**
 * 产品评价DAO接口
 * @author liut
 * @version 2017-07-28
 */
@MyBatisDao
public interface ProduceJudgeDao extends CrudDao<ProduceJudge> {
	
	/**
	 * 通过体验单ID查询评价
	 * @param experienceOrderId
	 * @return
	 */
	public ProduceJudge getByExperienceOrderId(String experienceOrderId);
}