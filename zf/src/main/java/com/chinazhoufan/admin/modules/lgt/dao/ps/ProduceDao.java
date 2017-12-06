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

/**
 * 产品明细列表DAO接口
 * @author 陈适
 * @version 2015-10-12
 */
@MyBatisDao
public interface ProduceDao extends CrudDao<Produce> {

	/**
	 * 获取产品详情（产品信息、产品属性信息）
	 * @param id
	 * @return
	 */
	public Produce getInfo(String id);
	
	/**
	 * 查询产品列表（列表展示页替代findList()方法，查询出产品的商品信息及库存信息）
	 * @param produce
	 * @return
	 */
	public List<Produce> findListWithGoodsAndStock(Produce produce);
	
	/**
	 * 更新产品状态（只更新状态、更新者、更新时间字段）
	 * @param produce
	 */
	public void updateStatus(Produce produce);

	/**
	 * （物理）删除产品
	 * @param produce
	 */
	public void remove(Produce produce);
	

	
	public Integer findCount();
	
	public Produce findByBarCode(String barCode);

	public List<Produce> findListByGoodsId(String goodsId);
	
	/**
	 * 根据产品ID集合，返回产品及产品属性信息
	 * @param produceIds
	 * @return
	 */
	public List<Produce> findProduceByIds(@Param(value="produceIds") List<String> produceIds);

	/**
	 * 根据产品DI集合，返回产品及对应的商品信息
	 * @param produceIds
	 * @return
	 */
	public List<Produce> findProduceByIdsWithGoods(@Param(value="produceIds") List<String> produceIds);
	
	/**
	 * 根据产品ID集合查询产品全属性列
	 * @param produceIds
	 * @return
	 */
	public List<Produce> findProduceAllColumnByIds(@Param(value="produceIds") List<String> produceIds);
	
	/**
	 * 产品选择器查询
	 * @param produce
	 * @return
	 */
	public List<Produce> findSelectList(Produce produce);
	
	/**
	 * gens
	 * @Title ProduceDao
	 * @Description TODO
	 * @Param @param goodsId
	 * @throws 
	 * @param goodsId
	 */
	public void deleteByGoodsId(Produce produce);

	/**
	 * 根据产品ID，获取产品基本信息，不做级联查询
	 * @param produce
	 * @return    设定文件
	 * @throws
	 */
	public Produce getProduceOnly(Produce produce);
	
	
	/**
	 * 产品打印接口
	 * @param produce
	 * @return
	 */
	public List<Produce> printPreview(Produce produce);
	
	
	
	//==================Syn Mobile Operator Interface START===============
	/**
	 * 根据产品编码查询产品（不包含伪删状态）
	 * @param code 产品编码
	 * @return
	 */
	public Produce getByCode(String code);
	
	/**
	 * 根据产品实体里面的fullWareplace货位传值获取存放产品全名+库存+完整货位地址
	 * @param produce
	 * @throws
	 */
	public List<Produce> searchByWareplace(Produce produce);
	
	/**
	 * 根据商品ID获取对应的产品规格信息及产品对应的存放货位和可用库存数量 
	 * @param goodsId
	 * @throws
	 */
	public List<Produce> getFullProduceWithStockAndLocateByGoods(String goodsId);
	//==================Syn Mobile Operator Interface END===============
	
	/**
	 * 产品促销筛查接口
	 * @param produce
	 * @return
	 */
	public List<Produce> filterList(@Param(value="maps") Map<String, Object> maps,@Param(value="pageFromNum")int pageFromNum,  @Param(value="pageSize")int pageSize,  @Param(value="searchType")String searchType, @Param(value="produce")Produce produce);
	
	/**
	 * 批量更新产品折扣信息
	 * @param produceIdArr
	 * @param discount
	 */
	public void batchUpdateDiscountByProduce(@Param(value="produceIdArr") String[] produceIdArr, @Param(value="produce")Produce produce);
	
	/**
	 * 根据产品ID更新产品全属性及sku属性值
	 * @param produce
	 */
	public void updateProducePropertyStrAndSkuStr(Produce produce);

	public int countByGoods(@Param(value="goodsId")String goodsId);
	
}