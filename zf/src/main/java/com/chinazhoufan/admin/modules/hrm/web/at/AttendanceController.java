/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.at;

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
import com.chinazhoufan.admin.modules.hrm.entity.at.Attendance;
import com.chinazhoufan.admin.modules.hrm.service.at.AttendanceService;

/**
 * 员工考勤记录表Controller
 * @author 刘晓东
 * @version 2015-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/at/attendance")
public class AttendanceController extends BaseController {

	@Autowired
	private AttendanceService attendanceService;
	
	@ModelAttribute
	public Attendance get(@RequestParam(required=false) String id) {
		Attendance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = attendanceService.get(id);
		}
		if (entity == null){
			entity = new Attendance();
		}
		return entity;
	}
	
	@RequiresPermissions("hrm:at:attendance:view")
	@RequestMapping(value = {"list", ""})
	public String list(Attendance attendance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Attendance> page = attendanceService.findPage(new Page<Attendance>(request, response), attendance); 
		model.addAttribute("page", page);
		return "modules/hrm/at/attendanceList";
	}

	@RequiresPermissions("hrm:at:attendance:view")
	@RequestMapping(value = "form")
	public String form(Attendance attendance, Model model) {
		model.addAttribute("attendance", attendance);
		return "modules/hrm/at/attendanceForm";
	}

	@RequiresPermissions("hrm:at:attendance:edit")
	@RequestMapping(value = "save")
	public String save(Attendance attendance, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, attendance)){
			return form(attendance, model);
		}
		attendanceService.save(attendance);
		addMessage(redirectAttributes, "保存员工考勤记录表成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/at/attendance/?repage";
	}
	
	@RequiresPermissions("hrm:at:attendance:edit")
	@RequestMapping(value = "delete")
	public String delete(Attendance attendance, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(attendance.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的员工考勤记录！");
			return "error/400";
		}
		attendanceService.delete(attendance);
		addMessage(redirectAttributes, "删除员工考勤记录表成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/at/attendance/?repage";
	}

	@RequiresPermissions("hrm:at:attendance:view")
	@RequestMapping(value = "info")
	public String info(Attendance attendance, HttpServletRequest request, HttpServletResponse response,  Model model) {
		if(StringUtils.isBlank(attendance.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的员工考勤记录！");
			return "error/400";
		}
		model.addAttribute("attendance", attendance);
		return "modules/hrm/at/attendanceInfo";
	}
	
}