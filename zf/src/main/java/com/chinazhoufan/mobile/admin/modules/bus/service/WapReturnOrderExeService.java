package com.chinazhoufan.mobile.admin.modules.bus.service;

import java.io.IOException;

import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.mobile.admin.modules.bus.dao.WapSendOrderDao;
import com.chinazhoufan.mobile.wechat.service.pay.config.OrderType;
import com.chinazhoufan.mobile.wechat.service.pay.exception.WechatPayException;

/**
 * WAP体验单结算Service
 * @author   zhangjinjun
 * @Date	 2017年5月10日		上午11:29:00
 */

@Service
@Transactional(readOnly = true)
public class WapReturnOrderExeService extends CrudService<WapSendOrderDao, SendOrder> {
	
	@Autowired
	private ExperienceOrderService experienceOrderService;
	
	
	/**
	 * 回货订单触发体验单结算
	 * @param returnOrder			
	 * @throws IOException 
	 * @throws ServiceException 
	 */
	@Transactional(readOnly = false)
	public void exeReturnOrder(ReturnOrder returnOrder) throws ServiceException, IOException{
		// 退货单来源订单类型是否为"体验单"
		if(!OrderType.EXPERIENCE.getType().equals(returnOrder.getOrderType())){
			throw new ServiceException("退货单来源订单类型为体验单才可进行结算");
		}
		ExperienceOrder experienceOrder = new ExperienceOrder();
		experienceOrder.setId(returnOrder.getOrderId());
		// 结算对应的体验单
		experienceOrderService.settleExperienceOrderAuto(experienceOrder);
	}
	
	
	
}
