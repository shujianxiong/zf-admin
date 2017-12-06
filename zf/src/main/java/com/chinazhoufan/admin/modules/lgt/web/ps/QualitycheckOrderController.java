/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckOrder;
import com.chinazhoufan.admin.modules.lgt.service.ps.QualitycheckOrderService;

/**
 * 货品质检单管理Controller
 * @author 刘晓东
 * @version 2015-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/qualitycheckOrder")
public class QualitycheckOrderController extends BaseController {

	@Autowired
	private QualitycheckOrderService qualitycheckOrderService;
	
	@ModelAttribute
	public QualitycheckOrder get(@RequestParam(required=false) String id) {
		QualitycheckOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = qualitycheckOrderService.get(id);
		}
		if (entity == null){
			entity = new QualitycheckOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsQualitycheckOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(QualitycheckOrder qualitycheckOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QualitycheckOrder> page = qualitycheckOrderService.findPage(new Page<QualitycheckOrder>(request, response), qualitycheckOrder); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/qualitycheckOrderList";
	}

	@RequiresPermissions("lgt:ps:lgtPsQualitycheckOrder:view")
	@RequestMapping(value = "form")
	public String form(QualitycheckOrder qualitycheckOrder, Model model) {
		model.addAttribute("lgtPsQualitycheckOrder", qualitycheckOrder);
		return "modules/lgt/ps/qualitycheckOrderForm";
	}

	@RequiresPermissions("lgt:ps:lgtPsQualitycheckOrder:edit")
	@RequestMapping(value = "save")
	public String save(QualitycheckOrder qualitycheckOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, qualitycheckOrder)){
			return form(qualitycheckOrder, model);
		}
		qualitycheckOrderService.save(qualitycheckOrder);
		addMessage(redirectAttributes, "保存货品质检单成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/qualitycheckOrder/?repage";
	}
	
	@RequestMapping(value = "info")
	public String Info(QualitycheckOrder qualitycheckOrder,Model model){
		model.addAttribute("qualitycheckOrder",qualitycheckOrder);
		return "modules/lgt/ps/qualitycheckOrderInfo";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsQualitycheckOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(QualitycheckOrder qualitycheckOrder, RedirectAttributes redirectAttributes) {
		if(qualitycheckOrder == null || StringUtils.isBlank(qualitycheckOrder.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的货品质检单信息！");
			return "error/400";
		}
		
		qualitycheckOrderService.delete(qualitycheckOrder);
		addMessage(redirectAttributes, "删除货品质检单成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/qualitycheckOrder/?repage";
	}

	@RequiresPermissions("lgt:ps:lgtPsQualitycheckOrder:edit")
	@RequestMapping(value = "qualityStart")
	public String qualityStart(QualitycheckOrder qualitycheckOrder, RedirectAttributes redirectAttributes) {
		qualitycheckOrderService.qualityStart(qualitycheckOrder);
		addMessage(redirectAttributes, "该调拨单已开始质检");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/qualitycheckOrder/?repage";
	}
}