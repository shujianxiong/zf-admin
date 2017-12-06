/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductCodeChange;

/**
 * 货品编码变动记录DAO接口
 * @author 张金俊
 * @version 2017-04-20
 */
@MyBatisDao
public interface ProductCodeChangeDao extends CrudDao<ProductCodeChange> {
	
}