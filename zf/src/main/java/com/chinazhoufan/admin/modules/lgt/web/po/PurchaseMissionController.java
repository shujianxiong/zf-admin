/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.po;

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
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMission;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseMissionService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 采购任务创建 Controller
 * @author 张金俊
 * @version 2016-03-31
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/po/purchaseMission")
public class PurchaseMissionController extends BaseController {

	@Autowired
	private PurchaseMissionService purchaseMissionService;
	
	@ModelAttribute
	public PurchaseMission get(@RequestParam(required=false) String id) {
		PurchaseMission entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = purchaseMissionService.getWithDetail(id);
		}
		if (entity == null){
			entity = new PurchaseMission();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:po:purchaseMission:view")
	@RequestMapping(value = {"list", ""})
	public String list(PurchaseMission purchaseMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PurchaseMission> page = purchaseMissionService.findPage(new Page<PurchaseMission>(request, response), purchaseMission); 
		model.addAttribute("page", page);
		model.addAttribute("user", UserUtils.getUser());
		return "modules/lgt/po/purchaseMissionList";
	}
	
	@RequiresPermissions("lgt:po:purchaseMission:view")
	@RequestMapping(value = "info")
	public String info(PurchaseMission purchaseMission, Model model) {
		model.addAttribute("purchaseMission", purchaseMission);
		return "modules/lgt/po/purchaseMissionInfo";
	}
	
	@RequiresPermissions("lgt:po:purchaseMission:view")
	@RequestMapping(value = "form")
	public String form(PurchaseMission purchaseMission, Model model) {
		model.addAttribute("purchaseMission", purchaseMission);
		return "modules/lgt/po/purchaseMissionForm";
	}

	/**保存采购任务*/
	@RequiresPermissions("lgt:po:purchaseMission:edit")
	@RequestMapping(value = "save")
	public String save(PurchaseMission purchaseMission, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, purchaseMission)){
			return form(purchaseMission, model);
		}
		purchaseMissionService.save(purchaseMission);
		addMessage(redirectAttributes, "保存采购任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMission/?repage";
	}
	
	/**提交采购任务*/
	@RequiresPermissions("lgt:po:purchaseMission:edit")
	@RequestMapping(value = "submit")
	public String submit(PurchaseMission purchaseMission, Model model, RedirectAttributes redirectAttributes) {
		purchaseMissionService.submit(purchaseMission);
		addMessage(redirectAttributes, "提交采购任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMission/?repage";
	}
	
	/**审批表单**/
	@RequiresPermissions("lgt:po:purchaseMission:approve")
	@RequestMapping(value = "checkForm")
	public String checkForm(PurchaseMission purchaseMission, Model model) {
		model.addAttribute("purchaseMission", purchaseMission);
		return "modules/lgt/po/purchaseMissionCheckForm";
	}
	
	/**需要拥有审批任务权限的人，才能保存审批结果**/
	@RequiresPermissions("lgt:po:purchaseMission:approve")
	@RequestMapping(value = "saveCheckResult")
	public String saveCheckResult(PurchaseMission purchaseMission, RedirectAttributes redirectAttributes) {
		purchaseMissionService.saveCheckResult(purchaseMission);
		addMessage(redirectAttributes, "保存采购任务审批结果成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMission/?repage";
	}
	
	@RequiresPermissions("lgt:po:purchaseMission:edit")
	@RequestMapping(value = "delete")
	public String delete(PurchaseMission purchaseMission, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(purchaseMission.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的采购任务信息！");
			return "error/400";
		}
		
		purchaseMissionService.delete(purchaseMission);
		addMessage(redirectAttributes, "删除采购任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMission/?repage";
	}

	@RequiresPermissions("lgt:po:purchaseMission:edit")
	@RequestMapping(value = "updateRemarks")
	public String updateRemarks(PurchaseMission purchaseMission, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(purchaseMission.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要修改的采购任务信息！");
			return "error/400";
		}

		purchaseMissionService.updateRemarks(purchaseMission);
		addMessage(redirectAttributes, "修改备注成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMission/?repage";
	}

}