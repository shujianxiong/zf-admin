/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.sp;

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
import com.chinazhoufan.admin.modules.bus.entity.sp.ShoppingcartProduce;
import com.chinazhoufan.admin.modules.bus.service.sp.ShoppingcartProduceService;

/**
 * 购物车产品表Controller
 * @author liut
 * @version 2016-12-02
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/sp/shoppingcartProduce")
public class ShoppingcartProduceController extends BaseController {

	@Autowired
	private ShoppingcartProduceService shoppingcartProduceService;
	
	@ModelAttribute
	public ShoppingcartProduce get(@RequestParam(required=false) String id) {
		ShoppingcartProduce entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = shoppingcartProduceService.get(id);
		}
		if (entity == null){
			entity = new ShoppingcartProduce();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:sp:shoppingcartProduce:view")
	@RequestMapping(value = {"list", ""})
	public String list(ShoppingcartProduce shoppingcartProduce, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ShoppingcartProduce> page = shoppingcartProduceService.findPage(new Page<ShoppingcartProduce>(request, response), shoppingcartProduce); 
		model.addAttribute("page", page);
		return "modules/bus/sp/shoppingcartProduceList";
	}

	@RequiresPermissions("bus:sp:shoppingcartProduce:view")
	@RequestMapping(value = "form")
	public String form(ShoppingcartProduce shoppingcartProduce, Model model) {
		model.addAttribute("shoppingcartProduce", shoppingcartProduce);
		return "modules/bus/sp/shoppingcartProduceForm";
	}

	@RequiresPermissions("bus:sp:shoppingcartProduce:edit")
	@RequestMapping(value = "save")
	public String save(ShoppingcartProduce shoppingcartProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, shoppingcartProduce)){
			return form(shoppingcartProduce, model);
		}
		shoppingcartProduceService.save(shoppingcartProduce);
		addMessage(redirectAttributes, "保存购物车产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/sp/shoppingcartProduce/?repage";
	}
	
	@RequiresPermissions("bus:sp:shoppingcartProduce:edit")
	@RequestMapping(value = "delete")
	public String delete(ShoppingcartProduce shoppingcartProduce, RedirectAttributes redirectAttributes) {
		shoppingcartProduceService.delete(shoppingcartProduce);
		addMessage(redirectAttributes, "删除购物车产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/sp/shoppingcartProduce/?repage";
	}

    @RequiresPermissions("bus:sp:shoppingcartProduce:view")
    @RequestMapping(value = "info")
    public String info(ShoppingcartProduce shoppingcartProduce, Model model) {
        model.addAttribute("shoppingcartProduce", shoppingcartProduce);
        return "modules/bus/sp/shoppingcartProduceInfo";
    }
}