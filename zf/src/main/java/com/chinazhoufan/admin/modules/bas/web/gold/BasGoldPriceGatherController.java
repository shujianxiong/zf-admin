/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web.gold;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.gold.BasGoldPriceGather;
import com.chinazhoufan.admin.modules.bas.service.gold.BasGoldPriceGatherService;

/**
 * 实时金价采集列表Controller
 * @author 贾斌
 * @version 2015-11-04
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/gold/basGoldPriceGather")
public class BasGoldPriceGatherController extends BaseController {

	@Autowired
	private BasGoldPriceGatherService basGoldPriceGatherService;
	
	@RequiresPermissions("bas:gold:basGoldPriceGather:view")
	@RequestMapping(value = {"list", ""})
	public String list(BasGoldPriceGather basGoldPriceGather, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BasGoldPriceGather> page = basGoldPriceGatherService.findPage(new Page<BasGoldPriceGather>(request, response), basGoldPriceGather); 
		model.addAttribute("page", page);
		return "modules/bas/gold/basGoldPriceGatherList";
	}
	
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = {"doList"})
	public BasGoldPriceGather doList(HttpServletRequest request,HttpServletResponse response) {
		Page<BasGoldPriceGather> page = basGoldPriceGatherService.findPage(new Page<BasGoldPriceGather>(request, response), new BasGoldPriceGather());
		if(page!=null&&page.getList()!=null&&page.getList().size()>0)
			return page.getList().get(0);
		return null;
	}

	@RequiresPermissions("bas:gold:basGoldPriceGather:view")
	@RequestMapping(value = "info")
	public String info(BasGoldPriceGather basGoldPriceGather, HttpServletRequest request,HttpServletResponse response,  Model model) {
		if(StringUtils.isBlank(basGoldPriceGather.getId())) {
			addMessage(model, "友情提示：未能获取到黄金价格策略信息!");
			return "error/400";
		}
		model.addAttribute("basGoldPriceGather", basGoldPriceGather);
		return "modules/bas/gold/basGoldPriceGatherInfo";
	}

}