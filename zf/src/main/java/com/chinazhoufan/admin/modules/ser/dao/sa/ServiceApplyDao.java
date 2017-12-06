/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.dao.sa;

import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;

/**
 * 服务申请DAO接口
 * @author 张金俊
 * @version 2017-08-14
 */
@MyBatisDao
public interface ServiceApplyDao extends CrudDao<ServiceApply> {

    Integer getCountByMemAndType(ServiceApply serviceApply);

	int countByOrderId(Map<String, Object> map);

    int countByApplyBy(Map<String, Object> map);
}