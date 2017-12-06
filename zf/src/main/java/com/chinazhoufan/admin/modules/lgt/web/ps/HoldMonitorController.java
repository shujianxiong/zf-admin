/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.HoldMonitor;
import com.chinazhoufan.admin.modules.lgt.service.ps.HoldMonitorService;

/**
 * 货品持有监控管理Controller
 * @author 刘晓东
 * @version 2015-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/holdMonitor")
public class HoldMonitorController extends BaseController {

	@Autowired
	private HoldMonitorService holdMonitorService;
	
	@ModelAttribute
	public HoldMonitor get(@RequestParam(required=false) String id) {
		HoldMonitor entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = holdMonitorService.get(id);
		}
		if (entity == null){
			entity = new HoldMonitor();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsHoldMonitor:view")
	@RequestMapping(value = {"list", ""})
	public String list(HoldMonitor holdMonitor, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<HoldMonitor> page = holdMonitorService.findPage(new Page<HoldMonitor>(request, response), holdMonitor); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/holdMonitorList";
	}
	
	@RequestMapping(value = "info")
	public String Info(HoldMonitor holdMonitor, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(holdMonitor.getId())) {
			addMessage(model, "友情提示：未能获取到商品持有监控管理信息！");
			return "error/400";
		}
		model.addAttribute("lgtPsHoldMonitor", holdMonitor);
		return "modules/lgt/ps/holdMonitorInfo";
	}

}