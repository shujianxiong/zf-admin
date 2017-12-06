/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web.ap;

import java.util.List;

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
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveConfig;
import com.chinazhoufan.admin.modules.bas.service.ap.ApproveConfigService;
import com.google.common.collect.Lists;

/**
 * 审批设置Controller
 * @author 贾斌
 * @version 2016-03-31
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/ap/approveConfig")
public class ApproveConfigController extends BaseController {

	@Autowired
	private ApproveConfigService approveConfigService;
	
	@ModelAttribute
	public ApproveConfig get(@RequestParam(required=false) String id) {
		ApproveConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = approveConfigService.get(id);
		}
		if (entity == null){
			entity = new ApproveConfig();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:ap:approveConfig:view")
	@RequestMapping(value = {"list", ""})
	public String list(ApproveConfig approveConfig, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ApproveConfig> page = approveConfigService.findPage(new Page<ApproveConfig>(request, response), approveConfig); 
		model.addAttribute("page", page);
		return "modules/bas/ap/approveConfigList";
	}

	@RequiresPermissions("bas:ap:approveConfig:view")
	@RequestMapping(value = "form")
	public String form(ApproveConfig approveConfig, Model model) {
		if(StringUtils.isBlank(approveConfig.getId())) {
			approveConfig.setUsableFlag(ApproveConfig.TRUE_FLAG);
		}
		model.addAttribute("approveConfig", approveConfig);
		return "modules/bas/ap/approveConfigForm";
	}

	@RequiresPermissions("bas:ap:approveConfig:edit")
	@RequestMapping(value = "save")
	public String save(ApproveConfig approveConfig, HttpServletRequest request, HttpServletResponse response,   Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, approveConfig)){
			return form(approveConfig, model);
		}
		List<String> message=Lists.newArrayList();
		if(StringUtils.isBlank(approveConfig.getApproveName())){
			message.add("请输入审批项名称");
		}
		if(StringUtils.isBlank(approveConfig.getBusinessType())){
			message.add("请选择审批业务类型");
		}
		if(StringUtils.isBlank(approveConfig.getBusinessStatus())){
			message.add("请选择审批业务状态类型");
		}
		if(approveConfig.getApproveUser()==null||StringUtils.isBlank(approveConfig.getApproveUser().getId())){
			message.add("请选择审批接收人");
		}
		if(StringUtils.isBlank(approveConfig.getUsableFlag())){
			message.add("请设置是否开启");
		}
		if(message.size()<=0){
			
			int flag = approveConfigService.saveApproveConfig(approveConfig);
			if(flag == 0) {
				addMessage(redirectAttributes, "保存审批设置成功");
			} else {
				addMessage(redirectAttributes, "失败：已存在同类型设置。\n友情提醒：审批业务类型，审批业务状态类型一致的记录只允许添加一条!");
			}
		}else{
			addMessage(redirectAttributes, "保存审批设置失败:<br/>"+message);
			return form(approveConfig, model);
		}
		return "redirect:"+Global.getAdminPath()+"/bas/ap/approveConfig/?repage";
	}
	
	@RequiresPermissions("bas:ap:approveConfig:edit")
	@RequestMapping(value = "updateFlag")
	public String updateFlag(ApproveConfig approveConfig, HttpServletRequest request, HttpServletResponse response, Model model){
		if(StringUtils.isBlank(approveConfig.getId())) {
			addMessage(model, "友情提示：未能获取到要变更状态的配置信息");
			return "error/400";
		}
		
		if(approveConfig.getUsableFlag().equals(approveConfig.TRUE_FLAG))
			approveConfig.setUsableFlag(approveConfig.FALSE_FLAG);
		else
			approveConfig.setUsableFlag(approveConfig.TRUE_FLAG);
		approveConfigService.updateFlag(approveConfig);
		return list(approveConfig, request, response, model);
	}
	
	@RequiresPermissions("bas:ap:approveConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(ApproveConfig approveConfig, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(approveConfig.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的配置信息！");
			return "error/400";
		}
		approveConfigService.delete(approveConfig);
		addMessage(redirectAttributes, "删除审批设置成功");
		return "redirect:"+Global.getAdminPath()+"/bas/ap/approveConfig/?repage";
	}

}