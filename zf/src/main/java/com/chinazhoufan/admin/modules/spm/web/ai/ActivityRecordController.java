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
import com.chinazhoufan.admin.modules.spm.entity.ai.ActivityRecord;
import com.chinazhoufan.admin.modules.spm.service.ai.ActivityRecordService;

/**
 * 活动参与记录Controller
 * @author 张金俊
 * @version 2017-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ai/activityRecord")
public class ActivityRecordController extends BaseController {

	@Autowired
	private ActivityRecordService activityRecordService;
	
	@ModelAttribute
	public ActivityRecord get(@RequestParam(required=false) String id) {
		ActivityRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityRecordService.get(id);
		}
		if (entity == null){
			entity = new ActivityRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ai:activityRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActivityRecord activityRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActivityRecord> page = activityRecordService.findPage(new Page<ActivityRecord>(request, response), activityRecord); 
		model.addAttribute("page", page);
		return "modules/spm/ai/activityRecordList";
	}

	@RequiresPermissions("spm:ai:activityRecord:view")
	@RequestMapping(value = "form")
	public String form(ActivityRecord activityRecord, Model model) {
		model.addAttribute("activityRecord", activityRecord);
		return "modules/spm/ai/activityRecordForm";
	}

	@RequiresPermissions("spm:ai:activityRecord:edit")
	@RequestMapping(value = "save")
	public String save(ActivityRecord activityRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, activityRecord)){
			return form(activityRecord, model);
		}
		activityRecordService.save(activityRecord);
		addMessage(redirectAttributes, "保存活动参与记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ai/activityRecord/?repage";
	}
	
	@RequiresPermissions("spm:ai:activityRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(ActivityRecord activityRecord, RedirectAttributes redirectAttributes) {
		activityRecordService.delete(activityRecord);
		addMessage(redirectAttributes, "删除活动参与记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ai/activityRecord/?repage";
	}

    @RequiresPermissions("spm:ai:activityRecord:view")
    @RequestMapping(value = "info")
    public String info(ActivityRecord activityRecord, Model model) {
        model.addAttribute("activityRecord", activityRecord);
        return "modules/spm/ai/activityRecordInfo";
    }
}