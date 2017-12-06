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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.sys.entity.IpConfig;
import com.chinazhoufan.admin.modules.sys.service.IpConfigService;

/**
 * IP白名单管理Controller
 * @author 陈适
 * @version 2015-11-20
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/ipConfig")
public class IpConfigController extends BaseController {

	@Autowired
	private IpConfigService ipConfigService;
	
	@ModelAttribute
	public IpConfig get(@RequestParam(required=false) String id) {
		IpConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ipConfigService.get(id);
		}
		if (entity == null){
			entity = new IpConfig();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:ipConfig:view")
	@RequestMapping(value = {"list", ""})
	public String list(IpConfig ipConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IpConfig> page = ipConfigService.findPage(new Page<IpConfig>(request, response), ipConfig); 
		model.addAttribute("page", page);
		return "modules/sys/ipConfigList";
	}

	@RequiresPermissions("sys:ipConfig:view")
	@RequestMapping(value = "form")
	public String form(IpConfig ipConfig, Model model) {
		//新增时默认设置为启用
		if(StringUtils.isBlank(ipConfig.getId())){
			ipConfig.setActiveFlag(IpConfig.TRUE_FLAG);
		}
		model.addAttribute("ipConfig", ipConfig);
		return "modules/sys/ipConfigForm";
	}

	@RequiresPermissions("sys:ipConfig:view")
	@RequestMapping(value = "info")
	public String info(IpConfig ipConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(ipConfig == null || StringUtils.isBlank(ipConfig.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的IP白名单信息！");
			return "error/400";
		}
		model.addAttribute("ipConfig", ipConfig);
		return "modules/sys/ipConfigInfo";
	}

	@RequiresPermissions("sys:ipConfig:edit")
	@RequestMapping(value="updateActiveFlag")
	public String updateActiveFlag (IpConfig ipConfig,String flag, HttpServletRequest request, HttpServletResponse response, Model model){
		if (StringUtils.isBlank(ipConfig.getId())) {
			addMessage(model, "未获取到有效的白名单信息！");
			return list(ipConfig, request, response, model);
		}
		if (StringUtils.isBlank(flag)) {
			addMessage(model, "未获取到有效参数信息！");
			return list(ipConfig, request, response, model);
		}
		try {
			IpConfig ipConfigOld = ipConfigService.get(ipConfig.getId());
			ipConfigOld.setActiveFlag(flag);
			ipConfigService.update(ipConfigOld);
			addMessage(model, "操作成功");
			return list(ipConfig, request, response, model);
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败");
			return list(ipConfig, request, response, model);
		}
	}
	
	
	@RequiresPermissions("sys:ipConfig:edit")
	@RequestMapping(value = "save")
	public String save(IpConfig ipConfig, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ipConfig)){
			return form(ipConfig, model);
		}
		ipConfigService.save(ipConfig);
		addMessage(redirectAttributes, "保存IP白名单成功");
		return "redirect:"+Global.getAdminPath()+"/sys/ipConfig/?repage";
	}
	
	@RequiresPermissions("sys:ipConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(IpConfig ipConfig, RedirectAttributes redirectAttributes) {
		if(ipConfig == null || StringUtils.isBlank(ipConfig.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的IP白名单信息！");
			return "error/400";
		}
		ipConfigService.delete(ipConfig);
		addMessage(redirectAttributes, "删除IP白名单成功");
		return "redirect:"+Global.getAdminPath()+"/sys/ipConfig/?repage";
	}

	
	/**
	 * 检测录入的IP是否全局唯一
	 * @param code
	 * @throws
	 */
	@ResponseBody
	@RequiresPermissions("sys:ipConfig:view")
	@RequestMapping(value = "uniqueCheck")
	public String uniqueCheck(String ip) {
		if (StringUtils.isNotBlank(ip) && ipConfigService.getUniqueByIP(ip)) {
			return "true";
		}
		return "false";
	}
	
}