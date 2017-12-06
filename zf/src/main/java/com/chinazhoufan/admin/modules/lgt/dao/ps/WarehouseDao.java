/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 仓库管理DAO接口
 * @author 贾斌
 * @version 2015-10-15
 */
@MyBatisDao
public interface WarehouseDao extends CrudDao<Warehouse> {

	/**
	 * 查询默认仓库（未删除、已启用、排序第一）
	 * @param wareplaceId
	 * @return
	 */
	public Warehouse getDefault();
	
	/**
	 * 根据货位id 查询所属仓库
	 * @param wareplaceId
	 * @return
	 */
	public Warehouse findWareHouseByWareplaceId(String wareplaceId);

	/**
	 * 根据仓库查询仓库下所有区域、货架、货位集合
	 * @param house
	 * @return
	 */
	public List<Warehouse> findWareHourseById(String id);

	/**
	 * 根据货位获取监控仓库
	 * @param ioWareplace
	 * @return
	 */
	public Warehouse getByWareplace(Wareplace ioWareplace);

	/**
	 * 根据仓库ID伪删除关联的仓库货架数据
	 * @param warehouse
	 */
	public void deleteWareareaByWhouseId(Warehouse warehouse);
	
	/**
	 * 根据仓库ID伪删除关联的货屉数据
	 * @param warehouse
	 */
	public void deleteWarecounterByWhouseId(Warehouse warehouse);
	
	/**
	 * 根据仓库ID伪删除管理端额货位数据
	 * @param warehouse
	 */
	public void deleteWareplaceByWhouseId(Warehouse warehouse);
	
}