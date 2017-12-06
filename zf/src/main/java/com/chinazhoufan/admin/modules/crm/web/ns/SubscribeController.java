/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.ns;

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
import com.chinazhoufan.admin.modules.crm.entity.ns.Subscribe;
import com.chinazhoufan.admin.modules.crm.service.ns.SubscribeService;

/**
 * 订阅Controller
 * @author 张金俊
 * @version 2017-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/ns/subscribe")
public class SubscribeController extends BaseController {

	@Autowired
	private SubscribeService subscribeService;
	
	@ModelAttribute
	public Subscribe get(@RequestParam(required=false) String id) {
		Subscribe entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = subscribeService.get(id);
		}
		if (entity == null){
			entity = new Subscribe();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:ns:subscribe:view")
	@RequestMapping(value = {"list", ""})
	public String list(Subscribe subscribe, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Subscribe> page = subscribeService.findPage(new Page<Subscribe>(request, response), subscribe); 
		model.addAttribute("page", page);
		return "modules/crm/ns/subscribeList";
	}

	@RequiresPermissions("crm:ns:subscribe:view")
	@RequestMapping(value = "form")
	public String form(Subscribe subscribe, Model model) {
		model.addAttribute("subscribe", subscribe);
		return "modules/crm/ns/subscribeForm";
	}

	@RequiresPermissions("crm:ns:subscribe:edit")
	@RequestMapping(value = "save")
	public String save(Subscribe subscribe, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, subscribe)){
			return form(subscribe, model);
		}
		subscribeService.save(subscribe);
		addMessage(redirectAttributes, "保存订阅成功");
		return "redirect:"+Global.getAdminPath()+"/crm/ns/subscribe/?repage";
	}
	
	@RequiresPermissions("crm:ns:subscribe:edit")
	@RequestMapping(value = "delete")
	public String delete(Subscribe subscribe, RedirectAttributes redirectAttributes) {
		subscribeService.delete(subscribe);
		addMessage(redirectAttributes, "删除订阅成功");
		return "redirect:"+Global.getAdminPath()+"/crm/ns/subscribe/?repage";
	}

    @RequiresPermissions("crm:ns:subscribe:view")
    @RequestMapping(value = "info")
    public String info(Subscribe subscribe, Model model) {
        model.addAttribute("subscribe", subscribe);
        return "modules/crm/ns/subscribeInfo";
    }
}