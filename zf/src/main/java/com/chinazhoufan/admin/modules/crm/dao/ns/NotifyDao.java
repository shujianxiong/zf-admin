/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.ns;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;

/**
 * 消息DAO接口
 * @author 张金俊
 * @version 2017-07-18
 */
@MyBatisDao
public interface NotifyDao extends CrudDao<Notify> {
	
	/**
	 * 查询某时间点之后的公告类消息
	 * @param notify
	 * @return
	 */
	public List<Notify> findAnnounceAfterTime(Notify notify);
	
	public int countByCode(@Param("messageCode")String messageCode, @Param("id")String id);

	public Notify getByCode(Map<String, Object> map);

	public int countByTargetTypeAndAction(@Param("remindTargetType")String remindTargetType, @Param("remindTargetAction")String remindTargetAction, @Param("id")String id);

	public Notify getByTargetTypeAndAction(Map<String, Object> map);
	
}