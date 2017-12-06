/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.pd;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountProperty;

/**
 * 产品筛选属性DAO接口
 * @author liut
 * @version 2017-07-04
 */
@MyBatisDao
public interface DiscountPropertyDao extends CrudDao<DiscountProperty> {
	
}