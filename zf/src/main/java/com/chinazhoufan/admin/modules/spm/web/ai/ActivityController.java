/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ai;

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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.spm.entity.ai.Activity;
import com.chinazhoufan.admin.modules.spm.service.ai.ActivityService;

/**
 * 活动表Controller
 * @author 张金俊
 * @version 2017-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ai/activity")
public class ActivityController extends BaseController {

	@Autowired
	private ActivityService activityService;
	
	@ModelAttribute
	public Activity get(@RequestParam(required=false) String id) {
		Activity entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityService.get(id);
		}
		if (entity == null){
			entity = new Activity();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ai:activity:view")
	@RequestMapping(value = {"list", ""})
	public String list(Activity activity, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Activity> page = activityService.findPage(new Page<Activity>(request, response), activity); 
		model.addAttribute("page", page);
		return "modules/spm/ai/activityList";
	}

	@RequiresPermissions("spm:ai:activity:view")
	@RequestMapping(value = "form")
	public String form(Activity activity, Model model) {
		model.addAttribute("activity", activity);
		return "modules/spm/ai/activityForm";
	}

	@RequiresPermissions("spm:ai:activity:edit")
	@RequestMapping(value = "save")
	public String save(Activity activity, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, activity)){
			return form(activity, model);
		}
		try {
			activityService.save(activity);
		} catch (Exception e){
			addMessage(model, e.getMessage());
			return form(activity, model);
		}
		addMessage(redirectAttributes, "保存活动表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ai/activity/?repage";
	}
	
	@RequiresPermissions("spm:ai:activity:edit")
	@RequestMapping(value = "delete")
	public String delete(Activity activity, RedirectAttributes redirectAttributes) {
		if (Activity.TRUE_FLAG.equals(activity.getActiveFlag())){
			addMessage(redirectAttributes, "操作失败，启用状态不得删除！");
		}else {
			activityService.delete(activity);
			addMessage(redirectAttributes, "删除活动表成功");
		}
		return "redirect:"+Global.getAdminPath()+"/spm/ai/activity/?repage";
	}

    @RequiresPermissions("spm:ai:activity:view")
    @RequestMapping(value = "info")
    public String info(Activity activity, Model model) {
        model.addAttribute("activity", activity);
        return "modules/spm/ai/activityInfo";
    }

	@RequiresPermissions("spm:ai:activity:edit")
	@RequestMapping(value = "updateFlag")
	public String updateFlag(Activity activity, RedirectAttributes redirectAttributes) {
		activity.setActiveFlag(Activity.TRUE_FLAG.equals(activity.getActiveFlag()) ? Activity.FALSE_FLAG : Activity.TRUE_FLAG);
		activityService.save(activity);
		addMessage(redirectAttributes, (Activity.TRUE_FLAG.equals(activity.getActiveFlag()) ? "启用" : "停用")+"活动成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ai/activity/?repage";
	}

}