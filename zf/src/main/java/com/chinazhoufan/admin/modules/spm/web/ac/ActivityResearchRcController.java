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
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearchRc;
import com.chinazhoufan.admin.modules.spm.service.ac.ActivityResearchRcService;

/**
 * 调研活动参与记录Controller
 * @author 刘晓东
 * @version 2016-05-27
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ac/activityResearchRc")
public class ActivityResearchRcController extends BaseController {

	@Autowired
	private ActivityResearchRcService activityResearchRcService;
	
	@ModelAttribute
	public ActivityResearchRc get(@RequestParam(required=false) String id) {
		ActivityResearchRc entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityResearchRcService.get(id);
		}
		if (entity == null){
			entity = new ActivityResearchRc();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ac:activityResearchRc:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActivityResearchRc activityResearchRc, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActivityResearchRc> page = activityResearchRcService.findPage(new Page<ActivityResearchRc>(request, response), activityResearchRc); 
		model.addAttribute("page", page);
		return "modules/spm/ac/activityResearchRcList";
	}

	@RequiresPermissions("spm:ac:activityResearchRc:view")
	@RequestMapping(value = "info")
	public String info(ActivityResearchRc activityResearchRc, Model model) {
		model.addAttribute("activityResearchRc", activityResearchRc);
		return "modules/spm/ac/activityResearchRcInfo";
	}

	@RequiresPermissions("spm:ac:activityResearchRc:edit")
	@RequestMapping(value = "delete")
	public String delete(ActivityResearchRc activityResearchRc, RedirectAttributes redirectAttributes) {
		if(activityResearchRc == null || StringUtils.isBlank(activityResearchRc.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的调研活动参与记录信息！");
			return "error/400";
		}
		
		activityResearchRcService.delete(activityResearchRc);
		addMessage(redirectAttributes, "删除调研活动参与记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ac/activityResearchRc/?repage";
	}

}