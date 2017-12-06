/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.web.um;

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
import com.chinazhoufan.admin.modules.msg.entity.um.MessageConfig;
import com.chinazhoufan.admin.modules.msg.service.um.MessageConfigService;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 员工消息发送设置Controller
 * @author 刘晓东
 * @version 2015-12-11
 */
@Controller
@RequestMapping(value = "${adminPath}/msg/um/messageConfig")
public class MessageConfigController extends BaseController {

	@Autowired
	private MessageConfigService messageConfigService;
	@Autowired
	private SystemService systemService;
	
	
	@ModelAttribute
	public MessageConfig get(@RequestParam(required=false) String id) {
		MessageConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = messageConfigService.get(id);
		}
		if (entity == null){
			entity = new MessageConfig();
		}
		return entity;
	}
	
	@RequiresPermissions("msg:um:messageConfig:view")
	@RequestMapping(value = {"list", ""})
	public String list(MessageConfig messageConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MessageConfig> page = messageConfigService.findPage(new Page<MessageConfig>(request, response), messageConfig); 
		model.addAttribute("page", page);
		return "modules/msg/um/messageConfigList";
	}

	@RequiresPermissions("msg:um:messageConfig:view")
	@RequestMapping(value = "form")
	public String form(MessageConfig messageConfig, Model model) {
		//新增时给radio赋默认值
		if (StringUtils.isBlank(messageConfig.getId())) {
			messageConfig.setUsableFlag(MessageConfig.TRUE_FLAG); //默认为启用
			messageConfig.setReceiveRole(UserUtils.getRoleList().get(0)); //设置默认角色
		}
		model.addAttribute("messageConfig", messageConfig);
		model.addAttribute("allRoles", systemService.findAllRole());
		return "modules/msg/um/messageConfigForm";
	}

	@RequiresPermissions("msg:um:messageConfig:view")
	@RequestMapping(value = "info")
	public String info(MessageConfig messageConfig, Model model) {
		model.addAttribute("messageConfig", messageConfig);
		model.addAttribute("allRoles", systemService.findAllRole());
		return "modules/msg/um/messageConfigInfo";
	}
	
	@RequiresPermissions("msg:um:messageConfig:edit")
	@RequestMapping(value = "save")
	public String save(MessageConfig messageConfig, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, messageConfig)){
			return form(messageConfig, model);
		}
		messageConfigService.save(messageConfig);
		addMessage(redirectAttributes, "保存员工消息发送设置成功");
		return "redirect:"+Global.getAdminPath()+"/msg/um/messageConfig/?repage";
	}
	
	@RequiresPermissions("msg:um:messageConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(MessageConfig messageConfig, RedirectAttributes redirectAttributes) {
		if(messageConfig == null || StringUtils.isBlank(messageConfig.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的员工消息发送设置记录!");
			return "error/400";
		}
		
		messageConfigService.delete(messageConfig);
		addMessage(redirectAttributes, "删除员工消息发送设置成功");
		return "redirect:"+Global.getAdminPath()+"/msg/um/messageConfig/?repage";
	}

	@RequiresPermissions("msg:um:messageConfig:edit")
	@RequestMapping(value = "enable")
	public String enable(MessageConfig messageConfig,Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		messageConfigService.enable(messageConfig);
		addMessage(model, "启用成功");
		return list(messageConfig, request, response, model);
	}
	
	@RequiresPermissions("msg:um:messageConfig:edit")
	@RequestMapping(value = "disable")
	public String disable(MessageConfig messageConfig, Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		messageConfigService.disable(messageConfig);
		addMessage(model, "停用成功");
		return list(messageConfig, request, response, model);
	}
}