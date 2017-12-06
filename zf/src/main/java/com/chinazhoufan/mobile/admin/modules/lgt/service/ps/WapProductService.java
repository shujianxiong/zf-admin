/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.lgt.service.ps;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductCodeChange;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductCodeChangeService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;

/**
 * 货品管理Service
 * @author 陈适
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class WapProductService extends CrudService<ProductDao, Product> {
	
	@Autowired
	private ProductWpIoService productWpIoService;
	@Autowired
	private ProductCodeChangeService productCodeChangeService;
	
	/**
	 * 根据货品编码查询货品（不包含伪删状态）
	 * @param code 货品编码
	 * @param code
	 * @return
	 */
	public Product getByCode(String code) {
		if(StringUtils.isBlank(code)) return null;
		return dao.getByCodeWithOutDel(code);
	}
	
	/**
	 * 根据产品ID查询某仓库中所有存货货位（PS：需满足 货品未删、货品可租、状态正常、物流状态在库、货位非锁定、仓库是出库仓、仓库启用）
	 * @param produceId		产品ID
	 * @param warehouseId	仓库ID
	 * @return
	 */
	public List<Wareplace> getWareplacesForProduce(String produceId, String warehouseId){
		return dao.getWareplacesForProduce(produceId, warehouseId);
	}
	
	/**
	 * 货品入库
	 * @param productWpIo
	 */
	@Transactional(readOnly = false)
	public void saveProductWpIo(ProductWpIo productWpIo) {
		productWpIoService.productInSave(productWpIo);
	}
	
	/**
	 * 保存货品货签变更记录
	 * @param productCodeChange
	 */
	@Transactional(readOnly = false)
	public void saveProductCodeChange(ProductCodeChange productCodeChange) {
		productCodeChangeService.save(productCodeChange);
		//同时变更货品的货品编码
		Product pt = productCodeChange.getProduct();
		pt.setCode(productCodeChange.getPostProductCode());
		pt.preUpdate();
		dao.update(pt);
	}
	
	
	
}