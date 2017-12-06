/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ai;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ai.ActivityRecord;

/**
 * 活动参与记录DAO接口
 * @author 张金俊
 * @version 2017-08-04
 */
@MyBatisDao
public interface ActivityRecordDao extends CrudDao<ActivityRecord> {
	
}