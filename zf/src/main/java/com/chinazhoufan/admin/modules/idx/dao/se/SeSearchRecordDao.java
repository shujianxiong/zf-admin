/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.se;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.se.SeSearchRecord;

/**
 * 搜索记录表DAO接口
 * @author liut
 * @version 2016-10-27
 */
@MyBatisDao
public interface SeSearchRecordDao extends CrudDao<SeSearchRecord> {
	
}