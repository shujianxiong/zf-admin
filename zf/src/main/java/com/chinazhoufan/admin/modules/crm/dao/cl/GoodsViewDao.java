/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.cl;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsView;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsViewListVO;

/**
 * 会员商品浏览记录DAO接口
 * @author 贾斌
 * @version 2016-01-11
 */
@MyBatisDao
public interface GoodsViewDao extends CrudDao<GoodsView> {

	public int getCountByMember(Member member);
	public GoodsView getGoodsView(Map<String, Object> map);
	public List<GoodsView> findGoodsViewList(GoodsViewListVO goodsViewListVO);
	public void deleteList(GoodsViewListVO goodsViewListVO);
	
}