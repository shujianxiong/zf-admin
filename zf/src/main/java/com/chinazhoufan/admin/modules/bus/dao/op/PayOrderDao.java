/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.op;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.op.PayOrder;

/**
 * 付款单DAO接口
 * @author 张金俊
 * @version 2017-08-21
 */
@MyBatisDao
public interface PayOrderDao extends CrudDao<PayOrder> {

	List<PayOrder> findNotRefundListByOrder(Map<String, Object> map);
	
}