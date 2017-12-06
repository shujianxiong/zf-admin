/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.po;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMissionDetail;

/**
 * 采购任务产品DAO接口
 * @author 张金俊
 * @version 2016-04-13
 */
@MyBatisDao
public interface PurchaseMissionDetailDao extends CrudDao<PurchaseMissionDetail> {
	
	/**
	 * （物理）删除采购任务产品记录
	 * @param inventoryRecord 采购任务产品记录
	 */
	public void remove(PurchaseMissionDetail purchaseMissionDetail);
	
	/**
	 * （物理）删除采购任务下的所有采购任务产品记录
	 * @param mid 采购任务ID
	 */
	public void removeByPurchaseMissionId(@Param("mid") String mid);
}