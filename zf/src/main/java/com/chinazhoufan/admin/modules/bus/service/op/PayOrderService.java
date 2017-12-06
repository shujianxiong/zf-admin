/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.op;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.op.PayOrder;
import com.chinazhoufan.admin.modules.bus.dao.op.PayOrderDao;
import com.google.common.collect.Maps;

/**
 * 付款单Service
 * @author 张金俊
 * @version 2017-08-21
 */
@Service
@Transactional(readOnly = true)
public class PayOrderService extends CrudService<PayOrderDao, PayOrder> {

	public PayOrder get(String id) {
		return super.get(id);
	}
	
	public List<PayOrder> findList(PayOrder payOrder) {
		return super.findList(payOrder);
	}
	
	public Page<PayOrder> findPage(Page<PayOrder> page, PayOrder payOrder) {
		return super.findPage(page, payOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(PayOrder payOrder) {
		super.save(payOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(PayOrder payOrder) {
		super.delete(payOrder);
	}
	
	public List<PayOrder> findNotRefundListByOrder(String orderId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("orderId", orderId);
		map.put("DEL_FLAG_NORMAL", PayOrder.DEL_FLAG_NORMAL);
		map.put("TRUE_FLAG", PayOrder.TRUE_FLAG);
		return dao.findNotRefundListByOrder(map);
	}
	
}