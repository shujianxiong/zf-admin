/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pd;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountProperty;
import com.chinazhoufan.admin.modules.spm.dao.pd.DiscountPropertyDao;

/**
 * 产品筛选属性Service
 * @author liut
 * @version 2017-07-04
 */
@Service
@Transactional(readOnly = true)
public class DiscountPropertyService extends CrudService<DiscountPropertyDao, DiscountProperty> {

	public DiscountProperty get(String id) {
		return super.get(id);
	}
	
	public List<DiscountProperty> findList(DiscountProperty discountProperty) {
		return super.findList(discountProperty);
	}
	
	public Page<DiscountProperty> findPage(Page<DiscountProperty> page, DiscountProperty discountProperty) {
		return super.findPage(page, discountProperty);
	}
	
	@Transactional(readOnly = false)
	public void save(DiscountProperty discountProperty) {
		super.save(discountProperty);
	}
	
	@Transactional(readOnly = false)
	public void delete(DiscountProperty discountProperty) {
		super.delete(discountProperty);
	}
	
}