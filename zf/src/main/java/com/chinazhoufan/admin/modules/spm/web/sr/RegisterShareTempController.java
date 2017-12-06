/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.sr;

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
import com.chinazhoufan.admin.modules.spm.entity.sr.RegisterShareTemp;
import com.chinazhoufan.admin.modules.spm.service.sr.RegisterShareTempService;

/**
 * 注册分享模板Controller
 * @author 刘晓东
 * @version 2015-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/sr/registerShareTemp")
public class RegisterShareTempController extends BaseController {

	@Autowired
	private RegisterShareTempService registerShareTempService;
//	@Autowired
//	private RegisterShareTempDao registerShareTempDao;
	
	@ModelAttribute
	public RegisterShareTemp get(@RequestParam(required=false) String id) {
		RegisterShareTemp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = registerShareTempService.get(id);
		}
		if (entity == null){
			entity = new RegisterShareTemp();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:sr:registerShareTemp:view")
	@RequestMapping(value = {"list", ""})
	public String list(RegisterShareTemp registerShareTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RegisterShareTemp> page = registerShareTempService.findPage(new Page<RegisterShareTemp>(request, response), registerShareTemp); 
		model.addAttribute("page", page);
		return "modules/spm/sr/registerShareTempList";
	}

	@RequiresPermissions("spm:sr:registerShareTemp:view")
	@RequestMapping(value = "form")
	public String form(RegisterShareTemp registerShareTemp,HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("registerShareTemp", registerShareTemp);
		return "modules/spm/sr/registerShareTempForm";
	}
	
	@RequiresPermissions("spm:sr:registerShareTemp:edit")
	@RequestMapping(value = "edit")
	public String edit(RegisterShareTemp registerShareTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		/**
		 * 模板使用状态不为新建时，不能修改
		 */
		RegisterShareTemp registerShareTempOld = registerShareTempService.get(registerShareTemp.getId());
		if (!StringUtils.isBlank(registerShareTemp.getId())) {
			if (!registerShareTempOld.getTempStatus().equals(RegisterShareTemp.TEMPSTATUS_NEW)) {
				addMessage(model, "模板状态为新建时才能修改");
				return list(registerShareTemp, request, response, model);
			}
		}
		model.addAttribute("registerShareTemp", registerShareTempOld);
		return "modules/spm/sr/registerShareTempEdit";
	}
	
	@RequiresPermissions("spm:sr:registerShareTemp:view")
	@RequestMapping(value = "info")
	public String info(RegisterShareTemp registerShareTemp , HttpServletRequest request, HttpServletResponse response, Model model) {
		if(registerShareTemp == null || StringUtils.isBlank(registerShareTemp.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的注册分享模板信息！");
			return "error/400";
		}
		model.addAttribute("registerShareTemp", registerShareTemp);
		return "modules/spm/sr/registerShareTempInfo";
	}
	
	@RequiresPermissions("spm:sr:registerShareTemp:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(RegisterShareTemp registerShareTemp ,String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (registerShareTemp == null || StringUtils.isBlank(registerShareTemp.getId())) {
			addMessage(model, "友情提示：未能获取到商品信息");
			return "error/400";
		}
		
		if(StringUtils.isBlank(status)){
			addMessage(model, "友情提示：未能获取到商品状态信息");
			return "error/400";
		}
		
		RegisterShareTemp registerShareTempOld = registerShareTempService.get(registerShareTemp.getId());
		
		//启用
		if (RegisterShareTemp.TEMPSTATUS_ENABLE.equals(status)) {
			
			//判断该模板是否已启用
			if (registerShareTempOld.getTempStatus().equals(RegisterShareTemp.TEMPSTATUS_ENABLE)) {
				addMessage(model, "该模板已经启用");
				return list(registerShareTemp, request, response, model);
			}
			//查询是否有启用的
			int cnt = registerShareTempService.enable(registerShareTemp);
			registerShareTempOld.setTempStatus(status);
			registerShareTempService.update(registerShareTempOld);
			if (cnt == 0) {
				addMessage(model, "已启用");
			}else {
				addMessage(model, "启用成功,并已自动关闭旧模板");
			}
			return list(registerShareTemp, request, response, model);
		}
		//停用
		else if (RegisterShareTemp.TEMPSTATUS_DISABLED.equals(status)) {
			registerShareTempOld.setTempStatus(status);
			registerShareTempService.update(registerShareTempOld);
			addMessage(model, "已停用");
			return list(registerShareTemp, request, response, model);
		}
		addMessage(model, "操作失败");
		return list(registerShareTemp, request, response, model);
	}
	@RequiresPermissions("spm:sr:registerShareTemp:edit")
	@RequestMapping(value = "save")
	public String save(RegisterShareTemp registerShareTemp,HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, registerShareTemp)){
			return form(registerShareTemp, request, response, model);
		}
		/**
		 * 1.活动启用时间不得大于当前时间
		 */
		int n = DateUtils.compare_date(registerShareTemp.getActiveStartTime());
		if (n >= 0) {
			addMessage(model, "活动启用时间不得大于当前时间");
			return form(registerShareTemp, request, response, model);
		}
		registerShareTempService.save(registerShareTemp);
		addMessage(redirectAttributes, "保存注册分享模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/sr/registerShareTemp/?repage";
	}
	
	@RequiresPermissions("spm:sr:registerShareTemp:edit")
	@RequestMapping(value = "delete")
	public String delete(RegisterShareTemp registerShareTemp, RedirectAttributes redirectAttributes) {
		if(registerShareTemp == null || StringUtils.isBlank(registerShareTemp.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的注册分享模板信息！");
			return "error/400";
		}
		
		registerShareTempService.delete(registerShareTemp);
		addMessage(redirectAttributes, "删除注册分享模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/sr/registerShareTemp/?repage";
	}

}