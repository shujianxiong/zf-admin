/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.si;

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
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierContacts;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierContactsService;

/**
 * 供应商通讯录Controller
 * @author 张金俊
 * @version 2015-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/si/supplierContacts")
public class SupplierContactsController extends BaseController {

	@Autowired
	private SupplierContactsService supplierContactsService;
	
	@ModelAttribute
	public SupplierContacts get(@RequestParam(required=false) String id) {
		SupplierContacts entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = supplierContactsService.get(id);
		}
		if (entity == null){
			entity = new SupplierContacts();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:si:supplierContacts:view")
	@RequestMapping(value = {"list", ""})
	public String list(SupplierContacts supplierContacts, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SupplierContacts> page = null;
		if(supplierContacts != null && supplierContacts.getSupplier() != null && supplierContacts.getSupplier().getSysUser()!= null && StringUtils.isNotBlank(supplierContacts.getSupplier().getSysUser().getId())) {
			page = supplierContactsService.findPageBySupplier(new Page<SupplierContacts>(request, response), supplierContacts);
		} else {
			page = supplierContactsService.findPage(new Page<SupplierContacts>(request, response), supplierContacts); 
		}
		model.addAttribute("page", page);
		return "modules/lgt/si/supplierContactsList";
	}

	@RequiresPermissions("lgt:si:supplierContacts:view")
	@RequestMapping(value = "form")
	public String form(SupplierContacts supplierContacts, Model model) {
		model.addAttribute("supplierContacts", supplierContacts);
		return "modules/lgt/si/supplierContactsForm";
	}

	@RequiresPermissions("lgt:si:supplierContacts:edit")
	@RequestMapping(value = "save")
	public String save(SupplierContacts supplierContacts, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, supplierContacts)){
			return form(supplierContacts, model);
		}
		supplierContactsService.save(supplierContacts);
		addMessage(redirectAttributes, "保存供应商通讯录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplierContacts/?repage";
	}
	
	@RequiresPermissions("lgt:si:supplierContacts:edit")
	@RequestMapping(value = "delete")
	public String delete(SupplierContacts supplierContacts, RedirectAttributes redirectAttributes) {
		if(supplierContacts == null || StringUtils.isBlank(supplierContacts.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的供应商通讯录信息！");
			return "error/400";
		}
		
		supplierContactsService.delete(supplierContacts);
		addMessage(redirectAttributes, "删除供应商通讯录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplierContacts/?repage";
	}

	@RequiresPermissions("lgt:si:supplierContacts:edit")
	@RequestMapping(value = "info")
	public String info(SupplierContacts supplierContacts, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(supplierContacts == null || StringUtils.isBlank(supplierContacts.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的供应商通讯录信息！");
			return "error/400";
		}
		model.addAttribute("supplierContacts", supplierContacts);
		return "modules/lgt/si/supplierContactsInfo";
	}
}