package com.chinazhoufan.mobile.admin.modules.bus.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.mobile.admin.modules.bus.dao.WapPickOrderDao;

/**
 * WAP拣货单Service
 * @author   liut
 * @Date	 2017年4月12日		下午1:49:52
 */
@Service
@Transactional(readOnly = true)
public class WapPickOrderService extends CrudService<WapPickOrderDao, PickOrder> {

	
	/**
	 * 查询我的拣货任务，按照货位分组
	 * @param pickBy
	 * @return
	 */
	public List<Produce> listMyPickMission(@Param("pickBy") String pickBy) {
		return dao.listMyPickMission(pickBy);
	};
	
	/**
	 * 统计拣货人当日，当周，当月，前一个月的当日，当周，当月的订单完成数量
	 * @param pickOrder(statType, pickBy)
	 * 
	 * @return  本日订单完成数+"="+本周订单完成数+"="+本月订单完成数+"="+上一个月当日订单完成数+"="+上一个月本周订单完成数+"="+上一个月订单完成数;
	 */
	public String countSendOrderByPickBy(PickOrder pickOrder) {
		pickOrder.setStatType(PickOrder.STAT_TYPE_FOR_CD);
		Integer a = dao.countSendOrderByPickBy(pickOrder);//当天
		
		pickOrder.setStatType(PickOrder.STAT_TYPE_FOR_CW);
		Integer b = dao.countSendOrderByPickBy(pickOrder);//当周
		
		pickOrder.setStatType(PickOrder.STAT_TYPE_FOR_CM);
		Integer c = dao.countSendOrderByPickBy(pickOrder);//当月
		
		pickOrder.setStatType(PickOrder.STAT_TYPE_FOR_LD);
		Integer d = dao.countSendOrderByPickBy(pickOrder);//上一个月当天
		
		pickOrder.setStatType(PickOrder.STAT_TYPE_FOR_LW);
		Integer e = dao.countSendOrderByPickBy(pickOrder);//上一个月当周
		
		pickOrder.setStatType(PickOrder.STAT_TYPE_FOR_LM);
		Integer f = dao.countSendOrderByPickBy(pickOrder);//上一个月
		
		return a+"="+b+"="+c+"="+d+"="+e+"="+f;
	} 
	
}
