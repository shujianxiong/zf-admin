/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pm;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.pm.PointExchange;
import com.chinazhoufan.admin.modules.spm.dao.pm.PointExchangeDao;

/**
 * 积分商品兑换记录Service
 * @author 张金俊
 * @version 2016-12-02
 */
@Service
@Transactional(readOnly = true)
public class PointExchangeService extends CrudService<PointExchangeDao, PointExchange> {

	public PointExchange get(String id) {
		return super.get(id);
	}
	
	public List<PointExchange> findList(PointExchange pointExchange) {
		return super.findList(pointExchange);
	}
	
	public Page<PointExchange> findPage(Page<PointExchange> page, PointExchange pointExchange) {
		return super.findPage(page, pointExchange);
	}
	
	@Transactional(readOnly = false)
	public void save(PointExchange pointExchange) {
		super.save(pointExchange);
	}
	
	@Transactional(readOnly = false)
	public void delete(PointExchange pointExchange) {
		super.delete(pointExchange);
	}
	
}