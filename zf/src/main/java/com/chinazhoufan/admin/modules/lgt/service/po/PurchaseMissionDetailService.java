/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.po;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseMissionDetailDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMissionDetail;

/**
 * 采购任务产品Service
 * @author 张金俊
 * @version 2016-04-13
 */
@Service
@Transactional(readOnly = true)
public class PurchaseMissionDetailService extends CrudService<PurchaseMissionDetailDao, PurchaseMissionDetail> {

	public PurchaseMissionDetail get(String id) {
		return super.get(id);
	}
	
	public List<PurchaseMissionDetail> findList(PurchaseMissionDetail purchaseMissionDetail) {
		return super.findList(purchaseMissionDetail);
	}
	
	public Page<PurchaseMissionDetail> findPage(Page<PurchaseMissionDetail> page, PurchaseMissionDetail purchaseMissionDetail) {
		return super.findPage(page, purchaseMissionDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(PurchaseMissionDetail purchaseMissionDetail) {
		super.save(purchaseMissionDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(PurchaseMissionDetail purchaseMissionDetail) {
		super.delete(purchaseMissionDetail);
	}
	
}