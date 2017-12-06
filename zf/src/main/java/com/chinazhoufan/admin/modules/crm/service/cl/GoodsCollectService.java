/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.cl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.dao.cl.GoodsCollectDao;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsCollect;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsCollectListVO;
import com.google.common.collect.Maps;

/**
 * 会员商品收藏表Service
 * @author 刘晓东
 * @version 2015-11-20
 */
@Service
@Transactional(readOnly = true)
public class GoodsCollectService extends CrudService<GoodsCollectDao, GoodsCollect> {

	public GoodsCollect get(String id) {
		return super.get(id);
	}
	
	public List<GoodsCollect> findList(GoodsCollect goodsCollect) {
		return super.findList(goodsCollect);
	}
	
	public Page<GoodsCollect> findPage(Page<GoodsCollect> page, GoodsCollect goodsCollect) {
		return super.findPage(page, goodsCollect);
	}
	
	public Page<GoodsCollect> findGoodsCollectList(GoodsCollectListVO goodsCollectListVO,Page<GoodsCollect> page, HttpServletRequest request){
		goodsCollectListVO.setPage(page);
		goodsCollectListVO.setMember(MemberUtils.getMember(request));
		List<GoodsCollect> goodsCollectList = dao.findGoodsCollectList(goodsCollectListVO);
		page.setList(goodsCollectList);
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(Goods goods, HttpServletRequest request) {
		GoodsCollect goodsCollect = new GoodsCollect();
		goodsCollect.setGoods(goods);
		goodsCollect.setMember(MemberUtils.getMember(request));
		goodsCollect.setCreateBy(UserUtils.getAdmin());
		goodsCollect.setCreateDate(new Date());
		goodsCollect.setUpdateBy(UserUtils.getAdmin());
		goodsCollect.setUpdateDate(new Date());
		super.save(goodsCollect);
	}
	//查询用户已经收藏的商品
	public GoodsCollect getCollectionBtn(String memberId,String goodsId){
		Map<String, Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("goodsId", goodsId);
		return dao.getCollectionBtn(map);
	}
	
	@Transactional(readOnly = false)
	public void delete(Goods goods, HttpServletRequest request) {
		GoodsCollect goodsCollect = new GoodsCollect();
		goodsCollect.setGoods(goods);
		goodsCollect.setMember(MemberUtils.getMember(request));
		super.delete(goodsCollect);
	}
	@Transactional(readOnly = false)
	public void deleteList(GoodsCollectListVO goodsCollectListVO) {
		dao.deleteList(goodsCollectListVO);
	}
	/**
	 * 根据用户id 获取收藏的商品数
	 * @param member
	 * @return
	 */
	public int getCountByMember(Member member) {
		return dao.getCountByMember(member);
	}
	
	@Transactional(readOnly = false)
	public void collectionBtn(Goods goods, HttpServletRequest request){
		//根据商品ID 查询获取商品收藏记录。
		GoodsCollect goodsCollect = this.getCollectionBtn(MemberUtils.getMember(request).getId(), goods.getId());
		if(goodsCollect ==null){
			//如果没有收藏记录，则创建收藏记录
			this.save(goods, request);
		}else{//如果有,则取消
			this.delete(goods, request);
		}
	}
	
	/**
	 * 个人中心小咖秀 -发表小咖秀-选择商品
	 * return 商品id，名称，缩略图 
	 */
	public Page<GoodsCollect> findBuyGoodsCollectPage(Page<GoodsCollect> page, GoodsCollect collect) {
		collect.setPage(page);
		page.setList(dao.findBuyGoodsCollectPage(collect));
		return page;
	}
	
}