/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;

/**
 * 货品货位调整记录查询DAO接口
 * @author 陈适
 * @version 2015-12-04
 */
@MyBatisDao
public interface ProductWpChangeDao extends CrudDao<ProductWpChange> {
	
	/**
	 * 获取货品最后一条“出库”的货位变动记录
	 * @param productId
	 * @return
	 */
	public ProductWpChange getLastOutChange(String productId);
}