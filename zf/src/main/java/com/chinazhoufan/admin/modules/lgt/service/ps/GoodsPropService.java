/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsPropDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;

/**
 * 商品属性表Service
 * @author 陈适
 * @version 2015-10-20
 */
@Service
@Transactional(readOnly = true)
public class GoodsPropService extends CrudService<GoodsPropDao, GoodsProp> {
	
	@Autowired
	private GoodsPropvalueService goodsPropvalueService;
	
	@Autowired
	private GoodsPropDao goodsPropDao;
	
	@Autowired
	private ProducePropvalueService producePropvalueService;
	
	public GoodsProp get(String id) {
		return super.get(id);
	}
	
	public GoodsProp getGoodsPropByGoodIdAnPid(Map<String, Object>  map) {
		return goodsPropDao.getGoodsPropByGoodIdAnPid(map);
	}
	
	public List<GoodsProp> findList(GoodsProp goodsProp) {
		return super.findList(goodsProp);
	}
	
	public Page<GoodsProp> findPage(Page<GoodsProp> page, GoodsProp lgtPsGoodsProp) {
		return super.findPage(page, lgtPsGoodsProp);
	}
	
	public List<GoodsProp> findByGoodsId(String goodsId){
		return goodsPropDao.findByGoodsId(goodsId, GoodsProp.DEL_FLAG_NORMAL);
	}
	
	@Transactional(readOnly = false)
	public void save(GoodsProp lgtPsGoodsProp) {
		super.save(lgtPsGoodsProp);
	}
	
	@Transactional(readOnly = false)
	public void saveGoodsProp(GoodsPropvalue gpv) {
		Map<String, Object>  map = new HashMap<String, Object>();
		map.put("goodsId", gpv.getGoodsId());
		map.put("pid", gpv.getPid());
		GoodsProp temp = getGoodsPropByGoodIdAnPid(map);
		if(null == temp){
			gpv.preInsert();
			goodsPropDao.saveGoodsProp(gpv);
		}else{
			gpv.setGoodsProp(new GoodsProp(temp.getId()));
		}
	}
	
	@Transactional(readOnly = false)
	public void saveGoodsProps(List<GoodsPropvalue> addGoodPropVal) {
		for(GoodsPropvalue v:addGoodPropVal)
			saveGoodsProp(v);
	}
	
	/**
	 * 保存商品属性与属性值
	 * @param lgtPsGoodsProp
	 */
	@Transactional(readOnly = false)
	public void saveList(List<GoodsProp> lgtPsGoodsProp,Goods goods) {
		
		//获取该商品下所有的产品属性
		List<ProducePropvalue> producePropVList = producePropvalueService.findListByGoodsId(goods.getId());
		
		for(GoodsProp prop :lgtPsGoodsProp ){
			boolean isAdd = true;
			//判断商品属性是否有被产品使用，如果产品已使用，则抛异常
			for(ProducePropvalue ppv : producePropVList) {
				if(prop.getProperty().getId().equals(ppv.getProperty().getId())) {
					isAdd = false;
					throw new ServiceException("商品中已有属性被产品使用，请核查，对应的属性ID为："+prop.getProperty().getId());
				}
			}
			if(isAdd) {
				prop.setGoods(goods);
				super.save(prop);
				goodsPropvalueService.saveList(prop.getGoodsPropvalue(),prop);
			}
		}
	}
	
	/**
	 * 真删除商品属性与属性值
	 * @param lgtPsGoodsProp
	 */
	@Transactional(readOnly = false)
	public void remove(List<GoodsProp> lgtPsGoodsProp,String goodsId) {
		for(GoodsProp prop :lgtPsGoodsProp ){
			goodsPropvalueService.remove(prop.getId());
		}
		goodsPropDao.remove(goodsId);
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsProp lgtPsGoodsProp) {
		super.delete(lgtPsGoodsProp);
	}
	
	/**
	 * 根据商品属性主键ID真删除该商品对应的这条属性记录
	 * @param goodsProp
	 */
	@Transactional(readOnly = false)
	public void removeById(GoodsProp goodsProp) {
		goodsPropDao.removeById(goodsProp);
	}
	
	public List<GoodsProp> getGoodsId(String goodsId) {
		return goodsPropDao.getGoodsId(goodsId);
	}

	public List<GoodsProp> findByGoodsProp(GoodsProp goodsProp) {
		return goodsPropDao.findByGoodsProp(goodsProp);
	}
	
}