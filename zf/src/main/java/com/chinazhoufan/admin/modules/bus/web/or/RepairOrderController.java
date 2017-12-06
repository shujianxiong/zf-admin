/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.or;

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
import com.chinazhoufan.admin.modules.bus.entity.or.RepairOrder;
import com.chinazhoufan.admin.modules.bus.service.or.RepairOrderService;
import com.chinazhoufan.api.common.service.ServiceException;

/**
 * 货品维修单Controller
 * @author 张金俊
 * @version 2016-11-19
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/or/repairOrder")
public class RepairOrderController extends BaseController {

	@Autowired
	private RepairOrderService repairOrderService;
	
	@ModelAttribute
	public RepairOrder get(@RequestParam(required=false) String id) {
		RepairOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = repairOrderService.get(id);
		}
		if (entity == null){
			entity = new RepairOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:or:repairOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(RepairOrder repairOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RepairOrder> page = repairOrderService.findPage(new Page<RepairOrder>(request, response), repairOrder); 
		model.addAttribute("page", page);
		return "modules/bus/or/repairOrderList";
	}

	@RequiresPermissions("bus:or:repairOrder:view")
	@RequestMapping(value = "form")
	public String form(RepairOrder repairOrder, Model model) {
		model.addAttribute("repairOrder", repairOrder);
		return "modules/bus/or/repairOrderForm";
	}

	@RequiresPermissions("bus:or:repairOrder:edit")
	@RequestMapping(value = "save")
	public String save(RepairOrder repairOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, repairOrder)){
			return form(repairOrder, model);
		}
		repairOrderService.save(repairOrder);
		addMessage(redirectAttributes, "保存货品维修单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/or/repairOrder/?repage";
	}
	
	@RequiresPermissions("bus:or:repairOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(RepairOrder repairOrder, RedirectAttributes redirectAttributes) {
		repairOrderService.delete(repairOrder);
		addMessage(redirectAttributes, "删除货品维修单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/or/repairOrder/?repage";
	}

    @RequiresPermissions("bus:or:repairOrder:view")
    @RequestMapping(value = "info")
    public String info(RepairOrder repairOrder, Model model) {
        model.addAttribute("repairOrder", repairOrder);
        return "modules/bus/or/repairOrderInfo";
    }
    
    /**
     * 保存退货货品的维修登记信息，来源是退货单关联的退货货品
     * @param repairOrder
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("bus:or:repairOrder:edit")
	@RequestMapping(value = "saveReturnProductRepairRegister")
	public String saveReturnProductRepairRegister(RepairOrder repairOrder, Model model, RedirectAttributes redirectAttributes) {
		try {
			repairOrderService.saveReturnProductRepairRegister(repairOrder);
			addMessage(redirectAttributes, "保存退货货品维修单成功");
		} catch (ServiceException e) {
			addMessage(redirectAttributes, e.getMessage());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/register";
	}
    
}