/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.bs;

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
import com.chinazhoufan.admin.modules.lgt.entity.bs.Shop;
import com.chinazhoufan.admin.modules.lgt.service.bs.ShopService;

/**
 * 体验店（自提点）Controller
 * @author 张金俊
 * @version 2016-01-21
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/bs/shop")
public class ShopController extends BaseController {

	@Autowired
	private ShopService shopService;
	
	@ModelAttribute
	public Shop get(@RequestParam(required=false) String id) {
		Shop entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = shopService.get(id);
		}
		if (entity == null){
			entity = new Shop();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:bs:shop:view")
	@RequestMapping(value = {"list", ""})
	public String list(Shop shop, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Shop> page = shopService.findPage(new Page<Shop>(request, response), shop); 
		model.addAttribute("page", page);
		return "modules/lgt/bs/shopList";
	}

	@RequiresPermissions("lgt:bs:shop:view")
	@RequestMapping(value = "form")
	public String form(Shop shop, Model model) {
		if(StringUtils.isBlank(shop.getId())) {
			shop.setSelfPickFlag(Shop.SELF_PICK_YES);
		}
		model.addAttribute("shop", shop);
		return "modules/lgt/bs/shopForm";
	}

	@RequiresPermissions("lgt:bs:shop:edit")
	@RequestMapping(value = "save")
	public String save(Shop shop, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, shop)){
			return form(shop, model);
		}
		shopService.save(shop);
		addMessage(redirectAttributes, "保存体验店（自提点）成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/shop/?repage";
	}
	
	@RequiresPermissions("lgt:bs:shop:edit")
	@RequestMapping(value = "delete")
	public String delete(Shop shop, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(shop.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的体验店信息！");
			return "error/400";
		}
		shopService.delete(shop);
		addMessage(redirectAttributes, "删除体验店（自提点）成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/shop/?repage";
	}
	
	@RequiresPermissions("lgt:bs:shop:view")
	@RequestMapping(value = "info")
	public String info(Shop shop, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(shop.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的体验店信息！");
			return "error/400";
		}
		model.addAttribute("shop", shop);
		return "modules/lgt/bs/shopInfo";
	}

}