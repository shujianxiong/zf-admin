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
import com.chinazhoufan.admin.modules.hrm.entity.ei.Employee;
import com.chinazhoufan.admin.modules.hrm.service.ei.EmployeeService;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 员工信息表Controller
 * @author 陈适
 * @version 2015-12-08
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/ei/employee")
public class EmployeeController extends BaseController {

	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public Employee get(@RequestParam(required=false) String id) {
		Employee entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = employeeService.get(id);
		}
		if (entity == null){
			entity = new Employee();
		}
		return entity;
	}
	
	@RequiresPermissions("hrm:ei:employee:view")
	@RequestMapping(value = {"list", ""})
	public String list(Employee employee, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Employee> page = employeeService.findPage(new Page<Employee>(request, response), employee); 
		model.addAttribute("page", page);
		return "modules/hrm/ei/employeeList";
	}

	@RequiresPermissions("hrm:ei:employee:view")
	@RequestMapping(value = "form")
	public String form(Employee employee, Model model) {
		if(null != employee && null != employee.getUser() && StringUtils.isNotBlank(employee.getUser().getId())){
			Employee tempUserInfo = employeeService.findUserInfoByUserId(employee);
			if(null != tempUserInfo){
				employee = tempUserInfo;
				employee.setLiveArea(UserUtils.getAreaById(employee.getLiveArea().getId()));
				employee.setHouseholdAddr(UserUtils.getAreaById(employee.getHouseholdAddr().getId()));
				employee.setInsuranceAddr(UserUtils.getAreaById(employee.getInsuranceAddr().getId()));
				employee.setCpfAddr(UserUtils.getAreaById(employee.getCpfAddr().getId()));
			}
			employee.setUser(UserUtils.get(employee.getUser().getId()));
		}
		
		model.addAttribute("employee", employee);
		return "modules/hrm/ei/employeeForm";
	}

	@RequiresPermissions("hrm:ei:employee:edit")
	@RequestMapping(value = "save")
	public String save(Employee employee, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, employee)){
			return form(employee, model);
		}
		employeeService.save(employee);
		addMessage(redirectAttributes, "保存员工信息成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/ei/employee/list?repage";
	}
	
	@RequiresPermissions("hrm:ei:employee:edit")
	@RequestMapping(value = "delete")
	public String delete(Employee employee, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(employee.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要是删除的员工信息！");
			return "error/400";
		}
		employeeService.delete(employee);
		addMessage(redirectAttributes, "删除员工信息成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/ei/employee/list?repage";
	}

	@RequiresPermissions("hrm:ei:employee:view")
	@RequestMapping(value = "info")
	public String info(Employee employee, HttpServletRequest request, HttpServletResponse response,   Model model) {
		if(StringUtils.isBlank(employee.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的员工信息！");
			return "error/400";
		}
		model.addAttribute("employee", employee);
		return "modules/hrm/ei/employeeInfo";
	}
}