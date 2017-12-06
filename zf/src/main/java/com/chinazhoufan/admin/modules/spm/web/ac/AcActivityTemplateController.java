/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ac;

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
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivityTemplate;
import com.chinazhoufan.admin.modules.spm.service.ac.AcActivityTemplateService;

/**
 * 调研活动模板Controller
 * @author liut
 * @version 2016-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ac/acActivityTemplate")
public class AcActivityTemplateController extends BaseController {

	@Autowired
	private AcActivityTemplateService acActivityTemplateService;
	
	@ModelAttribute
	public AcActivityTemplate get(@RequestParam(required=false) String id) {
		AcActivityTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
//			entity = acActivityTemplateService.get(id);
		}
		if (entity == null){
			entity = new AcActivityTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ac:acActivityTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(AcActivityTemplate acActivityTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AcActivityTemplate> page = acActivityTemplateService.findPage(new Page<AcActivityTemplate>(request, response), acActivityTemplate); 
		model.addAttribute("page", page);
		return "modules/spm/ac/acActivityTemplateList";
	}

	@RequiresPermissions("spm:ac:acActivityTemplate:view")
	@RequestMapping(value = "form")
	public String form(AcActivityTemplate acActivityTemplate, Model model) {
		if(StringUtils.isBlank(acActivityTemplate.getId())) {
			acActivityTemplate.setActiveFlag(AcActivityTemplate.TRUE_FLAG);
			model.addAttribute("acActivityTemplate", acActivityTemplate);
		} else {
			AcActivityTemplate at = acActivityTemplateService.get(acActivityTemplate);
			model.addAttribute("acActivityTemplate", at);
		}
		return "modules/spm/ac/acActivityTemplateForm";
	}

	@RequiresPermissions("spm:ac:acActivityTemplate:edit")
	@RequestMapping(value = "save")
	public String save(AcActivityTemplate acActivityTemplate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, acActivityTemplate)){
			return form(acActivityTemplate, model);
		}
		acActivityTemplateService.save(acActivityTemplate);
		addMessage(redirectAttributes, "保存调研活动模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/acActivityTemplate/?repage";
	}
	
	@RequiresPermissions("spm:ac:acActivityTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(AcActivityTemplate acActivityTemplate, RedirectAttributes redirectAttributes) {
		if(acActivityTemplate == null || StringUtils.isBlank(acActivityTemplate.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调研活动模板信息！");
			return "error/400";
		}
		
		acActivityTemplateService.delete(acActivityTemplate);
		addMessage(redirectAttributes, "删除调研活动模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/acActivityTemplate/?repage";
	}

	@RequiresPermissions("spm:ac:acActivityTemplate:view")
	@RequestMapping(value = "info")
	public String info(AcActivityTemplate acActivityTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(acActivityTemplate == null || StringUtils.isBlank(acActivityTemplate.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的调研活动模板信息！");
			return "error/400";
		}
		
		AcActivityTemplate at = acActivityTemplateService.get(acActivityTemplate);
		model.addAttribute("acActivityTemplate", at);
		return "modules/spm/ac/acActivityTemplateInfo";
	}
	
	@RequestMapping(value = "select")
	public String select(AcActivityTemplate acActivityTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		acActivityTemplate.setActiveFlag(AcActivityTemplate.TRUE_FLAG);
		Page<AcActivityTemplate> page = acActivityTemplateService.findPage(new Page<AcActivityTemplate>(request,response), acActivityTemplate);
		model.addAttribute("page", page);
		return "modules/spm/ac/acActivityTemplateSelect";
	}

	
	@RequiresPermissions("spm:ac:acActivityTemplate:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(AcActivityTemplate acActivityTemplate, Model model, RedirectAttributes redirectAttributes){
		if(acActivityTemplate == null || StringUtils.isBlank(acActivityTemplate.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到有效的调研活动模板信息！");
			return "error/400";
		}
		
		acActivityTemplateService.save(acActivityTemplate);
		addMessage(redirectAttributes, "活动模板状态修改成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/acActivityTemplate/?repage";
	}
	
	
}