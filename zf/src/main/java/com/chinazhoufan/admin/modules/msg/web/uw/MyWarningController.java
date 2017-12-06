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
@RequestMapping(value = "${adminPath}/msg/uw/myWarning")
public class MyWarningController extends BaseController {

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
	
	@RequiresPermissions("msg:uw:mywarning:view")
	@RequestMapping(value = {"list", ""})
	public String list(Warning warning, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Warning> page = warningService.findMyPage(new Page<Warning>(request, response), warning); 
		model.addAttribute("page", page);
		return "modules/msg/uw/myWarningList";
	}

	/**
	 * 完成
	 * @param warning
	 * @param model
	 * @return
	 */
	@RequiresPermissions("msg:uw:mywarning:view")
	@RequestMapping(value = "form")
	public String form(Warning warning, Model model) {
		warning.setDealEndTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
		warning.setStatus(Warning.STATUS_FINISH); //状态：完成
		model.addAttribute("warning", warning);
		model.addAttribute("myFalg", true);
		return "modules/msg/uw/warningForm";
	}

	/**
	 * 去处理
	 * @param warning
	 * @param model
	 * @return
	 */
	@RequiresPermissions("msg:uw:mywarning:edit")
	@RequestMapping(value = "toDeal")
	public String toDeal(Warning warning, Model model) {
		if(Warning.STATUS_TO_VIEW.equals(warning.getStatus())) {
			warning = warningService.view(warning);
		}
		warning.setDealStartTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss"))); //处理开始时间
		warning.setDealUser(UserUtils.getUser()); //处理人
		model.addAttribute("warning", warning);
		return "modules/msg/uw/dealWarning";
	}
	
	
	/**
	 * 处理完成
	 * @param warning
	 * @param model
	 * @return
	 */
	@RequiresPermissions("msg:uw:mywarning:edit")
	@RequestMapping(value = "finish")
	public String finish(Warning warning, Model model, RedirectAttributes redirectAttributes) {
		warning.setDealStartTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss"))); //处理开始时间
		warning.setDealEndTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss"))); //处理开始时间
		warning.setDealUser(UserUtils.getUser()); //处理人
		warning.setStatus(Warning.STATUS_FINISH);
		model.addAttribute("warning", warning);
		warningService.save(warning);
		addMessage(redirectAttributes, "预警消息处理成功!");
		return "redirect:"+Global.getAdminPath()+"/msg/uw/myWarning/?repage";
	}
	
	
	@RequiresPermissions("msg:uw:mywarning:view")
	@RequestMapping(value = "info")
	public String info(Warning warning, Model model) {
		if(Warning.STATUS_TO_VIEW.equals(warning.getStatus())) {
			warning = warningService.view(warning);
		}
		model.addAttribute("warning", warning);
		return "modules/msg/uw/warningInfo";
	}
	
	@RequiresPermissions("msg:uw:mywarning:edit")
	@RequestMapping(value = "save")
	public String save(Warning warning, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, warning)){
			return form(warning, model);
		}
		warningService.save(warning);
		if(Warning.STATUS_FINISH.equals(warning.getStatus())) {
			addMessage(redirectAttributes, "预警事件处理成功!");
		} else {
			addMessage(redirectAttributes, "保存员工报警中心成功!");
		}
		
		return "redirect:"+Global.getAdminPath()+"/msg/uw/myWarning/?repage";
	}
	
	@RequiresPermissions("msg:uw:mywarning:edit")
	@RequestMapping(value = "delete")
	public String delete(Warning warning, RedirectAttributes redirectAttributes) {
		if(warning == null || StringUtils.isBlank(warning.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的员工报警信息！");
			return "error/400";
		}
		warningService.delete(warning);
		addMessage(redirectAttributes, "删除员工报警中心成功");
		return "redirect:"+Global.getAdminPath()+"/msg/uw/myWarning/?repage";
	}

}