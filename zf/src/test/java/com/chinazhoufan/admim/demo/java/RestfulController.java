/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admim.demo.java;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsCollectService;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;

/**
 * restful接口示例
 * @author abc
 *
 */

@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class RestfulController extends BaseController {

	@Autowired
	private GoodsCollectService goodsCollectService;
	@Autowired
	public GoodsService goodsService;
	
	/**
	 * 喜欢商品/取消喜欢ajax
	 * @param member.id
	 * @param goods.id
	 * @param
	 * @return
	 */
	//@RequestMapping(value = "/member/likeBtn/{goodsId}", method = RequestMethod.GET)
	/*public @ResponseBody String likeSave(@PathVariable("goodsId")String goodsId) {
		Echos echos = null;
		try {
			// 根据ID查商品
			Goods goods = goodsService.get(goodsId);
			//如果没有收藏记录，则创建喜欢记录,如果有,则取消
			goodsLikeService.likeBtn(goods);
			
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}*/

	/**
	 * 收藏商品/取消收藏ajax
	 * @param member.id
	 * @param goods.id
	 * @param
	 * @return
	 */
	/*@RequestMapping(value = "/member/collectionBtn/{goodsId}", method = RequestMethod.GET)
	public @ResponseBody String save(@PathVariable("goodsId")String goodsId, String productCode) {
		Echos echos = null;
		try {
			// 根据ID查商品
			Goods goods = goodsService.get(goodsId);
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}*/
}