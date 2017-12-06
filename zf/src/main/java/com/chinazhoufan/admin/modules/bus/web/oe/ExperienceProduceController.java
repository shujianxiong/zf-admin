/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.oe;

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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceProduceService;

/**
 * 体验产品Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/oe/experienceProduce")
public class ExperienceProduceController extends BaseController {

	@Autowired
	private ExperienceProduceService experienceProduceService;
	
	@ModelAttribute
	public ExperienceProduce get(@RequestParam(required=false) String id) {
		ExperienceProduce entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = experienceProduceService.get(id);
		}
		if (entity == null){
			entity = new ExperienceProduce();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:oe:experienceProduce:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExperienceProduce experienceProduce, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExperienceProduce> page = experienceProduceService.findPage(new Page<ExperienceProduce>(request, response), experienceProduce); 
		model.addAttribute("page", page);
		return "modules/bus/oe/experienceProduceList";
	}

	@RequiresPermissions("bus:oe:experienceProduce:view")
	@RequestMapping(value = "form")
	public String form(ExperienceProduce experienceProduce, Model model) {
		model.addAttribute("experienceProduce", experienceProduce);
		return "modules/bus/oe/experienceProduceForm";
	}

	@RequiresPermissions("bus:oe:experienceProduce:edit")
	@RequestMapping(value = "save")
	public String save(ExperienceProduce experienceProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, experienceProduce)){
			return form(experienceProduce, model);
		}
		experienceProduceService.save(experienceProduce);
		addMessage(redirectAttributes, "保存体验产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/oe/experienceProduce/?repage";
	}
	
	@RequiresPermissions("bus:oe:experienceProduce:edit")
	@RequestMapping(value = "delete")
	public String delete(ExperienceProduce experienceProduce, RedirectAttributes redirectAttributes) {
		experienceProduceService.delete(experienceProduce);
		addMessage(redirectAttributes, "删除体验产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/oe/experienceProduce/?repage";
	}

    @RequiresPermissions("bus:oe:experienceProduce:view")
    @RequestMapping(value = "info")
    public String info(ExperienceProduce experienceProduce, Model model) {
        model.addAttribute("experienceProduce", experienceProduce);
        return "modules/bus/oe/experienceProduceInfo";
    }
}