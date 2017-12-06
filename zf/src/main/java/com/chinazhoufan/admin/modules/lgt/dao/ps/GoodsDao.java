/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 商品表DAO接口
 * @author 张金俊
 * @version 2015-10-12
 */
@MyBatisDao
public interface GoodsDao extends CrudDao<Goods> {
	
	/**
	 * 查询所有商品
	 * @param entity
	 * @return
	 */
	public List<Goods> findAllList(Goods goods);
	
	public List<Goods> findGoodsByCategory(String isDel,String categoryId);

	public List<Goods> findGoodsAndProduceList(@Param("goods")Goods goods,@Param("warehouseId")String warehouseId, @Param("produce")Produce produce);
	/**
	 * 根据商品查询产品货品信息
	 * @param goods
	 * @param productId
	 * @return
	 */
	public List<Goods> findGoodsAndProductList(@Param("page")Page page, @Param("goods")Goods goods,@Param("produceId")String produceId, @Param("warehouseId")String warehouseId);
	
	public List<Goods> findProduceList(Map<String, Object> map);

	public List<Goods> findAllListNoNew(Goods goods);

	public Integer findCount();
	
	public Goods findByBarCode(String code);

	/*********************************************************/
	/***********************前端*******************************/
	public Goods findSimpleGoodsById(Goods goods);

	public Goods findDetailGoodsById(Goods goods);

	/**
	 * 查找关联商品
	 * @param goods
	 * @return
	 */
	public List<Goods> findRelateGoods(@Param(value ="relateGoodsIds") List<String> relateGoodsIds);
	
	/**
	 * 单纯的更新商品状态接口
	 * @Title GoodsDao
	 * @Description TODO
	 * @Param @param goods
	 * @throws 
	 * @param goods
	 */
	public void updateGoodsStatus(Goods goods);
	
	
	/**
	 * 列出待关联商品列表（排除当前被关联商品数据，同时关联商品数据必须为非新建状态）
	 * @Param @param goods
	 * @param goods
	 * @return
	 */
	public List<Goods> listWaitRelatedGoods(Goods goods);

	/**
	 * 根据商品ID集合获取对应的商品信息
	 * @param ids
	 * @return
	 */
	public List<Goods> listGoodsByIds(@Param(value="ids") List<String> ids);
	
	//==================Syn Mobile Operator Interface START===============
	/**
	 * 根据商品编码或者商品名称查询货品（不包含伪删状态）
	 * @param key 查询关键字(商品编码或者商品名称)
	 * @return
	 */
	public List<Goods> getBySearchKey(String searchKey);
	
	//==================Syn Mobile Operator Interface END===============
	
	/**
	 * 根据商品ID更新商品属性字段
	 * @param goods
	 */
	public void updateGoodsPropertyStr(Goods goods);
	
	
	
}