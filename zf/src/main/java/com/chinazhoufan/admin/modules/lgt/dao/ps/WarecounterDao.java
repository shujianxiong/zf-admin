/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warecounter;

/**
 * 货屉列表DAO接口
 * @author 贾斌
 * @version 2015-10-15
 */
@MyBatisDao
public interface WarecounterDao extends CrudDao<Warecounter> {
	
	/**
	 * （在坏货货架中）根据仓库、所属供应商、所属分类查询对应货屉
	 * @param warehouseId	仓库ID
	 * @param supplierId	供应商ID
	 * @param categoryId	分类ID
	 * @return
	 */
	public Warecounter getBroken(@Param("warehouseId") String warehouseId, @Param("supplierId") String supplierId, @Param("categoryId") String categoryId);

	public int countByWarearea(Map<String, Object> map);
	
}