/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduce;
import com.chinazhoufan.admin.modules.bus.dao.ol.SendProduceDao;

/**
 * 发货产品Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class SendProduceService extends CrudService<SendProduceDao, SendProduce> {

	public SendProduce get(String id) {
		return super.get(id);
	}
	
	public List<SendProduce> findList(SendProduce sendProduce) {
		return super.findList(sendProduce);
	}
	
	public Page<SendProduce> findPage(Page<SendProduce> page, SendProduce sendProduce) {
		return super.findPage(page, sendProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(SendProduce sendProduce) {
		super.save(sendProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(SendProduce sendProduce) {
		super.delete(sendProduce);
	}
	
	/**
	 * 根据发货单ID获取对应关联的发货产品信息包含对应的商品信息
	 * @param sendOrderId
	 * @return
	 */
	public List<SendProduce> findSendProduceBySendOrder(String sendOrderId) {
		return dao.findSendProduceBySendOrder(sendOrderId);
	}
	
	
}