/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.bb;

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
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookItem;
import com.chinazhoufan.admin.modules.crm.service.bb.BankbookItemService;

/**
 * 会员资金账户表管理Controller
 * @author 陈适
 * @version 2015-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/bb/bankbookItem")
public class BankbookItemController extends BaseController {

	@Autowired
	private BankbookItemService bankbookItemService;
	
	@ModelAttribute
	public BankbookItem get(@RequestParam(required=false) String id) {
		BankbookItem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bankbookItemService.get(id);
		}
		if (entity == null){
			entity = new BankbookItem();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:bb:bankbookItem:view")
	@RequestMapping(value = {"list", ""})
	public String list(BankbookItem bankbookItem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BankbookItem> page = bankbookItemService.findPage(new Page<BankbookItem>(request, response), bankbookItem); 
		model.addAttribute("page", page);
		return "modules/crm/bb/bankbookItemList";
	}

	@RequiresPermissions("crm:bb:bankbookItem:view")
	@RequestMapping(value = "form")
	public String form(BankbookItem bankbookItem, Model model) {
		model.addAttribute("bankbookItem", bankbookItem);
		return "modules/crm/bb/bankbookItemForm";
	}

	@RequiresPermissions("crm:bb:bankbookItem:edit")
	@RequestMapping(value = "save")
	public String save(BankbookItem bankbookItem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bankbookItem)){
			return form(bankbookItem, model);
		}
		bankbookItemService.save(bankbookItem);
		addMessage(redirectAttributes, "保存会员资金账户流水成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookItem/?repage";
	}
	
	@RequiresPermissions("crm:bb:bankbookItem:edit")
	@RequestMapping(value = "delete")
	public String delete(BankbookItem bankbookItem, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(bankbookItem.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员资金账号流水记录！");
			return "error/400";
		}
		bankbookItemService.delete(bankbookItem);
		addMessage(redirectAttributes, "删除会员资金账户流水成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookItem/?repage";
	}

}