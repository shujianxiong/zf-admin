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
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierProduceService;

/**
 * 货品明细管理Service
 * @author 陈适
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class WapGoodsService extends CrudService<GoodsDao, Goods> {
	
	@Autowired
	private SupplierProduceService supplierProduceService;
	@Autowired
	private WapProduceService wapProduceService;
	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 根据商品编码或者商品名称查询货品（不包含伪删状态）
	 * @param key 查询关键字(商品编码或者商品名称)
	 * @return
	 */
	public List<Goods> getBySearchKey(String searchKey) {
		if(StringUtils.isBlank(searchKey)) return null;
		return dao.getBySearchKey(searchKey);
	}
	
	
	/**
	 * 根据商品ID获取商品明细及对应的产品规格及库存信息
	 * @param goodsId
	 * @return    商品基本信息及关联的产品规格及库存货位信息
	 * @throws
	 */
	public Goods getGoodsWithDetailById(String goodsId) {
		if(StringUtils.isBlank(goodsId)) return null;
		Goods goods = goodsService.find(goodsId);
		goods.setSupplierList(supplierProduceService.listSupplierByGoods(goodsId));
		List<Produce> produceList = wapProduceService.getFullProduceWithStockAndLocateByGoods(goodsId);
		goods.setProduces(produceList);
		return goods;
	}; 
	
	
	public Goods find(String goodsId) {
		return goodsService.find(goodsId);
	}
}