/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.dp;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.dao.BasMissionDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;

/**
 * 调货任务DAO接口
 * @author 刘晓东
 * @version 2015-10-20
 */
@MyBatisDao
public interface DispatchMissionDao extends BasMissionDao<DispatchMission> {
	
	public DispatchMission getByChildId(String id) ;
	
	public DispatchMission getMissionWithProductAndProduceById(DispatchMission dispatchMission);
	
	public DispatchMission findMissionWithProductAndProduceBySearchParam(DispatchMission dispatchMission);
	
	/**
	 * 根据任务ID，获取任务明细
	 * @param dispatchMission
	 * @return
	 */
	public DispatchMission getDispatchMissionWithDetailAll(DispatchMission dispatchMission);
	
	/**
	 * 根据任务ID和调货单ID，获取对应的任务明细
	 * @param dispatchMission
	 * @return
	 */
	public DispatchMission getDispatchMissionWithDetail(DispatchMission dispatchMission);
	
	/**
	 * 查询我的调出  调拨单
	 * @param dispatchMission
	 * @return
	 */
	public List<DispatchMission> findPageOutUserList(DispatchMission dispatchMission);
	
}