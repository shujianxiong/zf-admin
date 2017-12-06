/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.goldPrice;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.gold.BasGoldPriceGather;
import com.chinazhoufan.admin.modules.bas.service.gold.BasGoldPriceGatherService;

/**
 * 实时金价采集列表ControllerWeb
 * @author 贾斌
 * @version 2015-11-04
 */
@Controller
@RequestMapping(value = "${frontPath}/goldPriceGatherWeb")
public class WapGoldPriceGatherController extends BaseController {

	@Autowired
	private BasGoldPriceGatherService basGoldPriceGatherService;
	
	
	@RequestMapping(value = {"doList"})
	public void doList(HttpServletResponse response) {
		List<BasGoldPriceGather> page = basGoldPriceGatherService.findList(null); 
		renderString(response, JsonMapper.toJsonString(page));
	}

	

}