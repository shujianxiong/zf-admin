/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.TagsDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Tags;
import com.google.common.collect.Maps;

/**
 * 商品标签Service
 * @author 贾斌
 * @version 2016-01-05
 */
@Service
@Transactional(readOnly = true)
public class TagsService extends CrudService<TagsDao, Tags> {

	public Tags get(String id) {
		return super.get(id);
	}
	
	public List<Tags> findList(Tags tags) {
		return super.findList(tags);
	}
	
	public List<Tags> findAllList(Tags tags) {
		return dao.findAllList(tags);
	}
	
	public Page<Tags> findPage(Page<Tags> page, Tags tags) {
		return super.findPage(page, tags);
	}
	
	@Transactional(readOnly = false)
	public void save(Tags tags) {
		super.save(tags);
	}
	
	@Transactional(readOnly = false)
	public void delete(Tags tags) {
		super.delete(tags);
	}
	
	@Transactional(readOnly =false)
	public void remove(String goodsId, String tagsId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("tagsId", tagsId);
		map.put("goodsId", goodsId);
		dao.remove(map);
	}
	/**
	 * 保存商品标签关联记录
	 * 先删掉已有记录，然后再重新保存
	 * @param goodsId
	 * @param tagIds
	 */
	@Transactional(readOnly =false)
	public void saveGoodsTags(String goodsId, String[] tagIds){
		
		dao.removeByGoodsId(goodsId);
		if (tagIds != null) {
			Map<String, Object> map = Maps.newHashMap();
			for (String tagId : tagIds) {
				map.put("tagsId", tagId);
				map.put("goodsId", goodsId);
				dao.saveGoodsTags(map);
				map.clear();
			}
		}

	}

	public Goods findNavGoodsTags(Goods goods) {
		if(null != goods.getTagss()&& goods.getTagss().size() !=0)
			return dao.findNavGoodsTags(goods);
		return null;
	}

	public int findCount(Map<String, Object> map) {
		return dao.findCount(map);
	}
	
	public List<Tags> listTagsByGoodsId(Goods goods) {
		return dao.listTagsByGoodsId(goods);
	}
	
}