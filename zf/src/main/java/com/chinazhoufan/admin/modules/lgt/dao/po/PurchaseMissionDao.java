/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.po;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMission;

/**
 * 采购任务DAO接口
 * @author 张金俊
 * @version 2016-03-31
 */
@MyBatisDao
public interface PurchaseMissionDao extends CrudDao<PurchaseMission> {

	/**
	 * 查询采购任务及任务明细
	 * @param id
	 * @return
	 */
	public PurchaseMission getWithDetail(String id);
	
	/**
	 * 查询采购任务及任务明细
	 * @param id
	 * @return
	 */
	public PurchaseMission getWithOrder(String id);
	
	/**
	 * 查询采购任务及任务订单
	 * @param purchaseMission
	 * @return
	 */
	public List<PurchaseMission> findWithOrder(PurchaseMission purchaseMission);

	/**
	 * 更新采购任务状态（根据ID只更新状态）
	 * @param purchaseMission 
	 */
	public void updateMissionStatus(PurchaseMission purchaseMission);
	
	/**
	 * （物理）删除采购任务
	 * @param purchaseMission 采购任务
	 */
	public void remove(PurchaseMission purchaseMission);

	/**
	 * 保存审批结果
	 * @param purchaseMission    设定文件
	 * @throws
	 */
	public void saveCheckResult(PurchaseMission purchaseMission);

	/**
	 * 修改备注
	 * @param purchaseMission    设定文件
	 * @throws
	 */
	public void updateRemarks(PurchaseMission purchaseMission);

}