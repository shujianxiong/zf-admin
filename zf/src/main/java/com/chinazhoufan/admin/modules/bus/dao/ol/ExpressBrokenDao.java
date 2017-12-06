/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ol;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.ExpressBroken;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 快递包裹损坏记录DAO接口
 * @author 张金俊
 * @version 2017-08-14
 */
@MyBatisDao
public interface ExpressBrokenDao extends CrudDao<ExpressBroken> {

    public ExpressBroken findByReturnOrderId(@Param("orderId")String orderId);

}