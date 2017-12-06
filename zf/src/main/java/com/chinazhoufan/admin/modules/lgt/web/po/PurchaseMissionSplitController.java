/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.po;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMission;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseMissionService;

/**
 * 采购任务分单 Controller
 * @author 张金俊
 * @version 2016-03-31
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/po/purchaseMissionSplit")
public class PurchaseMissionSplitController extends BaseController {

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
	
	// done
	@RequiresPermissions("lgt:po:purchaseMissionSplit:view")
	@RequestMapping(value = {"list", ""})
	public String list(PurchaseMission purchaseMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 查询已提交的采购任务
		purchaseMission.setStartMissionStatus(new Integer(PurchaseMission.MISSIONSTATUS_SUBMIT));
		Page<PurchaseMission> page = purchaseMissionService.findPage(new Page<PurchaseMission>(request, response), purchaseMission); 
		model.addAttribute("page", page);
		return "modules/lgt/po/purchaseMissionSplitList";
	}
	
	@RequiresPermissions("lgt:po:purchaseMissionSplit:view")
	@RequestMapping(value = "info")
	public String info(PurchaseMission purchaseMission, Model model) {
		// 为采购任务查询订单数据
		PurchaseMission purchaseMissionWithOrder = purchaseMissionService.getWithOrder(purchaseMission.getId());
		purchaseMission.setOrderList(purchaseMissionWithOrder.getOrderList());
		model.addAttribute("purchaseMission", purchaseMission);
		return "modules/lgt/po/purchaseMissionSplitInfo";
	}
	
	// done
	@RequiresPermissions("lgt:po:purchaseMissionSplit:view")
	@RequestMapping(value = "splitForm")
	public String splitForm(PurchaseMission purchaseMission, Model model) {
		model.addAttribute("purchaseMission", purchaseMission);
		model.addAttribute("currentDate", new Date());
		return "modules/lgt/po/purchaseMissionSplitForm";
	}

	@RequiresPermissions("lgt:po:purchaseMissionSplit:edit")
	@RequestMapping(value = "splitSave")
	public String splitSave(PurchaseMission purchaseMission, Model model, RedirectAttributes redirectAttributes) {
		purchaseMissionService.splitSave(purchaseMission);
		addMessage(redirectAttributes, "保存采购任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMissionSplit/?repage";
	}
	
	@RequiresPermissions("lgt:po:purchaseMissionSplit:edit")
	@RequestMapping(value = "submit")
	public String submit(PurchaseMission purchaseMission, Model model, RedirectAttributes redirectAttributes) {
		purchaseMissionService.submit(purchaseMission);
		addMessage(redirectAttributes, "提交采购任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMissionSplit/?repage";
	}
	
	@RequiresPermissions("lgt:po:purchaseMissionSplit:edit")
	@RequestMapping(value = "delete")
	public String delete(PurchaseMission purchaseMission, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(purchaseMission.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的采购任务信息！");
			return "error/400";
		}
		
		purchaseMissionService.delete(purchaseMission);
		addMessage(redirectAttributes, "删除采购任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseMissionSplit/?repage";
	}

	/**
	 * 根据ID获取采购任务（为Ajax提供数据）
	 * @param id 采购任务ID
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "purchaseMissionWithDetailData")
	public PurchaseMission purchaseMissionWithDetailData(@RequestParam(required=true) String id, HttpServletResponse response) {
		return purchaseMissionService.getWithDetail(id);
	}
	
}