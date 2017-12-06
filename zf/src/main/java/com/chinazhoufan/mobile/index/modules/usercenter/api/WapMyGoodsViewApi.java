/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.api;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsView;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsViewService;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsCollectListVO;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsViewListVO;

/**
 * 会员浏览过的所有商品Controller
 * @author 贾斌
 * @version 2016-01-15
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class WapMyGoodsViewApi extends BaseController {

	@Autowired
	private GoodsViewService goodsViewService;
	
	/**
	 * 查询会员的所有浏览过的商品
	 * @param goodsViewListVO 
	 * @return
	 */
	@RequestMapping(value = "/member/findGoodsViewList/{goPage}", method = RequestMethod.POST)
	public @ResponseBody String findGoodsCollectList(GoodsViewListVO goodsViewListVO, @PathVariable("goPage")Integer goPage, HttpServletRequest request){
		Echos echos= null;
		try {
			Page<GoodsView> page = new Page<GoodsView>(goodsViewListVO.getGoPage(), GoodsCollectListVO.PAGE_SIZE);
			if(null != MemberUtils.getMember(request)){
				page = goodsViewService.findGoodsViewList(goodsViewListVO, page, request);
				echos = new Echos(Constants.SUCCESS, page);
			}else{
				echos = new Echos(Constants.NOT_LOGIN);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 删除浏览过的商品
	 * @param goodsViewListVO 
	 * @return
	 */
	@RequestMapping(value = "/member/removeGoodsView", method = RequestMethod.POST)
	public @ResponseBody String removeGoodsCollect(GoodsViewListVO goodsViewListVO, HttpServletRequest request){
		Echos echos= null;
		try {
			if(null != MemberUtils.getMember(request)){
				goodsViewService.deleteList(goodsViewListVO);
				echos = new Echos(Constants.SUCCESS);
			}else{
				echos = new Echos(Constants.NOT_LOGIN);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	
}