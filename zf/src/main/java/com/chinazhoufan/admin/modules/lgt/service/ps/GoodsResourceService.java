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
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsResourceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsResource;

/**
 * 商品资源Service
 * @author 陈适
 * @version 2015-10-27
 */
@Service
@Transactional(readOnly = true)
public class GoodsResourceService extends CrudService<GoodsResourceDao, GoodsResource> {

	@Autowired
	private GoodsResourceDao goodsResourceDao;
	
	public GoodsResource get(String id) {
		return super.get(id);
	}
	
	public List<GoodsResource> findList(GoodsResource goodsResource) {
		return super.findList(goodsResource);
	}
	
	public Page<GoodsResource> findPage(Page<GoodsResource> page, GoodsResource lgtPsGoodsResource) {
		return super.findPage(page, lgtPsGoodsResource);
	}
	
	public List<GoodsResource> findByGoodsId(String id){
		return goodsResourceDao.findByGoodsId(id);
	}
	@Transactional(readOnly = false)
	public void save(GoodsResource goodsResource) {
		super.save(goodsResource);
	}
	
	/**
	 * 保存商品图册
	 * @param goodsResources
	 */
	@Transactional(readOnly = false)
	public void saveList(List<GoodsResource> goodsResources,Goods goods) {
		Integer a=0;
		for(GoodsResource resource:goodsResources){
			a++;
			resource.setOrderBy(a);
			resource.setGoods(goods);
			super.save(resource);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsResource lgtPsGoodsResource) {
		super.delete(lgtPsGoodsResource);
	}
	
	@Transactional(readOnly = false)
	public void remove(String goodsId) {
		goodsResourceDao.remove(goodsId);
	}

	public List<GoodsResource> findListByGoodsId(GoodsResource resource) {
		return goodsResourceDao.findListByGoodsId(resource);
	}
	
}