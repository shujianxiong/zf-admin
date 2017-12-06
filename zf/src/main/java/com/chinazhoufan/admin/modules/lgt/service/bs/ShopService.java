/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.bs;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.bs.ShopDao;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Shop;

/**
 * 体验店（自提点）Service
 * @author 张金俊
 * @version 2016-01-21
 */
@Service
@Transactional(readOnly = true)
public class ShopService extends CrudService<ShopDao, Shop> {

	public Shop get(String id) {
		return super.get(id);
	}
	
	public List<Shop> findList(Shop shop) {
		return super.findList(shop);
	}
	
	public Page<Shop> findPage(Page<Shop> page, Shop shop) {
		return super.findPage(page, shop);
	}
	
	@Transactional(readOnly = false)
	public void save(Shop shop) {
		super.save(shop);
	}
	
	@Transactional(readOnly = false)
	public void delete(Shop shop) {
		super.delete(shop);
	}
	
}