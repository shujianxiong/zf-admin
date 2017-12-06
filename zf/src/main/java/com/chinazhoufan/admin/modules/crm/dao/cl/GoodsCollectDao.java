/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.cl;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsCollect;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsCollectListVO;


/**
 * 会员商品收藏表DAO接口
 * @author 刘晓东
 * @version 2015-11-20
 */
@MyBatisDao
public interface GoodsCollectDao extends CrudDao<GoodsCollect> {
	/**
	 * 查询会员的收藏记录默认回选
	 * @param map
	 * @return
	 */
	public GoodsCollect getCollectionBtn(Map<String, Object> map);
	/**
	 * 查询会员所有商品
	 * **/
	public List<GoodsCollect> findGoodsCollectList(GoodsCollectListVO goodsCollectListVO);
	/**
	 * 删除收藏商品
	 */
	public void deleteList(GoodsCollectListVO goodsCollectListVO);

	public int getCountByMember(Member member);
	
	/**
	 * 根据会员ID、商品ID查询会员商品收藏记录
	 * @param memberId
	 * @param goodsId
	 * @return
	 */
	public List<GoodsCollect> findByMemberIdAndGoodsId(String memberId, String goodsId);
	
	public List<GoodsCollect> findBuyGoodsCollectPage(GoodsCollect collect);
}