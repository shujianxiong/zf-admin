/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Tags;

/**
 * 商品标签DAO接口
 * @author 贾斌
 * @version 2016-01-05
 */
@MyBatisDao
public interface TagsDao extends CrudDao<Tags> {
	public void remove(Map<String, Object> map);

	public void saveGoodsTags(Map<String, Object> map);

	public Goods findNavGoodsTags(Goods goods);

	public int findCount(Map<String, Object> map);
	
	public List<Tags> findAllList(Tags tags);

	/**
	 * 根据商品id 取关联标签
	 * @param goods
	 * @return
	 */
	public List<Tags> listTagsByGoodsId(Goods goods);

	public void removeByGoodsId(String goodsId);
}