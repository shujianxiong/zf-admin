/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.bs;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import org.apache.ibatis.annotations.Param;

/**
 * 货品定损标准DAO接口
 * @author liut
 * @version 2016-11-19
 */
@MyBatisDao
public interface BreakdownStandardDao extends CrudDao<BreakdownStandard> {

    BreakdownStandard getByType(@Param("breakdownType") String breakdownType);
	
}