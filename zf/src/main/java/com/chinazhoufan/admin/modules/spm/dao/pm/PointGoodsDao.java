/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.pm;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.pm.PointGoods;

/**
 * 积分商品DAO接口
 * @author 张金俊
 * @version 2016-12-02
 */
@MyBatisDao
public interface PointGoodsDao extends CrudDao<PointGoods> {
	
	public void updateUpFlag(PointGoods pointGoods);
}