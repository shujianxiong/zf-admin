/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.bs;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Shop;

/**
 * 体验店（自提点）DAO接口
 * @author 张金俊
 * @version 2016-01-21
 */
@MyBatisDao
public interface ShopDao extends CrudDao<Shop> {
}