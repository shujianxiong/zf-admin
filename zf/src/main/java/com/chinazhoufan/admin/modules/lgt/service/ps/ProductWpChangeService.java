/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductWpChangeDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WareplaceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 货品货位调整记录查询Service
 * @author 陈适
 * @version 2015-12-04
 */
@Service
@Transactional(readOnly = true)
public class ProductWpChangeService extends CrudService<ProductWpChangeDao, ProductWpChange> {
	
	@Autowired
	private ProductDao productDao;
	@Autowired
	private WareplaceDao wareplaceDao;
	
	

	public ProductWpChange get(String id) {
		return super.get(id);
	}
	
	/**
	 * 获取货品最后一条出库货位变动记录
	 * @param productId
	 * @return
	 */
	public ProductWpChange getLastOutChange(String productId) {
		return dao.getLastOutChange(productId);
	}
	
	public List<ProductWpChange> findList(ProductWpChange productWpChange) {
		return super.findList(productWpChange);
	}
	
	public Page<ProductWpChange> findPage(Page<ProductWpChange> page, ProductWpChange productWpChange) {
		return super.findPage(page, productWpChange);
	}
	
	/**
	 * 变动货品存放位置（更新调出、调入货位的“存货产品”属性，新增货品货位变动记录，更新货品位置）
	 * @param productWpChange 	货品货位调整记录
	 * @param user				操作人，如果为空则取系统当前登录人员
	 * @throws ServiceException	可能抛出的异常类型参见ProductWpChange.java中定义的常量
	 */
	@Transactional(readOnly = false)
	public void updateProductPosition(ProductWpChange productWpChange, User user) throws ServiceException {
		Product product = productDao.get(productWpChange.getProduct().getId());
		if(product == null || product.getId() == null){
			// 货品货位调整异常，要变动的货品不存在
			throw new ServiceException(ProductWpChange.FAIL_PRODUCT_UNEXIST);
		}
		productWpChange.setPreWareplace(product.getWareplace());
		productWpChange.setPreHoldUser(product.getHoldUser());
		
		// 货品调整到货位，验证调出货位和调入货位限制，更新调前货位和调后货位的“存放产品”属性
		if(productWpChange.getPreWareplace() != null && productWpChange.getPreWareplace().getId() != null){
			Wareplace preWareplace = wareplaceDao.get(productWpChange.getPreWareplace().getId());
			if(Wareplace.FALSE_FLAG.equals(preWareplace.getUsableFlag())){
				// 货品货位调整异常，货品调出货位未启用，不能调出
				throw new ServiceException(ProductWpChange.FAIL_PREWAREPLACE_USELESS);
			}
			if(Wareplace.LOCKFLAG_LOCKED.equals(preWareplace.getLockFlag())){
				// 货品货位调整异常，货品调出货位已锁定，不能调出
				throw new ServiceException(ProductWpChange.FAIL_PREWAREPLACE_LOCKED);
			}
//			// 调出货位只存放了当前一个货品，更新调出货位的“存放产品”属性
//			Integer productsCount = wareplaceDao.findProductsCountByWareplaceId(preWareplace.getId());
//			if(productsCount == 1){
//				preWareplace.setProduce(new Produce());
//				preWareplace.preUpdate(user);
//				wareplaceDao.update(preWareplace);
//			}			
		}
		if(productWpChange.getPostWareplace() != null && productWpChange.getPostWareplace().getId() != null){
			Wareplace postWareplace = wareplaceDao.get(productWpChange.getPostWareplace().getId());
			if(Wareplace.FALSE_FLAG.equals(postWareplace.getUsableFlag())){
				// 货品货位调整异常，货品调入货位未启用，不能调入
				throw new ServiceException(ProductWpChange.FAIL_POSTWAREPLACE_USELESS);
			}
			if(Wareplace.LOCKFLAG_LOCKED.equals(postWareplace.getLockFlag())){
				// 货品货位调整异常，货品调入货位已锁定，不能调入
				throw new ServiceException(ProductWpChange.FAIL_POSTWAREPLACE_LOCKED);
			}
			// 调入货位必须为空或存放该货品对应的产品
			Integer productsCount = wareplaceDao.findProductsCountByWareplaceId(postWareplace.getId());
			if(productsCount == 0){
				// 调入货位为空，则更新调入货位的“存放产品”属性为当前货品对应产品
				postWareplace.setProduce(product.getProduce());
				postWareplace.preUpdate(user);
				wareplaceDao.update(postWareplace);
			}else {
				// 调入货位不为空，则判断当前货品是否属于该货位存放的产品类型
				if(!product.getProduce().getId().equals(postWareplace.getProduce().getId())){
					// 货品货位调整异常，货品调入货位已存放其他产品类型的货品
					throw new ServiceException(ProductWpChange.FAIL_POSTWAREPLACE_OCCUPIED);
				}
			}			
		}
		
		// 新增货品货位变动记录
		productWpChange.preInsert(user);
		dao.insert(productWpChange);
		
		// 更新货品位置
		product.setWareplace(productWpChange.getPostWareplace());
		product.setHoldUser(productWpChange.getPostHoldUser());
		product.preUpdate(user);
		productDao.updateSingle(product);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProductWpChange productWpChange) {
		super.delete(productWpChange);
	}
	
}