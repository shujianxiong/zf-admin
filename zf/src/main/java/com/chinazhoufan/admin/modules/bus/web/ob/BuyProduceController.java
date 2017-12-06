/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ob;

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
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyProduce;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyProduceService;

/**
 * 购买产品Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ob/buyProduce")
public class BuyProduceController extends BaseController {

	@Autowired
	private BuyProduceService buyProduceService;
	
	@ModelAttribute
	public BuyProduce get(@RequestParam(required=false) String id) {
		BuyProduce entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = buyProduceService.get(id);
		}
		if (entity == null){
			entity = new BuyProduce();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ob:buyProduce:view")
	@RequestMapping(value = {"list", ""})
	public String list(BuyProduce buyProduce, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BuyProduce> page = buyProduceService.findPage(new Page<BuyProduce>(request, response), buyProduce); 
		model.addAttribute("page", page);
		return "modules/bus/ob/buyProduceList";
	}

	@RequiresPermissions("bus:ob:buyProduce:view")
	@RequestMapping(value = "form")
	public String form(BuyProduce buyProduce, Model model) {
		model.addAttribute("buyProduce", buyProduce);
		return "modules/bus/ob/buyProduceForm";
	}

	@RequiresPermissions("bus:ob:buyProduce:edit")
	@RequestMapping(value = "save")
	public String save(BuyProduce buyProduce, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, buyProduce)){
			return form(buyProduce, model);
		}
		buyProduceService.save(buyProduce);
		addMessage(redirectAttributes, "保存购买产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ob/buyProduce/?repage";
	}
	
	@RequiresPermissions("bus:ob:buyProduce:edit")
	@RequestMapping(value = "delete")
	public String delete(BuyProduce buyProduce, RedirectAttributes redirectAttributes) {
		buyProduceService.delete(buyProduce);
		addMessage(redirectAttributes, "删除购买产品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ob/buyProduce/?repage";
	}

    @RequiresPermissions("bus:ob:buyProduce:view")
    @RequestMapping(value = "info")
    public String info(BuyProduce buyProduce, Model model) {
        model.addAttribute("buyProduce", buyProduce);
        return "modules/bus/ob/buyProduceInfo";
    }
}