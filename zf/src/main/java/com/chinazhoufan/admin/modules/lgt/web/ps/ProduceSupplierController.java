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
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceSupplier;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceSupplierService;

/**
 * 产品供货Controller
 * @author 陈适
 * @version 2016-03-29
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/produceSupplier")
public class ProduceSupplierController extends BaseController {

	@Autowired
	private ProduceSupplierService produceSupplierService;
	
	@ModelAttribute
	public ProduceSupplier get(@RequestParam(required=false) String id) {
		ProduceSupplier entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = produceSupplierService.get(id);
		}
		if (entity == null){
			entity = new ProduceSupplier();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:produceSupplier:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProduceSupplier produceSupplier, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProduceSupplier> page = produceSupplierService.findPage(new Page<ProduceSupplier>(request, response), produceSupplier); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/produceSupplierList";
	}

	@RequiresPermissions("lgt:ps:produceSupplier:view")
	@RequestMapping(value = "form")
	public String form(ProduceSupplier produceSupplier, Model model) {
		model.addAttribute("produceSupplier", produceSupplier);
		return "modules/lgt/ps/produceSupplierForm";
	}

	@RequiresPermissions("lgt:ps:produceSupplier:edit")
	@RequestMapping(value = "save")
	public String save(ProduceSupplier produceSupplier, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, produceSupplier)){
			return form(produceSupplier, model);
		}
		produceSupplierService.save(produceSupplier);
		addMessage(redirectAttributes, "保存产品供货成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produceSupplier/?repage";
	}
	
	@RequiresPermissions("lgt:ps:produceSupplier:edit")
	@RequestMapping(value = "delete")
	public String delete(ProduceSupplier produceSupplier, RedirectAttributes redirectAttributes) {
		if(produceSupplier == null || StringUtils.isBlank(produceSupplier.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的产品供货信息！");
			return "error/400";
		}
		
		produceSupplierService.delete(produceSupplier);
		addMessage(redirectAttributes, "删除产品供货成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/produceSupplier/?repage";
	}
}