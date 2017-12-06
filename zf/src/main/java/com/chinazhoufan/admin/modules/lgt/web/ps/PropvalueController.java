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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;
import com.chinazhoufan.admin.modules.lgt.service.ps.PropvalueService;

/**
 * 产品属性值Controller
 * @author 杨晓辉
 * @version 2015-10-14
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/propvalue")
public class PropvalueController extends BaseController {

	@Autowired
	private PropvalueService propvalueService;
	
	@ModelAttribute
	public Propvalue get(@RequestParam(required=false) String id) {
		Propvalue entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = propvalueService.get(id);
		}
		if (entity == null){
			entity = new Propvalue();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsPropvalue:view")
	@RequestMapping(value = {"list", ""})
	public String list(Propvalue propvalue, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Propvalue> page = propvalueService.findPage(new Page<Propvalue>(request, response), propvalue); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/propvalueList";
	}

	@RequiresPermissions("lgt:ps:lgtPsPropvalue:view")
	@RequestMapping(value = "form")
	public String form(Propvalue propvalue, Model model) {
		model.addAttribute("propvalue", propvalue);
		return "modules/lgt/ps/propvalueForm";
	}

	@RequiresPermissions("lgt:ps:lgtPsPropvalue:edit")
	@RequestMapping(value = "save")
	public String save(Propvalue propvalue, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, propvalue)){
			return form(propvalue, model);
		}
		propvalueService.save(propvalue);
		addMessage(redirectAttributes, "保存属性值成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/propvalue/?repage";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsPropvalue:edit")
	@RequestMapping(value = "delete")
	public String delete(Propvalue propvalue, RedirectAttributes redirectAttributes) {
		if(propvalue == null || StringUtils.isBlank(propvalue.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的属性值信息！");
			return "error/400";
		}
		
		propvalueService.delete(propvalue);
		addMessage(redirectAttributes, "删除属性值成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/propvalue/?repage";
	}

}