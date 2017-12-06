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
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProducePropvalue;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProducePropvalueService;

/**
 * 产品组合属性值Controller
 * @author 陈适
 * @version 2015-10-22
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/producePropvalue")
public class ProducePropvalueController extends BaseController {

	@Autowired
	private ProducePropvalueService producePropvalueService;
	
	@ModelAttribute
	public ProducePropvalue get(@RequestParam(required=false) String id) {
		ProducePropvalue entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = producePropvalueService.get(id);
		}
		if (entity == null){
			entity = new ProducePropvalue();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsProducePropvalue:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProducePropvalue producePropvalue, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProducePropvalue> page = producePropvalueService.findPage(new Page<ProducePropvalue>(request, response), producePropvalue); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/producePropvalueList";
	}

	@RequiresPermissions("lgt:ps:lgtPsProducePropvalue:view")
	@RequestMapping(value = "form")
	public String form(ProducePropvalue producePropvalue, Model model) {
		model.addAttribute("producePropvalue", producePropvalue);
		return "modules/lgt/ps/producePropvalueForm";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsProducePropvalue:edit")
	@RequestMapping(value = "save")
	public String save(ProducePropvalue producePropvalue, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, producePropvalue)){
			return form(producePropvalue, model);
		}
		producePropvalueService.save(producePropvalue);
		addMessage(redirectAttributes, "保存产品组合属性值成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/producePropvalue/?repage";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsProducePropvalue:edit")
	@RequestMapping(value = "delete")
	public String delete(ProducePropvalue producePropvalue, RedirectAttributes redirectAttributes) {
		if(producePropvalue == null || StringUtils.isBlank(producePropvalue.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的产品组合属性值信息！");
			return "error/400";
		}
		producePropvalueService.delete(producePropvalue);
		addMessage(redirectAttributes, "删除产品组合属性值成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/producePropvalue/?repage";
	}

}