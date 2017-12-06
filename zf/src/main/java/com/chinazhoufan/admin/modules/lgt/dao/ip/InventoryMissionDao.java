/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ip;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryMission;

/**
 * 盘点任务DAO接口
 * @author 张金俊
 * @version 2016-03-17
 */
@MyBatisDao
public interface InventoryMissionDao extends CrudDao<InventoryMission> {
	
	/**
	 * 查询盘点任务详细数据（包含盘点任务数据、盘点明细记录数据及相关数据）
	 * <如果inventoryUserId不为空则过滤盘点人非该盘点人的明细>
	 * @param id 盘点任务ID
	 * @param inventoryUserId 盘点人ID
	 * @return
	 */
	public InventoryMission getInfo(@Param("id") String id, @Param("inventoryUserId") String inventoryUserId);
	
	/**
	 * 根据盘点人ID，查询包含的明细中有该盘点人的明细的（非新建状态）盘点任务
	 * @param inventoryMission
	 * @param inventoryUserId
	 * @return
	 */
	public List<InventoryMission> findPageNotNewForInventoryUser(@Param("mission") InventoryMission inventoryMission, @Param("uid") String inventoryUserId);
	
	/**
	 * （物理）删除盘点任务
	 * @param inventoryMission 盘点任务
	 */
	public void remove(InventoryMission inventoryMission);
	
}