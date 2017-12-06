package com.chinazhoufan.admin.modules.data.dao.order;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.BaseDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.data.vo.order.OrderStat;

@MyBatisDao
public interface OrderStatDao extends BaseDao {

	
	public List<OrderStat> statExperienceOrder(ExperienceOrder eo);
	
	public List<OrderStat> statBuyOrder(BuyOrder bo);
	
	
}
