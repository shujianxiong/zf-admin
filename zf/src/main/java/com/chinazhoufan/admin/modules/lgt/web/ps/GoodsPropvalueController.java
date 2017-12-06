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
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsPropvalueService;

/**
 * 商品属性值表管理Controller
 * @author 陈适
 * @version 2015-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodsPropvalue")
public class GoodsPropvalueController extends BaseController {

	@Autowired
	private GoodsPropvalueService goodsPropvalueService;
	
	@ModelAttribute
	public GoodsPropvalue get(@RequestParam(required=false) String id) {
		GoodsPropvalue entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsPropvalueService.get(id);
		}
		if (entity == null){
			entity = new GoodsPropvalue();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsGoodsPropvalue:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsPropvalue goodsPropvalue, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsPropvalue> page = goodsPropvalueService.findPage(new Page<GoodsPropvalue>(request, response), goodsPropvalue); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsPropvalueList";
	}

	@RequiresPermissions("lgt:ps:lgtPsGoodsPropvalue:view")
	@RequestMapping(value = "form")
	public String form(GoodsPropvalue goodsPropvalue, Model model) {
		model.addAttribute("goodsPropvalue", goodsPropvalue);
		return "modules/lgt/ps/goodsPropvalueForm";
	}

	@RequiresPermissions("lgt:ps:lgtPsGoodsPropvalue:edit")
	@RequestMapping(value = "save")
	public String save(GoodsPropvalue goodsPropvalue, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsPropvalue)){
			return form(goodsPropvalue, model);
		}
		goodsPropvalueService.save(goodsPropvalue);
		addMessage(redirectAttributes, "保存商品属性值成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsPropvalue/?repage";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsGoodsPropvalue:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsPropvalue goodsPropvalue, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsPropvalue.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品属性值信息！");
			return "error/400";
		}
		
		goodsPropvalueService.delete(goodsPropvalue);
		addMessage(redirectAttributes, "删除商品属性值成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsPropvalue/?repage";
	}

}