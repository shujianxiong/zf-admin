/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ob;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;

/**
 * 购买单DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface BuyOrderDao extends CrudDao<BuyOrder> {
	
	/**
	 * 根据订单ID获取订单及关联的订单产品信息
	 * @param buyOrder
	 * @return
	 */
	public BuyOrder getDetail(BuyOrder buyOrder);
	
	

//	/**
//	 * 根据预购单里面的产品ID ，更新预约到货状态
//	 * @param buyOrder
//	 */
//	public void updateAppointStockStatusByProduce(BuyOrder buyOrder);
	
	
	/**
	 * 统计购买单里面当天的成交量，包括预约购买
	 * @param buyOrder
	 * @return
	 */
	public Integer statBuyOrderDayTradingVolume(BuyOrder buyOrder);
	
	
	public List<BuyOrder> listBuyOrderByIds(@Param("ids")List<String> ids);


	public BuyOrder getByExperienceOrder(@Param("experienceOrderId")String experienceOrderId);

	Integer getCountByMem(BuyOrder buyOrder);

    Map<String,Object> getMemberTradeInfo(Map<String, Object> map);
}