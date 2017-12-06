/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.pd;


import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.pd.Discount;

/**
 * 产品促销表DAO接口
 * @author liut
 * @version 2017-07-04
 */
@MyBatisDao
public interface DiscountDao extends CrudDao<Discount> {
	
	/**
	 * 根据产品促销主表获取查询条件
	 * @param discount
	 * @return
	 */
	public Discount getDiscountDetail(Discount discount);
	
}