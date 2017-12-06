/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;

/**
 * 货品出入库记录DAO接口
 * @author 张金俊
 * @version 2015-11-09
 */
@MyBatisDao
public interface ProductWpIoDao extends CrudDao<ProductWpIo> {
	
	/**
	 * 根据业务编号删除货品对应的出入库记录
	 * @param businessId
	 */
	public void removeProductWpIoByBusinessId(@Param("businessId")String businessId);
}