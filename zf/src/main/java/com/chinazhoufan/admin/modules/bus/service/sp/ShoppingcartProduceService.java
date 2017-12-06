/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.sp;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.sp.ShoppingcartProduce;
import com.chinazhoufan.admin.modules.bus.dao.sp.ShoppingcartProduceDao;

/**
 * 购物车产品表Service
 * @author liut
 * @version 2016-12-02
 */
@Service
@Transactional(readOnly = true)
public class ShoppingcartProduceService extends CrudService<ShoppingcartProduceDao, ShoppingcartProduce> {

	public ShoppingcartProduce get(String id) {
		return super.get(id);
	}
	
	public List<ShoppingcartProduce> findList(ShoppingcartProduce shoppingcartProduce) {
		return super.findList(shoppingcartProduce);
	}
	
	public Page<ShoppingcartProduce> findPage(Page<ShoppingcartProduce> page, ShoppingcartProduce shoppingcartProduce) {
		return super.findPage(page, shoppingcartProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(ShoppingcartProduce shoppingcartProduce) {
		super.save(shoppingcartProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(ShoppingcartProduce shoppingcartProduce) {
		super.delete(shoppingcartProduce);
	}
	
}