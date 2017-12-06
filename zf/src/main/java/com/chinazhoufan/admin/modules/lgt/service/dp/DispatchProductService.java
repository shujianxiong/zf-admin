/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.dp;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchProductDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduce;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduct;

/**
 * 调货货品表Service
 * @author 刘晓东
 * @version 2015-11-19
 */
@Service
@Transactional(readOnly = true)
public class DispatchProductService extends CrudService<DispatchProductDao, DispatchProduct> {

	public DispatchProduct get(String id) {
		return super.get(id);
	}
	
	public List<DispatchProduct> findListByDispatchProduceId(String dispatchProduceId) {
		return dao.findListByDispatchProduceId(dispatchProduceId);
	}
	
	public List<DispatchProduct> findList(DispatchProduct dispatchProduct) {
		return super.findList(dispatchProduct);
	}
	
	public Page<DispatchProduct> findPage(Page<DispatchProduct> page, DispatchProduct dispatchProduct) {
		return super.findPage(page, dispatchProduct);
	}
	
	@Transactional(readOnly = false)
	public void save(DispatchProduct dispatchProduct) {
		super.save(dispatchProduct);
	}
	
	@Transactional(readOnly = false)
	public void delete(DispatchProduct dispatchProduct) {
		super.delete(dispatchProduct);
	}
	
	@Transactional(readOnly = false)
	public void saveDispatchProduct(DispatchProduce dispatchProduce){
		
		for (DispatchProduct dispatchProduct : dispatchProduce.getDispatchProductList()) {
			super.save(dispatchProduct);

		}
		
	}
	
}