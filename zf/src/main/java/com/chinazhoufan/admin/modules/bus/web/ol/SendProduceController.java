/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

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
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduce;
import com.chinazhoufan.admin.modules.bus.service.ol.SendProduceService;

/**
 * 发货产品Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/sendProduce")
public class SendProduceController extends BaseController {

	@Autowired
	private SendProduceService sendProduceService;
	
	@ModelAttribute
	public SendProduce get(@RequestParam(required=false) String id) {
		SendProduce entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sendProduceService.get(id);
		}
		if (entity == null){
			entity = new SendProduce();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ol:sendProduce:view")
	@RequestMapping(value = {"list", ""})
	public String list(SendProduce sendProduce, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendProduce> page = sendProduceService.findPage(new Page<SendProduce>(request, response), sendProduce); 
		model.addAttribute("page", page);
		return "modules/bus/ol/sendProduceList";
	}

	@RequiresPermissions("bus:ol:sendProduce:view")
	@RequestMapping(value = "form")
	public String form(SendProduce sendProduce, Model model) {
		model.addAttribute("sendProduce", sendProduce);
		return "modules/bus/ol/sendProduceForm";
	}

	@RequiresPermissions("bus:ol:sendProduce:edit")
	@RequestMapping(value = "save")
	public String save(SendProduce sendProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sendProduce)){
			return form(sendProduce, model);
		}
		sendProduceService.save(sendProduce);
		addMessage(redirectAttributes, "保存发货产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendProduce/?repage";
	}
	
	@RequiresPermissions("bus:ol:sendProduce:edit")
	@RequestMapping(value = "delete")
	public String delete(SendProduce sendProduce, RedirectAttributes redirectAttributes) {
		sendProduceService.delete(sendProduce);
		addMessage(redirectAttributes, "删除发货产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendProduce/?repage";
	}

    @RequiresPermissions("bus:ol:sendProduce:view")
    @RequestMapping(value = "info")
    public String info(SendProduce sendProduce, Model model) {
        model.addAttribute("sendProduce", sendProduce);
        return "modules/bus/ol/sendProduceInfo";
    }
}