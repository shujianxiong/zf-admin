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
import com.chinazhoufan.admin.modules.cap.entity.cc.CapitalChange;
import com.chinazhoufan.admin.modules.cap.service.cc.CapitalChangeService;
import com.chinazhoufan.admin.modules.cap.service.cc.CapitalService;

/**
 * 资产设备变动记录Controller
 * @author 贾斌
 * @version 2015-12-08
 */
@Controller
@RequestMapping(value = "${adminPath}/cap/cc/capitalChange")
public class CapitalChangeController extends BaseController {

	@Autowired
	private CapitalChangeService capitalChangeService;//资产设备变动记录
	@Autowired
	private CapitalService capitalService;//公司资产
	
	@ModelAttribute
	public CapitalChange get(@RequestParam(required=false) String id) {
		CapitalChange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = capitalChangeService.get(id);
		}
		if (entity == null){
			entity = new CapitalChange();
		}
		return entity;
	}
	
	@RequiresPermissions("cap:cc:capitalChange:view")
	@RequestMapping(value = {"list", ""})
	public String list(CapitalChange capitalChange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CapitalChange> page = capitalChangeService.findPage(new Page<CapitalChange>(request, response), capitalChange); 
		model.addAttribute("page", page);
		return "modules/cap/cc/capitalChangeList";
	}

	@RequiresPermissions("cap:cc:capitalChange:view")
	@RequestMapping(value = "form")
	public String form(CapitalChange capitalChange, Model model,String vid) {
		Capital capital = capitalService.get(vid);
		capitalChange.setCapital(capital);
		model.addAttribute("capitalChange", capitalChange);
		return "modules/cap/cc/capitalChangeForm";
	}

	@RequiresPermissions("cap:cc:capitalChange:edit")
	@RequestMapping(value = "save")
	public String save(CapitalChange capitalChange, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, capitalChange)){
			return form(capitalChange, model,capitalChange.getCapital().getId());
		}
		capitalChangeService.save(capitalChange);
		addMessage(redirectAttributes, "保存资产设备变动记录成功");
		return "redirect:"+Global.getAdminPath()+"/cap/cc/capitalChange/?repage";
	}
	
	
	@RequiresPermissions("cap:cc:capitalChange:view")
	@RequestMapping(value = "form1")
	public String form1(CapitalChange capitalChange, Model model) {
		model.addAttribute("capitalChange", capitalChange);
		return "modules/cap/cc/capitalChangeForm";
	}

	@RequiresPermissions("cap:cc:capitalChange:edit")
	@RequestMapping(value = "save1")
	public String save1(CapitalChange capitalChange, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, capitalChange)){
			return form(capitalChange, model,capitalChange.getCapital().getId());
		}
		capitalChangeService.save(capitalChange);
		addMessage(redirectAttributes, "保存资产设备变动记录成功");
		return "redirect:"+Global.getAdminPath()+"/cap/cc/capitalChange/?repage";
	}
	
	@RequiresPermissions("cap:cc:capitalChange:edit")
	@RequestMapping(value = "delete")
	public String delete(CapitalChange capitalChange, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(capitalChange.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的资产设备变动记录！");
			return "error/400";
		}
		capitalChangeService.delete(capitalChange);
		addMessage(redirectAttributes, "删除资产设备变动记录成功");
		return "redirect:"+Global.getAdminPath()+"/cap/cc/capitalChange/?repage";
	}

	@RequiresPermissions("cap:cc:capitalChange:view")
	@RequestMapping(value = "info")
	public String info(CapitalChange capitalChange, HttpServletRequest request, HttpServletResponse response,  Model model,String vid) {
		if(StringUtils.isBlank(capitalChange.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的资产设备变动记录！");
			return "error/400";
		}
		model.addAttribute("capitalChange", capitalChange);
		return "modules/cap/cc/capitalChangeInfo";
	}
	
	
	
}