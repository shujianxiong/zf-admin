/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.crm.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 商品默认推荐表Api
 * @author 刘晓东
 * @version 2016-01-19
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class GoodsDefaultRecommendApi extends BaseController {

	
	/**
	 * 前台默认推荐商品列表查询接口（随机查询）
	 * @param serviceType 业务类型
	 * @param resultNum 结果数量 默认为“6”
	 * @return
	 */
	@RequestMapping(value = "/defaultRecommendGoods", method = RequestMethod.POST)
	public @ResponseBody
	String randomList(@RequestParam(value = "serviceType", required = true, defaultValue = "")String serviceType, @RequestParam(value = "resultNum", required = true, defaultValue = "6")Integer resultNum) {
		Echos echos = null;
		try {
			List<Goods> list = null;
			if(list.isEmpty()){
				echos = new Echos(Constants.NO_MESSAGE);
			}else {
				echos = new Echos(Constants.SUCCESS, list);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 前台首页查询默认推荐商品接口
	 * @param serviceType
	 * @param pageSize
	 * @param goPage
	 * @return
	 */
	@RequestMapping(value = "/defaultRecommendGoods/{goPage}", method = RequestMethod.POST)
	public @ResponseBody
	String list(@RequestParam(value = "serviceType", required = true, defaultValue = "")String serviceType, @RequestParam(value = "pageSize", required = true, defaultValue = "6")Integer pageSize,
				@PathVariable("goPage")Integer goPage){
		Echos echos = null;
		Page<Goods> page = new Page<Goods>();
		page.setPageSize(pageSize);
		page.setPageNo(goPage);
		try {
			page = null;
			echos = new Echos(Constants.SUCCESS, page);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
}