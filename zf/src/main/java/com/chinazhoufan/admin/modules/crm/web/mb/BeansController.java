/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mb;

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
import com.chinazhoufan.admin.modules.crm.entity.mb.Beans;
import com.chinazhoufan.admin.modules.crm.service.mb.BeansService;

/**
 * 会员魅力豆Controller
 * @author 张金俊
 * @version 2017-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mb/beans")
public class BeansController extends BaseController {

	@Autowired
	private BeansService beansService;
	
	@ModelAttribute
	public Beans get(@RequestParam(required=false) String id) {
		Beans entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = beansService.get(id);
		}
		if (entity == null){
			entity = new Beans();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mb:beans:view")
	@RequestMapping(value = {"list", ""})
	public String list(Beans beans, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Beans> page = beansService.findPage(new Page<Beans>(request, response), beans); 
		model.addAttribute("page", page);
		return "modules/crm/mb/beansList";
	}

	@RequiresPermissions("crm:mb:beans:view")
	@RequestMapping(value = "form")
	public String form(Beans beans, Model model) {
		model.addAttribute("beans", beans);
		return "modules/crm/mb/beansForm";
	}

	@RequiresPermissions("crm:mb:beans:edit")
	@RequestMapping(value = "save")
	public String save(Beans beans, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, beans)){
			return form(beans, model);
		}
		beansService.save(beans);
		addMessage(redirectAttributes, "保存会员魅力豆成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beans/?repage";
	}
	
	@RequiresPermissions("crm:mb:beans:edit")
	@RequestMapping(value = "delete")
	public String delete(Beans beans, RedirectAttributes redirectAttributes) {
		beansService.delete(beans);
		addMessage(redirectAttributes, "删除会员魅力豆成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beans/?repage";
	}

    @RequiresPermissions("crm:mb:beans:view")
    @RequestMapping(value = "info")
    public String info(Beans beans, Model model) {
        model.addAttribute("beans", beans);
        return "modules/crm/mb/beansInfo";
    }
}