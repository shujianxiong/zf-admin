/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.bs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.bs.BrandDao;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;
import com.google.common.collect.Maps;

/**
 * 品牌管理Service
 * @author 贾斌
 * @version 2015-11-04
 */
@Service
@Transactional(readOnly = true)
public class BrandService extends CrudService<BrandDao, Brand> {

	public Brand get(String id) {
		return super.get(id);
	}
	
	public List<Brand> findList(Brand brand) {
		return super.findList(brand);
	}
	
	public Page<Brand> findPage(Page<Brand> page, Brand brand) {
		return super.findPage(page, brand);
	}
	
	@Transactional(readOnly = false)
	public void save(Brand brand) {
		super.save(brand);
	}
	
	@Transactional(readOnly = false)
	public void delete(Brand brand) {
		super.delete(brand);
	}

	@Transactional(readOnly =false)
	public void remove(String navigateCategoryId, String brandId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("brandId", brandId);
		map.put("navigateCategoryId", navigateCategoryId);
		dao.remove(map);
	}
	@Transactional(readOnly =false)
	public void saveCateBrand(Map<String, Object> map){
		dao.saveCateBrand(map);
	}

	public int findCount(Map<String, Object> map) {
		return dao.findCount(map);
	}
	
	
	
}