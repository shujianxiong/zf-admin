/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.ns;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.entity.ns.Subscribe;

/**
 * 订阅DAO接口
 * @author 张金俊
 * @version 2017-07-18
 */
@MyBatisDao
public interface SubscribeDao extends CrudDao<Subscribe> {
	
	/**
	 * 根据订阅及消息的条件，查询订阅记录（及消息数据）
	 * @param subscribe
	 * @param notify
	 * @return
	 */
	public List<Subscribe> findBySubscribeAndNotify(@Param("subscribe")Subscribe subscribe, @Param("notify")Notify notify);
	
	/**
	 * 根据订阅及消息的条件，更新订阅记录状态
	 * @param status	将更新的状态
	 * @param currDate	将更新的更新时间
	 * @param subscribe
	 * @param notify
	 * @return
	 */
	public void updateStatusBySubscribeAndNotify(@Param("status")String status, @Param("currDate")Date currDate, @Param("subscribe")Subscribe subscribe, @Param("notify")Notify notify);
	
	/**
	 * 查询“产品到货提醒”类订阅
	 */
	public List<Subscribe> findWithNotifyAndProduce(Subscribe subscribe);
	
}