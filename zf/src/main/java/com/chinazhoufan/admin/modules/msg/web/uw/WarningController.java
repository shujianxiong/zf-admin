/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.web.uw;

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
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 员工报警中心Controller
 * @author 刘晓东
 * @version 2015-12-10
 */
@Controller
@RequestMapping(value = "${adminPath}/msg/uw/warning")
public class WarningController extends BaseController {

	@Autowired
	private WarningService warningService;
	
	@ModelAttribute
	public Warning get(@RequestParam(required=false) String id) {
		Warning entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = warningService.get(id);
		}
		if (entity == null){
			entity = new Warning();
		}
		return entity;
	}
	
	@RequiresPermissions("msg:uw:warning:view")
	@RequestMapping(value = {"list", ""})
	public String list(Warning warning, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Warning> page = warningService.findPage(new Page<Warning>(request, response), warning); 
		model.addAttribute("page", page);
		return "modules/msg/uw/warningList";
	}

	@RequiresPermissions("msg:uw:warning:view")
	@RequestMapping(value = "form")
	public String form(Warning warning, Model model) {
		warning.setDealEndTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
		warning.setDealUser(UserUtils.getUser());
		model.addAttribute("warning", warning);
		return "modules/msg/uw/warningForm";
	}

//	@RequiresPermissions("msg:uw:warning:view")
//	@RequestMapping(value = "info")
//	public String info(Warning warning, Model model) {
//		if (!StringUtils.isBlank(warning.getId())) {
//			if (!warning.getStatus().equals(Warning.STATUS_VIEWED)) {
//				Warning warningNew = warningService.view(warning);
//				model.addAttribute("warning", warningNew);
//				return "modules/msg/uw/warningForm";
//			}
//		}
//		model.addAttribute("warning", warning);
//		return "modules/msg/uw/warningInfo";
//	}
	
	@RequiresPermissions("msg:uw:warning:edit")
	@RequestMapping(value = "save")
	public String save(Warning warning, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, warning)){
			return form(warning, model);
		}
		warningService.save(warning);
		addMessage(redirectAttributes, "保存员工报警中心成功");
		return "redirect:"+Global.getAdminPath()+"/msg/uw/warning/?repage";
	}
	
	@RequiresPermissions("msg:uw:warning:edit")
	@RequestMapping(value = "delete")
	public String delete(Warning warning, RedirectAttributes redirectAttributes) {
		if(warning == null || StringUtils.isBlank(warning.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的员工报警中心记录！");
			return "error/400";
		}
		warningService.delete(warning);
		addMessage(redirectAttributes, "删除员工报警中心成功");
		return "redirect:"+Global.getAdminPath()+"/msg/uw/warning/?repage";
	}

}