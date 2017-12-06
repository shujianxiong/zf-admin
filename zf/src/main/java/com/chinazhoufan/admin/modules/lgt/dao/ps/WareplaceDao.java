/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 货位列表DAO接口
 * @author 贾斌
 * @version 2015-10-13
 */
@MyBatisDao
public interface WareplaceDao extends CrudDao<Wareplace> {
	
	/**
	 * （在正常货架中）根据仓库、存放产品查询货位信息
	 * @param warehouseId	仓库ID
	 * @param produceId		产品ID
	 * @return
	 */
	public Wareplace getNormalByProduceId(@Param("warehouseId") String warehouseId, @Param("produceId") String produceId);
	
	/**
	 * （在正常货架中）根据仓库、货架分类查询第一个未锁定、已启用的空货位信息(同时数据库锁定该记录)
	 * @param warehouseId	仓库ID
	 * @param categoryId	分类ID
	 * @return
	 */
	public Wareplace getNormalFirstEmptyForUpdate(@Param("warehouseId") String warehouseId, @Param("categoryId") String categoryId);

	/**
	 * 根据电子码查询货位信息（包含货位所属货柜、区域、仓库信息）
	 * @param scanCode	电子码
	 * @return
	 */
	public Wareplace getByScanCode(String scanCode);
	
	/**
	 * 根据ID查询货位信息（包含货位所属货柜、区域、仓库信息）
	 * @param wareplaceId 货位ID
	 * @return
	 */
	public Wareplace getWithWarehouse(String wareplaceId);
	
	/**
	 * 查询未存货、未锁定、已启用的所有货位
	 * @param wareplace
	 * @return
	 */
	public List<Wareplace> findListEmpty(Wareplace wareplace);
	
	/**
	 * 根据仓库数据或产品ID，获取货位数据 json方法
	 * @param wareplace
	 * @return
	 */
	public List<Wareplace> findWareplaceListByProduceAndPosition(Wareplace wareplace);
	
	/**
	 * 更新货位锁定状态
	 * @param wareplace.id			要更新的货位ID
	 * @param wareplace.lockFlag	锁定状态
	 * @param wareplace.updateBy.id	更新人ID
	 * @param wareplace.updateDate	更新时间
	 */
	public void updateLockFlag(Wareplace wareplace);
	
	/**
	 * 查询货位存储货品数量（包含正常在库的、出入库锁定中的、体验中的等状态的所有货品）
	 * @param wareplaceId
	 * @return Integer
	 */
	public Integer findProductsCountByWareplaceId(String wareplaceId);

	public Wareplace getByWareplaceScanCode(String wareplaceScanCode);
	
	/**
	 * 根据分类获取可用的仓库货位
	 * @param categoryId
	 * @return
	 */
	public Wareplace getAvaliableWareplaceByCategory(String categoryId);
	
}