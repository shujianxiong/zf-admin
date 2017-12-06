/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ol.ExpressBroken;
import com.chinazhoufan.admin.modules.bus.dao.ol.ExpressBrokenDao;

/**
 * 快递包裹损坏记录Service
 * @author 张金俊
 * @version 2017-08-14
 */
@Service
@Transactional(readOnly = true)
public class ExpressBrokenService extends CrudService<ExpressBrokenDao, ExpressBroken> {

	public ExpressBroken get(String id) {
		return super.get(id);
	}
	
	public List<ExpressBroken> findList(ExpressBroken expressBroken) {
		return super.findList(expressBroken);
	}
	public ExpressBroken findByReturnOrderId(String id) {
		return dao.findByReturnOrderId(id);
	}
	public Page<ExpressBroken> findPage(Page<ExpressBroken> page, ExpressBroken expressBroken) {
		return super.findPage(page, expressBroken);
	}
	
	@Transactional(readOnly = false)
	public void save(ExpressBroken expressBroken) {
		super.save(expressBroken);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExpressBroken expressBroken) {
		super.delete(expressBroken);
	}
	
}