/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;

/**
 * 仓库产品库存表DAO接口
 * @author 刘晓东
 * @version 2016-03-17
 */
@MyBatisDao
public interface WhProduceDao extends CrudDao<WhProduce> {

	/**
	 * 查询产品总库存
	 * @param produce
	 * @return
	 */
	int getStockTotalByProduce(Produce produce);

	WhProduce getByProduce(Produce produce);
	
	/**
	 * 根据仓库id和产品id查数据
	 * @param warehouseId 	仓库ID
	 * @param produceId		产品ID
	 * @return
	 */
	WhProduce getWhProduceByWidAndPid(@Param("warehouseId")String warehouseId, @Param("produceId")String produceId);
	
	List<WhProduce> findAllList(Map<String, Object> map);

	List<Produce> findWarehouseProduce(Map<String, Object> map);

	List<WhProduce> findList(Map<String, Object> map);

	/**
	 * 根据多个产品ID获取对应的产品仓库信息
	 * @param produceIdArr
	 * @return
	 */
	List<WhProduce> findListByProduceIdArr(Map<String, Object> map);
	
	
	/**
	 * 根据仓库ID和产品ID获取对应的库存信息
	 * @param whProduce
	 * @return
	 */
	List<WhProduce> getWhProduceByWarehouseIdAnProduceId(WhProduce whProduce);
	
	/**
	 * 根据产品删除对应的产品库存记录，这里主要是针对删除商品时，同步删除状态为新建状态的产品，此时要同步删除新建状态产品对应的库存
	 * @param produce
	 */
	public void deleteByProduce(Produce produce);

	void releaseLockStock(Map<String, Object> map); 
}