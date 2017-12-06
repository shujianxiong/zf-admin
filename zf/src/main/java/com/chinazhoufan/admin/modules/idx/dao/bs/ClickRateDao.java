/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.bs;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.bs.ClickRate;

/**
 * 频道场景点击量DAO接口
 * @author liut
 * @version 2016-11-28
 */
@MyBatisDao
public interface ClickRateDao extends CrudDao<ClickRate> {
	
}