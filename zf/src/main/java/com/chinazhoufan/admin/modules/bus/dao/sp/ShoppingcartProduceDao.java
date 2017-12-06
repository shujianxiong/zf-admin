/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.sp;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.sp.ShoppingcartProduce;

/**
 * 购物车产品表DAO接口
 * @author liut
 * @version 2016-12-02
 */
@MyBatisDao
public interface ShoppingcartProduceDao extends CrudDao<ShoppingcartProduce> {
	
}