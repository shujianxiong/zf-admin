package com.chinazhoufan.admin.modules.data.service.order;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.BaseService;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.data.dao.order.OrderStatDao;
import com.chinazhoufan.admin.modules.data.vo.order.OrderStat;

@Service
@Transactional(readOnly = false)
public class OrderStatService extends BaseService {

	@Autowired
	private OrderStatDao orderStatDao;
	
	public List<OrderStat> statExperienceOrder() {
		Calendar cal = Calendar.getInstance();
		Date to = cal.getTime();
		cal.add(Calendar.MONTH, -5);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Date from = cal.getTime();
		
		ExperienceOrder eo = new ExperienceOrder();
		eo.setBeginCreateDate(from);
		eo.setEndCreateDate(to);
		return orderStatDao.statExperienceOrder(eo);
	};
	
	
	public List<OrderStat> statBuyOrder() {
		
		Calendar cal = Calendar.getInstance();
		Date to = cal.getTime();
		cal.add(Calendar.MONTH, -5);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Date from = cal.getTime();
		
		BuyOrder bo = new BuyOrder();
		bo.setBeginCreateDate(from);
		bo.setEndCreateDate(to);
		
		return orderStatDao.statBuyOrder(bo);
	}; 
	
	
	
}
