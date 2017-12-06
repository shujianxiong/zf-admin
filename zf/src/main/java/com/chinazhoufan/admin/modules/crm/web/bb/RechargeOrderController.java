/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.entity.bb.RechargeOrder;
import com.chinazhoufan.admin.modules.crm.service.bb.RechargeOrderService;

/**
 * 微信充值单Controller
 * @author 张金俊
 * @version 2016-12-19
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/bb/rechargeOrder")
public class RechargeOrderController extends BaseController {

	@Autowired
	private RechargeOrderService rechargeOrderService;
	
	@ModelAttribute
	public RechargeOrder get(@RequestParam(required=false) String id) {
		RechargeOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rechargeOrderService.get(id);
		}
		if (entity == null){
			entity = new RechargeOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:bb:rechargeOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(RechargeOrder rechargeOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RechargeOrder> page = rechargeOrderService.findPage(new Page<RechargeOrder>(request, response), rechargeOrder); 
		model.addAttribute("page", page);
		return "modules/crm/bb/rechargeOrderList";
	}

	@RequiresPermissions("crm:bb:rechargeOrder:view")
	@RequestMapping(value = "form")
	public String form(RechargeOrder rechargeOrder, Model model) {
		model.addAttribute("rechargeOrder", rechargeOrder);
		return "modules/crm/bb/rechargeOrderForm";
	}

	@RequiresPermissions("crm:bb:rechargeOrder:edit")
	@RequestMapping(value = "save")
	public String save(RechargeOrder rechargeOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, rechargeOrder)){
			return form(rechargeOrder, model);
		}
		rechargeOrderService.save(rechargeOrder);
		addMessage(redirectAttributes, "保存微信充值单成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/rechargeOrder/?repage";
	}
	
	@RequiresPermissions("crm:bb:rechargeOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(RechargeOrder rechargeOrder, RedirectAttributes redirectAttributes) {
		rechargeOrderService.delete(rechargeOrder);
		addMessage(redirectAttributes, "删除微信充值单成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/rechargeOrder/?repage";
	}

    @RequiresPermissions("crm:bb:rechargeOrder:view")
    @RequestMapping(value = "info")
    public String info(RechargeOrder rechargeOrder, Model model) {
        model.addAttribute("rechargeOrder", rechargeOrder);
        return "modules/crm/bb/rechargeOrderInfo";
    }
}