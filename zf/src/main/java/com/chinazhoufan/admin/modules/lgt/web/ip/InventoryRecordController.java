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
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryRecord;
import com.chinazhoufan.admin.modules.lgt.service.ip.InventoryRecordService;

/**
 * 盘点记录Controller
 * @author 张金俊
 * @version 2016-03-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ip/inventoryRecord")
public class InventoryRecordController extends BaseController {

	@Autowired
	private InventoryRecordService inventoryRecordService;
	
	@ModelAttribute
	public InventoryRecord get(@RequestParam(required=false) String id) {
		InventoryRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = inventoryRecordService.get(id);
		}
		if (entity == null){
			entity = new InventoryRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ip:inventoryRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(InventoryRecord inventoryRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InventoryRecord> page = inventoryRecordService.findPage(new Page<InventoryRecord>(request, response), inventoryRecord); 
		model.addAttribute("page", page);
		return "modules/lgt/ip/inventoryRecordList";
	}

	@RequiresPermissions("lgt:ip:inventoryRecord:view")
	@RequestMapping(value = "form")
	public String form(InventoryRecord inventoryRecord, Model model) {
		model.addAttribute("inventoryRecord", inventoryRecord);
		return "modules/lgt/ip/inventoryRecordForm";
	}

	@RequiresPermissions("lgt:ip:inventoryRecord:edit")
	@RequestMapping(value = "save")
	public String save(InventoryRecord inventoryRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, inventoryRecord)){
			return form(inventoryRecord, model);
		}
		inventoryRecordService.save(inventoryRecord);
		addMessage(redirectAttributes, "保存盘点记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ip/inventoryRecord/?repage";
	}
	
	@RequiresPermissions("lgt:ip:inventoryRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(InventoryRecord inventoryRecord, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(inventoryRecord.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的盘点记录信息！");
			return "error/400";
		}
		
		inventoryRecordService.delete(inventoryRecord);
		addMessage(redirectAttributes, "删除盘点记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ip/inventoryRecord/?repage";
	}

}