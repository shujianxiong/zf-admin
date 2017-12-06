/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 货品明细管理DAO接口
 * @author 陈适
 * @version 2015-10-12
 */
@MyBatisDao
public interface ProductDao extends CrudDao<Product> {
	
	/**
	 * 根据货品电子码查询货品（包含伪删状态）
	 * @param scanCode 货品电子码
	 * @return
	 */
	public Product getByScanCode(String scanCode);
	
	public Integer findCount();
	
	public Product findByBarCode(String barCode);
	
	/**
	 * 根据货品编码查询出所有货品（包含伪删状态）
	 * @param productCode 货品编码
	 * @return
	 */
	public List<Product> findListByProductCodeWithDel(String productCode);

	/**
	 * 根据ID独立更新货品属性（有值的才会更新）
	 * 如果传入wareplace而不传入wareplace.id，则清空货品货位（更新wareplace_id为空）
	 * 如果传入holdUser而不传入holdUser.id，则清空货品持有人（更新hold_user_id为空）
	 * @param product
	 */
	public void updateSingle(Product product);
	
	/**
	 * 更新货品电子码
	 * @param product
	 */
	public void updateScanCode(Product product);

	public void lockByProduceId(@Param("produceId")String produceId, @Param("status")String status);
	
	/**
	 * 货品打印
	 * @param product
	 * @return
	 */
	public List<Product> printPreview(Product product);
	
	//==================Syn Mobile Operator Interface START===============
	
	/**
	 * 根据货品编码查询货品（不包含伪删状态）
	 * @param code 货品编码
	 * @param code
	 * @return
	 */
	public Product getByCodeWithOutDel(String code);
	
	/**
	 * 根据产品ID查询某仓库中所有存货货位（PS：需满足 货品未删、货品可租、状态正常、物流状态在库、货位非锁定、仓库是出库仓、仓库启用）
	 * @param produceId		产品ID
	 * @param warehouseId	仓库ID
	 * @return
	 */
	public List<Wareplace> getWareplacesForProduce(@Param("produceId") String produceId, @Param("warehouseId") String warehouseId);

	public int countByProduce(@Param("produceId")String produceId);

	/**
	 * 自动更新货品修改状态
	 */
	public void updateStatusByAuto();
	
	//==================Syn Mobile Operator Interface END===============
}