/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.tf;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.tf.TransportFee;

/**
 * 运费模板DAO接口
 * @author 张金俊
 * @version 2016-12-03
 */
@MyBatisDao
public interface TransportFeeDao extends CrudDao<TransportFee> {
	
}