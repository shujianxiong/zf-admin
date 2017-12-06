/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.gd;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;

/**
 * 搭配DAO接口
 * @author liut
 * @version 2017-03-15
 */
@MyBatisDao
public interface CollocationDao extends CrudDao<Collocation> {
	
	/**
	 * 根据ID获取完整的搭配信息，包括搭配小分组及其对应的相关商品信息
	 * @param collocation
	 * @return    设定文件
	 * @throws
	 */
	public Collocation getCollocationWithDetail(Collocation collocation);
	
	
}