/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.as;

import java.util.List;

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
import com.chinazhoufan.admin.modules.ser.entity.as.Workorder;
import com.chinazhoufan.admin.modules.ser.entity.as.WorkorderDeal;
import com.chinazhoufan.admin.modules.ser.service.as.WorkorderDealService;
import com.chinazhoufan.admin.modules.ser.service.as.WorkorderService;

/**
 * 售后工单处理Controller
 * @author liut
 * @version 2017-05-18
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/as/workorderDeal")
public class WorkorderDealController extends BaseController {

	@Autowired
	private WorkorderDealService workorderDealService;
	@Autowired
	private WorkorderService workOrderService;
	
	@ModelAttribute
	public WorkorderDeal get(@RequestParam(required=false) String id) {
		WorkorderDeal entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = workorderDealService.get(id);
		}
		if (entity == null){
			entity = new WorkorderDeal();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:as:workorderDeal:view")
	@RequestMapping(value = {"list", ""})
	public String list(WorkorderDeal workorderDeal, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WorkorderDeal> page = workorderDealService.findPage(new Page<WorkorderDeal>(request, response), workorderDeal); 
		model.addAttribute("page", page);
		return "modules/ser/as/workorderDealList";
	}

	@RequiresPermissions("ser:as:workorderDeal:view")
	@RequestMapping(value = "form")
	public String form(WorkorderDeal workorderDeal, Model model) {
		workorderDeal = workorderDealService.findLatestByWorkOrder(workorderDeal);
		Workorder wo = workOrderService.find(workorderDeal.getWorkorder());
		List<WorkorderDeal> list = workorderDealService.findList(workorderDeal);
		
		model.addAttribute("workorderDeal", workorderDeal);
		model.addAttribute("workorder", wo);
		model.addAttribute("list", list);
		return "modules/ser/as/workorderDealForm";
	}

	@RequiresPermissions("ser:as:workorderDeal:edit")
	@RequestMapping(value = "save")
	public String save(WorkorderDeal workorderDeal, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, workorderDeal)){
			return form(workorderDeal, model);
		}*/
		workorderDealService.save(workorderDeal);
		addMessage(redirectAttributes, "保存售后工单处理结果成功!");
		return "redirect:"+Global.getAdminPath()+"/ser/as/workorder/myWaitDealList";
	}
	
	/**
	 * 接收
	 * @param workorderDeal
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("ser:as:workorderDeal:edit")
	@RequestMapping(value = "receive")
	public String receive(WorkorderDeal workorderDeal, Model model, RedirectAttributes redirectAttributes) {
		Workorder wo = workorderDeal.getWorkorder();
		wo.setStatus(Workorder.WORKORDER_STATUS_DEAL);
		workOrderService.updateStatusById(wo);
		addMessage(redirectAttributes, "接收售后工单成功，开始处理中");
		return "redirect:"+Global.getAdminPath()+"/ser/as/workorder/myWaitDealList";
	}
	
	/**
	 * 完成
	 * @param workorderDeal
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("ser:as:workorderDeal:edit")
	@RequestMapping(value = "finish")
	public String finish(WorkorderDeal workorderDeal, Model model, RedirectAttributes redirectAttributes) {
		Workorder wo = workorderDeal.getWorkorder();
		wo.setStatus(Workorder.WORKORDER_STATUS_FINISH);
		workOrderService.updateStatusById(wo);
		addMessage(redirectAttributes, "售后工单处理完成");
		return "redirect:"+Global.getAdminPath()+"/ser/as/workorder/myWaitDealList";
	}
	
	
	
	
	
	
	@RequiresPermissions("ser:as:workorderDeal:edit")
	@RequestMapping(value = "delete")
	public String delete(WorkorderDeal workorderDeal, RedirectAttributes redirectAttributes) {
		workorderDealService.delete(workorderDeal);
		addMessage(redirectAttributes, "删除售后工单处理成功");
		return "redirect:"+Global.getAdminPath()+"/ser/as/workorderDeal/?repage";
	}

    @RequiresPermissions("ser:as:workorderDeal:view")
    @RequestMapping(value = "info")
    public String info(WorkorderDeal workorderDeal, Model model) {
        model.addAttribute("workorderDeal", workorderDeal);
        return "modules/ser/as/workorderDealInfo";
    }
}