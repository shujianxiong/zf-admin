/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ip;

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
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryMission;
import com.chinazhoufan.admin.modules.lgt.service.ip.InventoryMissionService;

/**
 * 盘点任务Controller
 * @author 张金俊
 * @version 2016-03-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ip/inventoryMission")
public class InventoryMissionController extends BaseController {

	@Autowired
	private InventoryMissionService inventoryMissionService;
	
	@ModelAttribute
	public InventoryMission get(@RequestParam(required=false) String id) {
		InventoryMission entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = inventoryMissionService.getInfo(id);
		}
		if (entity == null){
			entity = new InventoryMission();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ip:inventoryMission:view")
	@RequestMapping(value = {"list", ""})
	public String list(InventoryMission inventoryMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InventoryMission> page = inventoryMissionService.findPage(new Page<InventoryMission>(request, response), inventoryMission); 
		model.addAttribute("page", page);
		return "modules/lgt/ip/inventoryMissionList";
	}
	
	@RequiresPermissions("lgt:ip:inventoryMission:view")
	@RequestMapping(value = "info")
	public String info(InventoryMission inventoryMission, Model model) {
		model.addAttribute("inventoryMission", inventoryMission);
		return "modules/lgt/ip/inventoryMissionInfo";
	}

	@RequiresPermissions("lgt:ip:inventoryMission:view")
	@RequestMapping(value = "form")
	public String form(InventoryMission inventoryMission, String style, Model model) {
		model.addAttribute("inventoryMission", inventoryMission);
		if("1".equals(inventoryMission.getStyle())){
			return "modules/lgt/ip/inventoryMissionProduceForm";
		}else {
			return "modules/lgt/ip/inventoryMissionPositionForm";
		}
	}

	@RequiresPermissions("lgt:ip:inventoryMission:edit")
	@RequestMapping(value = "save")
	public String save(String submitType, InventoryMission inventoryMission, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, inventoryMission)){
//			return form(inventoryMission, model);
//		}
		inventoryMissionService.save(submitType, inventoryMission);
		addMessage(redirectAttributes, "保存盘点任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ip/inventoryMission/?repage";
	}
	
	@RequiresPermissions("lgt:ip:inventoryMission:edit")
	@RequestMapping(value = "delete")
	public String delete(InventoryMission inventoryMission, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(inventoryMission.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的盘点任务信息！");
			return "error/400";
		}
		inventoryMissionService.delete(inventoryMission);
		addMessage(redirectAttributes, "删除盘点任务成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ip/inventoryMission/?repage";
	}

}