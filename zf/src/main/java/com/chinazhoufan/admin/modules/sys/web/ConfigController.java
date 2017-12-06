/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;

/**
 * 系统业务参数表Controller
 * @author 刘晓东
 * @version 2015-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/config")
public class ConfigController extends BaseController {

	@Autowired
	private ConfigService configService;
	
	@ModelAttribute
	public Config get(@RequestParam(required=false) String id) {
		Config entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = configService.get(id);
		}
		if (entity == null){
			entity = new Config();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:config:view")
	@RequestMapping(value = {"list", ""})
	public String list(Config config, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Config> page = configService.findPage(new Page<Config>(request, response), config); 
		model.addAttribute("page", page);
		return "modules/sys/configList";
	}

	@RequiresPermissions("sys:config:view")
	@RequestMapping(value = "form")
	public String form(Config config, Model model) {
		model.addAttribute("config", config);
		return "modules/sys/configForm";
	}

	@RequiresPermissions("sys:config:view")
	@RequestMapping(value = "info")
	public String info(Config config, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(config == null || StringUtils.isBlank(config.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的系统业务参数信息！");
			return "error/400";
		}
		model.addAttribute("config", config);
		return "modules/sys/configInfo";
	}
	
	@RequiresPermissions("sys:config:edit")
	@RequestMapping(value = "save")
	public String save(Config config, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, config)){
			return form(config, model);
		}
		configService.save(config);
		addMessage(redirectAttributes, "保存系统业务参数表成功");
		return "redirect:"+Global.getAdminPath()+"/sys/config/?repage";
	}
	
	@RequiresPermissions("sys:config:edit")
	@RequestMapping(value = "delete")
	public String delete(Config config, RedirectAttributes redirectAttributes) {
		if(config == null || StringUtils.isBlank(config.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的系统业务参数信息！");
			return "error/400";
		}
		
		configService.delete(config);
		addMessage(redirectAttributes, "删除系统业务参数表成功");
		return "redirect:"+Global.getAdminPath()+"/sys/config/?repage";
	}

}