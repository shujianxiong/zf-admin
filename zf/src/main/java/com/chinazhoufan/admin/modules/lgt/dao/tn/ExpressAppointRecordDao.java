/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.tn;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressAppointRecord;
import org.apache.ibatis.annotations.Param;

/**
 * 快递预约记录DAO接口
 * @author liut
 * @version 2017-05-24
 */
@MyBatisDao
public interface ExpressAppointRecordDao extends CrudDao<ExpressAppointRecord> {

    ExpressAppointRecord getByExpressOrderId(@Param("expressOrderId") String expressOrderId);
}