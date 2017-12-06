/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.cl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.dao.cl.GoodsViewDao;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsView;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsDao;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsViewListVO;
import com.google.common.collect.Maps;

/**
 * 会员商品浏览记录Service
 * @author 贾斌
 * @version 2016-01-11
 */
@Service
@Transactional(readOnly = true)
public class GoodsViewService extends CrudService<GoodsViewDao, GoodsView> {

	@Autowired
	public GoodsDao goodsDao;
	public GoodsView get(String id) {
		return super.get(id);
	}
	
	public List<GoodsView> findList(GoodsView goodsView) {
		return super.findList(goodsView);
	}
	
	public Page<GoodsView> findPage(Page<GoodsView> page, GoodsView goodsView) {
		return super.findPage(page, goodsView);
	}
	
	public Page<GoodsView> findGoodsViewList(GoodsViewListVO goodsViewListVO,Page<GoodsView> page, HttpServletRequest request){
		goodsViewListVO.setPage(page);
		goodsViewListVO.setMember(MemberUtils.getMember(request));
		List<GoodsView> goodsViews = dao.findGoodsViewList(goodsViewListVO);
		page.setList(goodsViews);
		return page;
	}
	
	@Transactional(readOnly = false)
	public void deleteList(GoodsViewListVO goodsViewListVO) {
		dao.deleteList(goodsViewListVO);
	}
	@Transactional(readOnly = false)
	public void save(GoodsView goodsView) {
		goodsView.setViewCount(goodsView.getViewCount() + 1);
		goodsView.setCreateBy(UserUtils.get(GoodsView.TRUE_FLAG));//默认是系统用户
		goodsView.setUpdateBy(UserUtils.get(GoodsView.TRUE_FLAG));//默认是系统用户
		goodsView.setCreateDate(new Date());
		goodsView.setUpdateDate(new Date());
		super.save(goodsView);
	}
	@Transactional(readOnly = false)
	public GoodsView getGoodsView(String goodsId, String memberId){
		Map<String, Object> map = Maps.newHashMap();
		map.put("goodsId", goodsId);
		map.put("memberId", memberId);
		return dao.getGoodsView(map);
	}
	@Transactional(readOnly = false)
	public void saveWeb(String memberId,String goodsId) {
		GoodsView goodsView = new GoodsView();
		goodsView.setMember(MemberUtils.getMemberById(memberId));
		goodsView.setGoods(goodsDao.get(goodsId));
		goodsView.setViewCount(GoodsView.FLAG_1);
		goodsView.setCreateBy(UserUtils.get(GoodsView.TRUE_FLAG));//默认是系统用户
		goodsView.setUpdateBy(UserUtils.get(GoodsView.TRUE_FLAG));//默认是系统用户
		goodsView.setCreateDate(new Date());
		goodsView.setUpdateDate(new Date());
		super.save(goodsView);
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsView goodsView) {
		super.delete(goodsView);
	}

	/**
	 * 根据用户id 查询浏览过的商品数
	 * @param member
	 * @return
	 */
	public int getCountByMember(Member member) {
		return dao.getCountByMember(member);
	}
	
}