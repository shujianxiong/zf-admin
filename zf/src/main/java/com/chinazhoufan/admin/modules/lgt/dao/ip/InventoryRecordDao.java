/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ip;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryRecord;

/**
 * 盘点记录DAO接口
 * @author 张金俊
 * @version 2016-03-17
 */
@MyBatisDao
public interface InventoryRecordDao extends CrudDao<InventoryRecord> {
	
	/**
	 * （物理）删除盘点记录
	 * @param inventoryRecord 盘点记录
	 */
	public void remove(InventoryRecord inventoryRecord);
	
	/**
	 * （物理）删除盘点任务下的所有盘点记录
	 * @param mid 盘点任务ID
	 */
	public void removeByInventoryMissionId(@Param("mid") String mid);
}