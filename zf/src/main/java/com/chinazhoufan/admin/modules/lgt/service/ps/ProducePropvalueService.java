/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProducePropvalueDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;
import com.google.common.collect.Maps;

/**
 * 产品组合属性值Service
 * @author 陈适
 * @version 2015-10-22
 */
@Service
@Transactional(readOnly = true)
public class ProducePropvalueService extends CrudService<ProducePropvalueDao, ProducePropvalue> {

	@Autowired
	private ProducePropvalueDao producePropvalueDao;
	
	@Autowired
	private GoodsPropService goodsPropService;
	
	@Autowired
	private GoodsPropvalueService goodsPropvalueService;
	
	@Autowired
	private GoodsDao goodsDao;
	
	
	
	public 	ProducePropvalue get(String id) {
		return super.get(id);
	}
	
	public List<ProducePropvalue> findList(ProducePropvalue lgtPsProducePropvalue) {
		return super.findList(lgtPsProducePropvalue);
	}
	
	public Page<ProducePropvalue> findPage(Page<ProducePropvalue> page, ProducePropvalue lgtPsProducePropvalue) {
		return super.findPage(page, lgtPsProducePropvalue);
	}
	
	@Transactional(readOnly = false)
	public void save(ProducePropvalue producePropvalue) {
		super.save(producePropvalue);
	}

	@Transactional(readOnly = false)
	public void delete(ProducePropvalue producePropvalue) {
		super.delete(producePropvalue);
	}
	
	@Transactional(readOnly = false)
	public void deleteByProduce(Produce produce) {
		producePropvalueDao.deleteByProduce(produce);
	}
	
	
	/**
	 * 根据传过来的 产品集合 分别保存他们的组合属性
	 * @param produces  产品集合 里面包含 产品组合属性集合<producePropValues>
	 */
	@Transactional(readOnly = false)
	public void saveList(List<ProducePropvalue> producePropvalues,Produce produce){
		
		//获取该产品对应的商品属性集合
		List<GoodsProp> goodsPropList = goodsPropService.findByGoodsId(produce.getGoods().getId());
		StringBuffer sb = new StringBuffer();
		
		for(ProducePropvalue producePropvalue : producePropvalues){
			
			for(GoodsProp gp : goodsPropList) {
				if(producePropvalue.getProperty().getId().equals(gp.getProperty().getId())) {
					//如果产品属性中包含商品属性，则把商品中该属性及对应的属性值删掉，这里是真删除
					goodsPropvalueService.remove(gp.getId());
					goodsPropService.removeById(gp);
				}
			}
			
			producePropvalue.setProduce(produce);
			save(producePropvalue);
		}
	}
	
	/**
	 * 根据商品id  关联查询 产品表查询 所有的 产品组合属性
	 * @param goodsId
	 * @return
	 */
	public List<ProducePropvalue> findListByGoodsId(String goodsId){
		Map<String, Object> map = Maps.newHashMap();
		map.put("goodsId", goodsId);
		map.put("delFlag", Produce.DEL_FLAG_NORMAL);
		return producePropvalueDao.findListByGoodsId(map);
	}
	
}