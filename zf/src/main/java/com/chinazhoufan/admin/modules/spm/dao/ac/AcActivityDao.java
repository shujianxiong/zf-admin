/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ac;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;

/**
 * 调研活动表DAO接口
 * @author liut
 * @version 2016-05-19
 */
@MyBatisDao
public interface AcActivityDao extends CrudDao<AcActivity> {

	List<Prize> getPrizeByActivityId(String activityId);
	
}