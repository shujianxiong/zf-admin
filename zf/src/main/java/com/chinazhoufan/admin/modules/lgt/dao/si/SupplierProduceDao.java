/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.si;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierProduce;

/**
 * 供应商产品表DAO接口
 * @author liut
 * @version 2016-11-21
 */
@MyBatisDao
public interface SupplierProduceDao extends CrudDao<SupplierProduce> {
	
	/**
	 * 根据供应商和商品获取对应的产品供货价信息
	 * @param supplierId
	 * @return    设定文件
	 * @throws
	 */
	public List<SupplierProduce> listSupplierProduceBySupplierAndGoods(@Param("supplierId") String supplierId, @Param("goodsId")String goodsId);

	
	/**
	 * 根据供应商获取对应的所有产品供货价信息
	 * @param supplierId
	 * @return    设定文件
	 * @throws
	 */
	public List<SupplierProduce> listSupplierProduceBySupplier(@Param("supplierId") String supplierId);

	
	
	/**
	 * 根据供应商和商品删除对应的供应商产品记录
	 * @param supplierId
	 * @param goodsId    设定文件
	 * @throws
	 */
	public void deleteSupplierProduceBySupplierAndGoods(@Param("supplierId") String supplierId, @Param("goodsId")String goodsId);
	
	/**
	 * 根据供应商和产品更新供应商产品信息
	 * @param supplierProduce    设定文件
	 * @throws
	 */
	public void updateBySupplierAndProduce(SupplierProduce supplierProduce);
	
	/**
	 * 根据商品获取
	 * @param goodsId
	 * @return    设定文件
	 * @throws
	 */
	public List<Supplier> listSupplierByGoods(@Param("goodsId")String goodsId);


	/**
	 * 查询供应商产品最新（updateDate最晚）的一条记录
	 * @param produceId
	 * @return
	 */
	public SupplierProduce getLastestOne(String produceId);
	
	
	
}