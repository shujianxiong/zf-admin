/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.cap.web.cc;

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
import com.chinazhoufan.admin.modules.cap.entity.cc.Capital;
import com.chinazhoufan.admin.modules.cap.service.cc.CapitalService;

/**
 * 公司资产设备表Controller
 * @author 贾斌
 * @version 2015-12-08
 */
@Controller
@RequestMapping(value = "${adminPath}/cap/cc/capital")
public class CapitalController extends BaseController {

	@Autowired
	private CapitalService capitalService;
	
	@ModelAttribute
	public Capital get(@RequestParam(required=false) String id) {
		Capital entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = capitalService.get(id);
		}
		if (entity == null){
			entity = new Capital();
		}
		return entity;
	}
	
	@RequiresPermissions("cap:cc:capital:view")
	@RequestMapping(value = {"list", ""})
	public String list(Capital capital, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Capital> page = capitalService.findPage(new Page<Capital>(request, response), capital); 
		model.addAttribute("page", page);
		return "modules/cap/cc/capitalList";
	}

	@RequiresPermissions("cap:cc:capital:view")
	@RequestMapping(value = "form")
	public String form(Capital capital, Model model) {
		model.addAttribute("capital", capital);
		return "modules/cap/cc/capitalForm";
	}

	@RequiresPermissions("cap:cc:capital:edit")
	@RequestMapping(value = "save")
	public String save(Capital capital, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, capital)){
			return form(capital, model);
		}
		capitalService.save(capital);
		addMessage(redirectAttributes, "保存公司资产设备表成功");
		return "redirect:"+Global.getAdminPath()+"/cap/cc/capital/?repage";
	}
	
	@RequiresPermissions("cap:cc:capital:edit")
	@RequestMapping(value = "delete")
	public String delete(Capital capital, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(capital.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的公司资产记录！");
			return "error/400";
		}
		capitalService.delete(capital);
		addMessage(redirectAttributes, "删除公司资产设备表成功");
		return "redirect:"+Global.getAdminPath()+"/cap/cc/capital/?repage";
	}

	@RequiresPermissions("cap:cc:capital:view")
	@RequestMapping(value = "info")
	public String info(Capital capital, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(capital.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的公司资产记录！");
			return "error/400";
		}
		model.addAttribute("capital", capital);
		return "modules/cap/cc/capitalInfo";
	}

}