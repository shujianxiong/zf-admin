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
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearch;
import com.chinazhoufan.admin.modules.spm.service.ac.AcActivityService;
import com.chinazhoufan.admin.modules.spm.service.ac.ActivityResearchService;

/**
 * 调研活动表Controller
 * @author liut
 * @version 2016-05-25
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ac/activityResearch")
public class ActivityResearchController extends BaseController {

	@Autowired
	private ActivityResearchService activityResearchService;
	@Autowired
	private AcActivityService acActivityService;
	
	@ModelAttribute
	public ActivityResearch get(@RequestParam(required=false) String id) {
		ActivityResearch entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityResearchService.get(id);
		}
		if (entity == null){
			entity = new ActivityResearch();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ac:activityResearch:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActivityResearch activityResearch, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActivityResearch> page = activityResearchService.findPage(new Page<ActivityResearch>(request, response), activityResearch); 
		model.addAttribute("page", page);
		return "modules/spm/ac/activityResearchList";
	}

	@RequiresPermissions("spm:ac:activityResearch:view")
	@RequestMapping(value = "form")
	public String form(ActivityResearch activityResearch, Model model) {
		if(StringUtils.isBlank(activityResearch.getId())) {
			AcActivity ac = new AcActivity(); 
			ac.setActiveFlag(AcActivity.TRUE_FLAG);
			activityResearch.setActivity(ac);
		}
		model.addAttribute("activityResearch", activityResearch);
		return "modules/spm/ac/activityResearchForm";
	}

	@RequiresPermissions("spm:ac:activityResearch:edit")
	@RequestMapping(value = "save")
	public String save(ActivityResearch activityResearch, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, activityResearch)){
//			return form(activityResearch, model);
//		}
		activityResearchService.save(activityResearch);
		addMessage(redirectAttributes, "保存调研活动表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/activityResearch/?repage";
	}
	
	@RequiresPermissions("spm:ac:activityResearch:edit")
	@RequestMapping(value = "delete")
	public String delete(ActivityResearch activityResearch, RedirectAttributes redirectAttributes) {
		if(activityResearch == null || StringUtils.isBlank(activityResearch.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调研活动信息！");
			return "error/400";
		}
		
		activityResearchService.delete(activityResearch);
		addMessage(redirectAttributes, "删除调研活动表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/activityResearch/?repage";
	}

	@RequiresPermissions("spm:ac:activityResearch:view")
	@RequestMapping(value = "info")
	public String info(ActivityResearch activityResearch, Model model) {
		if(activityResearch == null || StringUtils.isBlank(activityResearch.getId())) {
			addMessage(model, "友情提示：未能获取到要删除的调研活动信息！");
			return "error/400";
		}
		
		model.addAttribute("activityResearch", activityResearch);
		return "modules/spm/ac/activityResearchInfo";
	}
	
	@RequiresPermissions("spm:ac:activityResearch:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(ActivityResearch activityResearch, Model model, RedirectAttributes redirectAttributes){
		if(activityResearch == null || StringUtils.isBlank(activityResearch.getId())) {
			addMessage(model, "友情提示：未能获取到有效的调研活动信息！");
			return "error/400";
		}
		
		acActivityService.save(activityResearch.getActivity());
		addMessage(redirectAttributes, "活动状态修改成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/activityResearch/?repage";
	}
	
}