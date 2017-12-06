/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.oe;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;

/**
 * 体验单DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface ExperienceOrderTaskDao extends CrudDao<ExperienceOrder> {

	/**
	 * 查询已送达的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findArrived(ExperienceOrder experienceOrder);
	
	/**
	 * 对所有已送达的体验订单进行确认收货，同时设置体验开始日期为当前日期
	 * @param experienceOrder
	 */
	public void updateArrivedToExperiencing(ExperienceOrder experienceOrder);
	
	/**
	 * 查询所有超过最长体验期的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findExpired(ExperienceOrder experienceOrder);
	
	/**
	 * 查询所有距离体验到期剩余时长为remainDays天的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findByRemainDays(ExperienceOrder experienceOrder);
	
	/**
	 * 查询所有超过体验期时长为pastDays天的体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findByPastDays(ExperienceOrder experienceOrder);
	
	/**
	 * 查询所有到达预约体验日期、已到货还未支付尾款的预约体验订单
	 * @param experienceOrder
	 * @return
	 */
	public List<ExperienceOrder> findAppointToClose(ExperienceOrder experienceOrder);
	
	
	/**
	 * 取消所有到达预约体验日期、已到货还未支付尾款的预约体验订单
	 * @param experienceOrder
	 * @return
	 */
	public void updateAppointToClose(ExperienceOrder experienceOrder);

	/**
	 * 查询欠款一天订单
	 * @return
	 * @param map
	 */
    List<ExperienceOrder> findOneDayDebt(Map<String, Object> map);

	/**
	 * 查询欠款一周订单
	 * @return
	 * @param map
	 */
	List<ExperienceOrder> findOneWeekDebt(Map<String, Object> map);

    List<ExperienceOrder> findAppointPay(ExperienceOrder experienceOrder);

	List<ExperienceOrder> findListByPastSevenDays();
}
