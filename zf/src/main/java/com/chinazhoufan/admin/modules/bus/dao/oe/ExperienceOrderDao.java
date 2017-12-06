/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.oe;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;

/**
 * 体验单DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface ExperienceOrderDao extends CrudDao<ExperienceOrder> {

	/**
	 * 根据订单ID获取体验订单信息及体验产品信息
	 * @param experienceOrder
	 * @return
	 */
	public ExperienceOrder getDetail(ExperienceOrder experienceOrder);

	
//	/**
//	 * 根据预约体验单里面的产品ID ，更新预约到货状态
//	 * @param experienceOrder
//	 */
//	public void updateAppointStockStatusByProduce(ExperienceOrder experienceOrder);
	
	/**
	 * 统计体验单里面当天的成交量，包括预约体验
	 * @param experienceOrder
	 * @return
	 */
	public Integer statExperienceOrderDayTradingVolume(ExperienceOrder experienceOrder);

	
	/**
	 * 根据体验单ID集合获取订单详情
	 * @param ids
	 * @return
	 */
	public List<ExperienceOrder> findListByIds(@Param("ids")List<String> ids);

	/**
	 * 根据产品ID集合获取订单详情
	 * @param ids
	 * @return
	 */
	public List<ExperienceOrder> findListByProduceIds(Map<String, Object> map);

	Integer getCountByMem(ExperienceOrder experienceOrder);

	Integer getDamageCount(Map<String, Object> map);

	/**
	 //	 * 更新订单欠款状态
	 //	 * @param experienceOrder
	 //	 */
	public void updateDueStatus(ExperienceOrder experienceOrder);

	public void updateBuyStatus(ExperienceOrder experienceOrder);

	/**
	 * 是否是首单
	 * @param memberId
	 * @return
	 */
    ExperienceOrder isFirstOrder(@Param("memberId") String memberId);

    Map<String,Object> getMemberTradeInfo(Map<String, Object> memberId);

    ExperienceOrder getFirstOrder(String memberId);

    int countReturnOverDue(Map<String, Object> map);

	public void updateAppointToClose(ExperienceOrder experienceOrder);

	void updateOrderStatusByExpress(@Param("realExpDate")Date realExpDate,@Param("orderNo")String orderNo, @Param("status")String status, @Param("statuslogisticalSigned")String statuslogisticalSigned);

}
