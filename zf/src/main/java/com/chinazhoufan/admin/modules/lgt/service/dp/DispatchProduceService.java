/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.dp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchProductDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduce;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduct;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;

/**
 * 调货产品表Service
 * @author 刘晓东
 * @version 2015-11-19
 */
@Service
@Transactional(readOnly = true)
public class DispatchProduceService extends CrudService<DispatchProduceDao, DispatchProduce> {

	@Autowired
	private DispatchProductDao dispatchProductDao;
	@Autowired
	private ProductService productService;
	
	public DispatchProduce get(String id) {
		DispatchProduce dispatchProduce = super.get(id);
		dispatchProduce.setDispatchProductList(dispatchProductDao.findList(new DispatchProduct(dispatchProduce)));
		return dispatchProduce;
	}
	
	public List<DispatchProduce> findList(DispatchProduce dispatchProduce) {
		return super.findList(dispatchProduce);
	}
	
	public Page<DispatchProduce> findPage(Page<DispatchProduce> page, DispatchProduce dispatchProduce) {
		return super.findPage(page, dispatchProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(DispatchProduce dispatchProduce) {
		super.save(dispatchProduce);
		for (DispatchProduct dispatchProduct : dispatchProduce.getDispatchProductList()){
			/**
			 * 根据货品编码获取货品
			 */
//			dispatchProduct.setProduct(productService.getByProductCode(dispatchProduct.getProduct().getProductCode())); 
			
			if (dispatchProduct.getId() == null){
				continue;
			}
			if (DispatchProduct.DEL_FLAG_NORMAL.equals(dispatchProduct.getDelFlag())){
				if (StringUtils.isBlank(dispatchProduct.getId())){
					dispatchProduct.setDispatchProduce(dispatchProduce);
					dispatchProduct.preInsert();
					dispatchProductDao.insert(dispatchProduct);
					//TODO 生成   货品出库记录ID、货品质检记录ID、货品入库记录ID
				}else{
					dispatchProduct.preUpdate();
					dispatchProductDao.update(dispatchProduct);
					//TODO 更新   货品出库记录ID、货品质检记录ID、货品入库记录ID
				}
			}else{
				dispatchProductDao.delete(dispatchProduct);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(DispatchProduce dispatchProduce) {
		super.delete(dispatchProduce);
		dispatchProductDao.delete(new DispatchProduct(dispatchProduce));
	}
	
	public List<DispatchProduce> listProductWithProduceByDispatchOrderId(String dispatchOrderId) {
		return dao.listProductWithProduceByDispatchOrderId(dispatchOrderId);
	};
}