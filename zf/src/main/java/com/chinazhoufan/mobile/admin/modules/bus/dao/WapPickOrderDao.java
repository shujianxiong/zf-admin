package com.chinazhoufan.mobile.admin.modules.bus.dao;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * WAP拣货单API
 * @author   liut
 * @Date	 2017年4月12日		下午1:49:52
 */

@MyBatisDao
public interface WapPickOrderDao extends CrudDao<PickOrder>{

	
	public List<Produce> listMyPickMission(String pickBy);
	
	
	/**
	 * 统计拣货人当日，当周，当月，前一个月的当日，当周，当月的订单完成数量
	 * @param pickOrder
	 * @return
	 */
	public Integer countSendOrderByPickBy(PickOrder pickOrder);
	
}
