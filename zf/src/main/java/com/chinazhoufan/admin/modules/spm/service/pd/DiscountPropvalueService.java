/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pd;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountPropvalue;
import com.chinazhoufan.admin.modules.spm.dao.pd.DiscountPropvalueDao;

/**
 * 产品筛选属性值表Service
 * @author liut
 * @version 2017-07-04
 */
@Service
@Transactional(readOnly = true)
public class DiscountPropvalueService extends CrudService<DiscountPropvalueDao, DiscountPropvalue> {

	public DiscountPropvalue get(String id) {
		return super.get(id);
	}
	
	public List<DiscountPropvalue> findList(DiscountPropvalue discountPropvalue) {
		return super.findList(discountPropvalue);
	}
	
	public Page<DiscountPropvalue> findPage(Page<DiscountPropvalue> page, DiscountPropvalue discountPropvalue) {
		return super.findPage(page, discountPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void save(DiscountPropvalue discountPropvalue) {
		super.save(discountPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void delete(DiscountPropvalue discountPropvalue) {
		super.delete(discountPropvalue);
	}
	
}