/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.si;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.si.CreditPointDetail;
import com.chinazhoufan.admin.modules.lgt.dao.si.CreditPointDetailDao;

/**
 * 供应商信誉分流水Service
 * @author 张金俊
 * @version 2017-05-03
 */
@Service
@Transactional(readOnly = true)
public class CreditPointDetailService extends CrudService<CreditPointDetailDao, CreditPointDetail> {

	public CreditPointDetail get(String id) {
		return super.get(id);
	}
	
	public List<CreditPointDetail> findList(CreditPointDetail creditPointDetail) {
		return super.findList(creditPointDetail);
	}
	
	public Page<CreditPointDetail> findPage(Page<CreditPointDetail> page, CreditPointDetail creditPointDetail) {
		return super.findPage(page, creditPointDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(CreditPointDetail creditPointDetail) {
		super.save(creditPointDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(CreditPointDetail creditPointDetail) {
		super.delete(creditPointDetail);
	}
	
}