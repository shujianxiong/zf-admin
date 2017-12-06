/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.dao.ol.SendProductDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduct;

/**
 * 发货货品Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class SendProductService extends CrudService<SendProductDao, SendProduct> {

	public SendProduct get(String id) {
		return super.get(id);
	}
	
	public List<SendProduct> findList(SendProduct sendProduct) {
		return super.findList(sendProduct);
	}
	
	public Page<SendProduct> findPage(Page<SendProduct> page, SendProduct sendProduct) {
		return super.findPage(page, sendProduct);
	}
	
	@Transactional(readOnly = false)
	public void save(SendProduct sendProduct) {
		super.save(sendProduct);
	}
	
	@Transactional(readOnly = false)
	public void delete(SendProduct sendProduct) {
		super.delete(sendProduct);
	}

	@Transactional(readOnly = false)
	public List<SendProduct> findSendProductBySendOrder(String sendOrderId) {
		return dao.findSendProductBySendOrder(sendOrderId);
	}
	
}