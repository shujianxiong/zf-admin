/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao.gold;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.gold.BasGoldPriceGather;

/**
 * 实时金价采集列表DAO接口
 * @author 贾斌
 * @version 2015-11-04
 */
@MyBatisDao
public interface BasGoldPriceGatherDao extends CrudDao<BasGoldPriceGather> {
	
}