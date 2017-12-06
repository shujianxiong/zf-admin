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
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsPropService;

/**
 * 商品属性表Controller
 * @author 陈适
 * @version 2015-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodsProp")
public class GoodsPropController extends BaseController {

	@Autowired
	private GoodsPropService goodsPropService;
	
	@ModelAttribute
	public GoodsProp get(@RequestParam(required=false) String id) {
		GoodsProp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsPropService.get(id);
		}
		if (entity == null){
			entity = new GoodsProp();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsGoodsProp:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsProp goodsProp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsProp> page = goodsPropService.findPage(new Page<GoodsProp>(request, response), goodsProp); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsPropList";
	}

	@RequiresPermissions("lgt:ps:lgtPsGoodsProp:view")
	@RequestMapping(value = "form")
	public String form(GoodsProp goodsProp, Model model) {
		model.addAttribute("goodsProp", goodsProp);
		return "modules/lgt/ps/goodsPropForm";
	}

	@RequiresPermissions("lgt:ps:lgtPsGoodsProp:edit")
	@RequestMapping(value = "save")
	public String save(GoodsProp goodsProp, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsProp)){
			return form(goodsProp, model);
		}
		goodsPropService.save(goodsProp);
		addMessage(redirectAttributes, "保存商品属性成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsProp/?repage";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsGoodsProp:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsProp goodsProp, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsProp.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品属性信息！");
			return "error/400";
		}
		
		goodsPropService.delete(goodsProp);
		addMessage(redirectAttributes, "删除商品属性成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsProp/?repage";
	}

}