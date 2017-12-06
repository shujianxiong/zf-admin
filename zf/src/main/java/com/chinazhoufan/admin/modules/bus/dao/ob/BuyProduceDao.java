/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ob;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyProduce;

import java.util.Map;

/**
 * 购买产品DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface BuyProduceDao extends CrudDao<BuyProduce> {

    int getTotalNumByMember(Map<String, Object> map);
}