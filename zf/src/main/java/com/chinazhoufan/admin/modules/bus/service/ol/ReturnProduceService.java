/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduce;
import com.chinazhoufan.admin.modules.bus.dao.ol.ReturnProduceDao;

/**
 * 退货产品Service
 * @author 张金俊
 * @version 2017-08-14
 */
@Service
@Transactional(readOnly = true)
public class ReturnProduceService extends CrudService<ReturnProduceDao, ReturnProduce> {

	public ReturnProduce get(String id) {
		return super.get(id);
	}
	
	public List<ReturnProduce> findList(ReturnProduce returnProduce) {
		return super.findList(returnProduce);
	}
	
	public Page<ReturnProduce> findPage(Page<ReturnProduce> page, ReturnProduce returnProduce) {
		return super.findPage(page, returnProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(ReturnProduce returnProduce) {
		super.save(returnProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(ReturnProduce returnProduce) {
		super.delete(returnProduce);
	}

	public ReturnProduce getByOrderProduce(String orderProduceId){
		return dao.getByOrderProduce(orderProduceId);
	}


}