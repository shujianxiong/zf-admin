/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.bas.service.BasMissionService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 任务表Controller
 * @author 刘晓东
 * @version 2015-10-22
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/basMission")
public class BasMissionController extends BaseController {

	@SuppressWarnings("rawtypes")
	@Autowired
	private BasMissionService basMissionService;
	
	@SuppressWarnings("rawtypes")
	@ModelAttribute
	public BasMission get(@RequestParam(required=false) String id) {
		BasMission entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = basMissionService.get(id);
		}
		if (entity == null){
			entity = new BasMission();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:basMission:view")
	@RequestMapping(value = {"list", ""})
	public String list(BasMission basMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		basMission.setApproveUser(UserUtils.getUser());
		Page<BasMission> page = basMissionService.findPage(new Page<BasMission>(request, response), basMission); 
		model.addAttribute("page", page);
		return "modules/bas/basMissionList";
	}
	
	/**
	 * 我的待审核任务列表
	 * @param basMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("bas:basMission:view")
	@RequestMapping(value = "pendingList")
	public String pendingList(BasMission basMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		basMission.setApproveUser(UserUtils.getUser());
		basMission.setApproveStatus(BasMission.APPROVESTATUS_WAIT);
		Page<BasMission> page = basMissionService.findPage(new Page<BasMission>(request, response), basMission); 
		model.addAttribute("page", page);
		return "modules/bas/basMissionPendingList";
	}
	
	/**
	 * 我的已审核任务列表
	 * @param basMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("bas:basMission:view")
	@RequestMapping(value = "reviewList")
	public String reviewList(BasMission basMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		basMission.setApproveUser(UserUtils.getUser());
		//这里两个状态参数设置是为了确保查询条件是：已审核的
		basMission.setApproveStatus(BasMission.APPROVESTATUS_WAIT);
		basMission.setApproveStatusPassFlag(BasMission.APPROVESTATUS_PASS);
		Page<BasMission> page = basMissionService.findPage(new Page<BasMission>(request, response), basMission); 
		model.addAttribute("page", page);
		return "modules/bas/basMissionReviewList";
	}
	
	/**
	 * 所有的审核任务列表
	 * @param basMission
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("bas:basMission:view")
	@RequestMapping(value = {"allList"})
	public String allList(BasMission basMission, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BasMission> page = basMissionService.findPage(new Page<BasMission>(request, response), basMission); 
		model.addAttribute("page", page);
		return "modules/bas/basMissionAllList";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "check", method = RequestMethod.POST)
	public @ResponseBody String check(BasMission basMission,Integer type, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
		String status = "";
		try {
			//通过
			if(type == 1){
				basMission.setApproveStatus(BasMission.APPROVESTATUS_SUCCESS);
			}else{
			//不通过
				basMission.setApproveStatus(BasMission.APPROVESTATUS_REFUSE);
			}
			basMissionService.update(basMission);
			status = "true";
		} catch (Exception e) {
			e.printStackTrace();
			status = "false";
		}
		return JsonMapper.toJsonString(status);
	}

	@SuppressWarnings("rawtypes")
	@RequiresPermissions("bas:basMission:view")
	@RequestMapping(value = "form")
	public String form(BasMission basMission, Model model) {
		model.addAttribute("basMission", basMission);
		return "modules/bas/basMissionForm";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequiresPermissions("bas:basMission:edit")
	@RequestMapping(value = "save")
	public String save(BasMission basMission, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, basMission)){
			return form(basMission, model);
		}
		basMissionService.save(basMission);
		addMessage(redirectAttributes, "保存任务表成功");
		return "redirect:"+Global.getAdminPath()+"/bas/basMission/?repage";
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequiresPermissions("bas:basMission:edit")
	@RequestMapping(value = "delete")
	public String delete(BasMission basMission, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(basMission.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的任务信息！");
			return "error/400";
		}
		basMissionService.delete(basMission);
		addMessage(redirectAttributes, "删除任务表成功");
		return "redirect:"+Global.getAdminPath()+"/bas/basMission/?repage";
	}

}