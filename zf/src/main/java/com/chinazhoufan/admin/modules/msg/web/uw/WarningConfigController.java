/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.web.uw;


import java.util.List;

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
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningConfigService;
import com.chinazhoufan.api.common.service.ServiceException;

/**
 * 报警发送设置Controller
 * @author 刘晓东
 * @version 2015-12-11
 */
@Controller
@RequestMapping(value = "${adminPath}/msg/uw/warningConfig")
public class WarningConfigController extends BaseController {

	@Autowired
	private WarningConfigService warningConfigService;
	
	@ModelAttribute
	public WarningConfig get(@RequestParam(required=false) String id) {
		WarningConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = warningConfigService.get(id);
		}
		if (entity == null){
			entity = new WarningConfig();
		}
		return entity;
	}
	
	@RequiresPermissions("msg:uw:warningConfig:view")
	@RequestMapping(value = {"list", ""})
	public String list(WarningConfig warningConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WarningConfig> page = warningConfigService.findPage(new Page<WarningConfig>(request, response), warningConfig); 
		model.addAttribute("page", page);
		return "modules/msg/uw/warningConfigList";
	}

	@RequiresPermissions("msg:uw:warningConfig:view")
	@RequestMapping(value = "form")
	public String form(WarningConfig warningConfig, Model model) {
		//新增时设置默认值
		if (StringUtils.isBlank(warningConfig.getId())) {
			warningConfig.setUsableFlag(WarningConfig.TRUE_FLAG); //默认为启用
			warningConfig.setMonitorFlag(WarningConfig.TRUE_FLAG); //默认为启用监控
		}
		model.addAttribute("warningConfig", warningConfig);
		return "modules/msg/uw/warningConfigForm";
	}

	@RequiresPermissions("msg:uw:warningConfig:view")
	@RequestMapping(value = "info")
	public String info(WarningConfig warningConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(warningConfig == null || StringUtils.isBlank(warningConfig.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的报警发送设置信息！");
			return "error/400";
		}
		model.addAttribute("warningConfig", warningConfig);
		return "modules/msg/uw/warningConfigInfo";
	}
	
	@RequiresPermissions("msg:uw:warningConfig:edit")
	@RequestMapping(value = "save")
	public String save(WarningConfig warningConfig,HttpServletRequest request, HttpServletResponse response,   Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, warningConfig)){
			return form(warningConfig, model);
		}
		
		int resultType = warningConfigService.saveWarningConfig(warningConfig);
		if(resultType == 0) {
			addMessage(redirectAttributes, "保存报警发送设置成功");
		} else {
			addMessage(redirectAttributes, "失败：已存在同类型设置。\n友情提醒：警报类别、报警类型、接收类型、接收人全部一致只允许添加一条记录!");
		}
		return "redirect:"+Global.getAdminPath()+"/msg/uw/warningConfig/?repage";
	}
	
	@RequiresPermissions("msg:uw:warningConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(WarningConfig warningConfig, RedirectAttributes redirectAttributes) {
		if(warningConfig == null || StringUtils.isBlank(warningConfig.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的报警发送设置信息！");
			return "error/400";
		}
		warningConfigService.delete(warningConfig);
		addMessage(redirectAttributes, "删除报警发送设置成功");
		return "redirect:"+Global.getAdminPath()+"/msg/uw/warningConfig/?repage";
	}
	
	@RequiresPermissions("msg:uw:warningConfig:edit")
	@RequestMapping(value = "enable")
	public String enable(WarningConfig warningConfig,Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if(warningConfig == null || StringUtils.isBlank(warningConfig.getId())) {
			addMessage(model, "友情提示：未能获取到有效的报警发送设置信息！");
			return "error/400";
		}
		warningConfigService.enable(warningConfig);
		addMessage(model, "启用成功");
		return list(warningConfig, request, response, model);
	}
	
	@RequiresPermissions("msg:uw:warningConfig:edit")
	@RequestMapping(value = "disable")
	public String disable(WarningConfig warningConfig,Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if(warningConfig == null || StringUtils.isBlank(warningConfig.getId())) {
			addMessage(model, "友情提示：未能获取到有效的报警发送设置信息！");
			return "error/400";
		}
		warningConfigService.disable(warningConfig);
		addMessage(model, "停用成功");
		return list(warningConfig, request, response, model);
	}
	
	@RequiresPermissions("msg:uw:warningConfig:edit")
	@RequestMapping(value = "enableMonitor")
	public String enableMonitor(WarningConfig warningConfig,Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if(warningConfig == null || StringUtils.isBlank(warningConfig.getId())) {
			addMessage(model, "友情提示：未能获取到有效的监控信息！");
			return "error/400";
		}
		warningConfigService.enableMonitor(warningConfig);
		addMessage(model, "启用监控成功");
		return list(warningConfig, request, response, model);
	}
	
	@RequiresPermissions("msg:uw:warningConfig:edit")
	@RequestMapping(value = "disableMonitor")
	public String disableMonitor(WarningConfig warningConfig,Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if(warningConfig == null || StringUtils.isBlank(warningConfig.getId())) {
			addMessage(model, "友情提示：未能获取到有效的监控信息！");
			return "error/400";
		}
		warningConfigService.disableMonitor(warningConfig);
		addMessage(model, "停用监控成功");
		return list(warningConfig, request, response, model);
	}
	
}