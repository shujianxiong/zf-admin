/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mi;

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
import com.chinazhoufan.admin.modules.crm.entity.mi.Address;
import com.chinazhoufan.admin.modules.crm.service.mi.AddressService;

/**
 * 会员物流地址管理Controller
 * @author 刘晓东
 * @version 2015-12-22
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mi/address")
public class AddressController extends BaseController {

	@Autowired
	private AddressService addressService;
	
	@ModelAttribute
	public Address get(@RequestParam(required=false) String id) {
		Address entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = addressService.get(id);
		}
		if (entity == null){
			entity = new Address();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mi:address:view")
	@RequestMapping(value = {"list", ""})
	public String list(Address address, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Address> page = addressService.findPage(new Page<Address>(request, response), address); 
		model.addAttribute("page", page);
		return "modules/crm/mi/addressList";
	}

	@RequiresPermissions("crm:mi:address:view")
	@RequestMapping(value = "form")
	public String form(Address address, Model model) {
		model.addAttribute("address", address);
		return "modules/crm/mi/addressForm";
	}

	@RequiresPermissions("crm:mi:address:edit")
	@RequestMapping(value = "save")
	public String save(Address address, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, address)){
			return form(address, model);
		}
		addressService.save(address);
		addMessage(redirectAttributes, "保存物流地址管理成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/address/?repage";
	}
	
	@RequiresPermissions("crm:mi:address:edit")
	@RequestMapping(value = "delete")
	public String delete(Address address, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(address.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的物流地址信息！");
			return "error/400";
		}
		addressService.delete(address);
		addMessage(redirectAttributes, "删除物流地址管理成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/address/?repage";
	}

	@RequiresPermissions("crm:mi:address:view")
	@RequestMapping(value = "info")
	public String info(Address address, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(address.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的物流地址信息！");
			return "error/400";
		}
		model.addAttribute("address", address);
		return "modules/crm/mi/addressInfo";
	}
}