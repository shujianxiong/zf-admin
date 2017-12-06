/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.ei;

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
import com.chinazhoufan.admin.modules.hrm.entity.ei.Resign;
import com.chinazhoufan.admin.modules.hrm.service.ei.ResignService;

/**
 * 员工离职记录Controller
 * @author 陈适
 * @version 2015-12-09
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/ei/resign")
public class ResignController extends BaseController {

	@Autowired
	private ResignService resignService;
	
	@ModelAttribute
	public Resign get(@RequestParam(required=false) String id) {
		Resign entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = resignService.get(id);
		}
		if (entity == null){
			entity = new Resign();
		}
		return entity;
	}
	
	@RequiresPermissions("hrm:ei:resign:view")
	@RequestMapping(value = {"list", ""})
	public String list(Resign resign, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Resign> page = resignService.findPage(new Page<Resign>(request, response), resign); 
		model.addAttribute("page", page);
		return "modules/hrm/ei/resignList";
	}

	@RequiresPermissions("hrm:ei:resign:view")
	@RequestMapping(value = "form")
	public String form(Resign resign, Model model) {
		if(StringUtils.isBlank(resign.getId())) {
			resign.setWorkRelayStatus(Resign.TRUE_FLAG);
			resign.setSuppliesRelayStatus(Resign.TRUE_FLAG);
			resign.setSalaryPayStatus(Resign.TRUE_FLAG);
		}
		model.addAttribute("resign", resign);
		return "modules/hrm/ei/resignForm";
	}

	@RequiresPermissions("hrm:ei:resign:edit")
	@RequestMapping(value = "save")
	public String save(Resign resign, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, resign)){
			return form(resign, model);
		}
		resignService.save(resign);
		addMessage(redirectAttributes, "保存员工离职记录成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/ei/resign/?repage";
	}
	
	@RequiresPermissions("hrm:ei:resign:edit")
	@RequestMapping(value = "delete")
	public String delete(Resign resign, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(resign.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的员工离职记录！");
			return "error/400";
		}
		resignService.delete(resign);
		addMessage(redirectAttributes, "删除员工离职记录成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/ei/resign/?repage";
	}

	@RequiresPermissions("hrm:ei:resign:view")
	@RequestMapping(value = "info")
	public String info(Resign resign, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(resign.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的员工离职记录！");
			return "error/400";
		}
		model.addAttribute("resign", resign);
		return "modules/hrm/ei/resignInfo";
	}
	
}