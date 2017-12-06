/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductCodeChangeDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductCodeChange;

/**
 * 货品编码变动记录Service
 * @author 张金俊
 * @version 2017-04-20
 */
@Service
@Transactional(readOnly = true)
public class ProductCodeChangeService extends CrudService<ProductCodeChangeDao, ProductCodeChange> {

	@Autowired
	private ProductService productService;
	
	public ProductCodeChange get(String id) {
		return super.get(id);
	}
	
	public List<ProductCodeChange> findList(ProductCodeChange productCodeChange) {
		return super.findList(productCodeChange);
	}
	
	public Page<ProductCodeChange> findPage(Page<ProductCodeChange> page, ProductCodeChange productCodeChange) {
		return super.findPage(page, productCodeChange);
	}
	
	@Transactional(readOnly = false)
	public void save(ProductCodeChange productCodeChange) {
		Product t = productService.getByCode(productCodeChange.getProduct().getCode());
		productCodeChange.setProduct(t);
		productCodeChange.setPreProductCode(t.getCode());//货品调整前货品编码为货品原始编码
		super.save(productCodeChange);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProductCodeChange productCodeChange) {
		super.delete(productCodeChange);
	}
	
}