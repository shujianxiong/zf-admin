/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.dp;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchMissionService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchOrderService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchProduceService;
import com.chinazhoufan.admin.modules.lgt.service.dp.DispatchProductService;

/**
 * 调货任务Controller
 * @author 刘晓东
 * @version 2015-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/dp/dispatchMissionView")
public class DispatchMissionViewController extends BaseController {

	@Autowired
	private DispatchMissionService dispatchMissionService;
	@Autowired
	private DispatchProduceService dispatchProduceService;
	@Autowired
	private DispatchProductService dispatchProductService;
	@Autowired
	private DispatchOrderService dispatchOrderService;
	
	@ModelAttribute
	public DispatchMission get(@RequestParam(required=false) String id) {
		DispatchMission entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dispatchMissionService.get(id);
		}
		if (entity == null){
			entity = new DispatchMission();
		}
		return entity;
	}
	/**
	 * 查看所有调货任务
	 * @param dispatchMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:dp:dispatchMissionView:view")
	@RequestMapping(value = {"list", ""})
	public String list(DispatchMission dispatchMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DispatchMission> page = dispatchMissionService.findPage(new Page<DispatchMission>(request, response), dispatchMission); 
		model.addAttribute("page", page);
		return "modules/lgt/dp/dispatchMissionListAll";
	}

}