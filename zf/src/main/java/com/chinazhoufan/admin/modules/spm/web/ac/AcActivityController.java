/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ac;

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
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.service.ac.AcActivityService;

/**
 * 调研活动表Controller
 * @author liut
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ac/acActivity")
public class AcActivityController extends BaseController {

	@Autowired
	private AcActivityService acActivityService;
	
	@ModelAttribute
	public AcActivity get(@RequestParam(required=false) String id) {
		AcActivity entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = acActivityService.get(id);
		}
		if (entity == null){
			entity = new AcActivity();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ac:acActivity:view")
	@RequestMapping(value = {"list", ""})
	public String list(AcActivity acActivity, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AcActivity> page = acActivityService.findPage(new Page<AcActivity>(request, response), acActivity); 
		model.addAttribute("page", page);
		return "modules/spm/ac/acActivityList";
	}

	@RequiresPermissions("spm:ac:acActivity:view")
	@RequestMapping(value = "form")
	public String form(AcActivity acActivity, Model model) {
		if(StringUtils.isBlank(acActivity.getId())) {
			acActivity.setActiveFlag(AcActivity.TRUE_FLAG);
		}
		model.addAttribute("acActivity", acActivity);
		return "modules/spm/ac/acActivityForm";
	}

	@RequiresPermissions("spm:ac:acActivity:edit")
	@RequestMapping(value = "save")
	public String save(AcActivity acActivity, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, acActivity)){
			return form(acActivity, model);
		}
		acActivityService.save(acActivity);
		addMessage(redirectAttributes, "保存调研活动表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/acActivity/?repage";
	}
	
	@RequiresPermissions("spm:ac:acActivity:edit")
	@RequestMapping(value = "delete")
	public String delete(AcActivity acActivity, RedirectAttributes redirectAttributes) {
		if(acActivity == null || StringUtils.isBlank(acActivity.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调研活动信息！");
			return "error/400";
		}
		acActivityService.delete(acActivity);
		addMessage(redirectAttributes, "删除调研活动表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/acActivity/?repage";
	}

	@RequiresPermissions("spm:ac:acActivity:view")
	@RequestMapping(value = "info")
	public String info(AcActivity acActivity, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(acActivity == null || StringUtils.isBlank(acActivity.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的调研活动信息！");
			return "error/400";
		}
		
		model.addAttribute("acActivity", acActivity);
		return "modules/spm/ac/acActivityInfo";
	}
	
	@RequiresPermissions("spm:ac:acActivity:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(AcActivity acActivity, Model model, RedirectAttributes redirectAttributes){
		if(acActivity == null || StringUtils.isBlank(acActivity.getId())) {
			addMessage(model, "友情提示：未能获取到有效的活动信息！");
			return "error/400";
		}
		
		acActivityService.save(acActivity);
		addMessage(redirectAttributes, "活动状态修改成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/acActivity/?repage";
	}
	
	@RequestMapping(value = "select")
	public String select(AcActivity acActivity, HttpServletRequest request, HttpServletResponse response, Model model) {
		acActivity.setActiveFlag(AcActivity.TRUE_FLAG);
		Page<AcActivity> page = acActivityService.findPage(new Page<AcActivity>(request, response), acActivity); 
		model.addAttribute("page", page);
		return "modules/spm/ac/acActivitySelect";
	}
	
	
}