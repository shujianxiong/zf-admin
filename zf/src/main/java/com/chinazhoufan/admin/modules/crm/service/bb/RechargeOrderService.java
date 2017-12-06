/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.bb;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.bb.RechargeOrder;
import com.chinazhoufan.admin.modules.crm.dao.bb.RechargeOrderDao;

/**
 * 微信充值单Service
 * @author 张金俊
 * @version 2016-12-19
 */
@Service
@Transactional(readOnly = true)
public class RechargeOrderService extends CrudService<RechargeOrderDao, RechargeOrder> {

	public RechargeOrder get(String id) {
		return super.get(id);
	}
	
	public List<RechargeOrder> findList(RechargeOrder rechargeOrder) {
		return super.findList(rechargeOrder);
	}
	
	public Page<RechargeOrder> findPage(Page<RechargeOrder> page, RechargeOrder rechargeOrder) {
		return super.findPage(page, rechargeOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(RechargeOrder rechargeOrder) {
		super.save(rechargeOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(RechargeOrder rechargeOrder) {
		super.delete(rechargeOrder);
	}
	
}