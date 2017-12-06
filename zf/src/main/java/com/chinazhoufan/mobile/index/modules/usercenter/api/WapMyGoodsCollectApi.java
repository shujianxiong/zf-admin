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
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsCollect;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsCollectService;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.GoodsCollectListVO;

/**
 * 会员收藏所有商品Controller
 * @author 贾斌
 * @version 2016-01-15
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class WapMyGoodsCollectApi extends BaseController {

	@Autowired
	private GoodsCollectService goodsCollectService;
	
	/**
	 * 查询会员的所有收藏
	 * @param goodsCollectListVO 
	 * @return
	 */
	@RequestMapping(value = "/member/findGoodsCollectList/{goPage}", method = RequestMethod.POST)
	public @ResponseBody String findGoodsCollectList(GoodsCollectListVO goodsCollectListVO, @PathVariable("goPage")Integer goPage, HttpServletRequest request){
		Echos echos= null;
		try {
			Page<GoodsCollect> page = new Page<GoodsCollect>(goodsCollectListVO.getGoPage(), GoodsCollectListVO.PAGE_SIZE);
			if(null != MemberUtils.getMember(request)){
				page = goodsCollectService.findGoodsCollectList(goodsCollectListVO, page, request);
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
	 * 删除收藏商品
	 * @param goodsCollectListVO 
	 * @return
	 */
	@RequestMapping(value = "/member/removeGoodsCollect", method = RequestMethod.POST)
	public @ResponseBody String removeGoodsCollect(GoodsCollectListVO goodsCollectListVO, HttpServletRequest request){
		Echos echos= null;
		try {
			if(null != MemberUtils.getMember(request)){
				goodsCollectService.deleteList(goodsCollectListVO);
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