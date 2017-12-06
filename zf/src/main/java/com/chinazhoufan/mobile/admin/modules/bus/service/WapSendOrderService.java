package com.chinazhoufan.mobile.admin.modules.bus.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.mobile.admin.modules.bus.dao.WapSendOrderDao;

/**
 * WAP发货单Service
 * @author   liut
 * @Date	 2017年4月12日		下午1:49:52
 */

@Service
@Transactional(readOnly = true)
public class WapSendOrderService extends CrudService<WapSendOrderDao, SendOrder> {

	/**
	 * 获取全部状态为：待发货的发货单
	 */
	public Page<SendOrder> listAll(Page<SendOrder> page, SendOrder sendOrder) {
		sendOrder.setPage(page);
		page.setList(dao.listAll(sendOrder));
		return page;
	}
	
	
}
	