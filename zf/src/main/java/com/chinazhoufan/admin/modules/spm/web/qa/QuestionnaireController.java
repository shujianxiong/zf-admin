/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.qa;

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
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireQueService;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireService;

/**
 * 问卷列表Controller
 * @author 贾斌
 * @version 2015-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/qa/questionnaire")
public class QuestionnaireController extends BaseController {

	@Autowired
	private QuestionnaireService questionnaireService;
	@Autowired
	private QuestionnaireQueService questionnaireQueService;
	@ModelAttribute
	public Questionnaire get(@RequestParam(required=false) String id) {
		Questionnaire entity = null;
		if (StringUtils.isNotBlank(id)){
			//entity = questionnaireService.get(id);
		}
		if (entity == null){
			entity = new Questionnaire();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:qa:questionnaire:view")
	@RequestMapping(value = {"list", ""})
	public String list(Questionnaire questionnaire, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Questionnaire> page = questionnaireService.findPage(new Page<Questionnaire>(request, response), questionnaire); 
		model.addAttribute("page", page);
		return "modules/spm/qa/questionnaireList";
	}
	
	@RequiresPermissions("spm:qa:questionnaire:view")
	@RequestMapping(value = "info")
	public String info(Questionnaire questionnaire, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(questionnaire == null || StringUtils.isBlank(questionnaire.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的问卷信息！");
			return "error/400";
		}
		
		questionnaire = questionnaireService.get(questionnaire.getId());
		model.addAttribute("questionnaire", questionnaire);
		return "modules/spm/qa/questionnaireInfo";
	}

	@RequiresPermissions("spm:qa:questionnaire:view")
	@RequestMapping(value = "form")
	public String form(Questionnaire questionnaire, Model model) {
		//为新增时积分奖励默认设置为true
		if (StringUtils.isBlank(questionnaire.getId())) {
			questionnaire.setRewardPointFlag(Questionnaire.TRUE_FLAG);
		}else {
			questionnaire = questionnaireService.get(questionnaire.getId());
		}
		model.addAttribute("questionnaire", questionnaire);
		return "modules/spm/qa/questionnaireForm";
	}

	@RequiresPermissions("spm:qa:questionnaire:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(Questionnaire questionnaire,HttpServletRequest request, HttpServletResponse response, Model model){
		if (StringUtils.isBlank(questionnaire.getId())) {
			addMessage(model, "操作失败，未能获取到问卷标记！");
			return list(questionnaire, request, response, model);
		}
		Questionnaire oldQuestionnaire=questionnaireService.get(questionnaire.getId());
		oldQuestionnaire.setStatus(Questionnaire.STATUS_RELEASE); //发布状态
		questionnaireService.save(oldQuestionnaire);
		addMessage(model, "发布问卷成功");
		return list(questionnaire, request, response, model);
	}
	
	/**
	 * 给问卷添加问题
	 * @param questionnaire
	 * @param model
	 * @return
	 */
	@RequiresPermissions("spm:qa:questionnaire:edit")
	@RequestMapping(value = "addQueform")
	public String addQueform(Questionnaire questionnaire,HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(questionnaire.getId())){
			addMessage(model, "操作失败，未能获取到问卷标记！");
			return list(questionnaire, request, response, model);
		}
		Questionnaire oldQuestionnaire=questionnaireService.get(questionnaire.getId());
		//发布状态不允许修改添加问题
		if (!Questionnaire.STATUS_NEW.equals(oldQuestionnaire.getStatus())) {
			addMessage(model, "操作失败，问卷状态为新建时才能添加问题！");
			return list(questionnaire, request, response, model);
		}
		model.addAttribute("questionnaire", oldQuestionnaire);
		return "modules/spm/qa/addQuestionnaireQueForm";
	}
	
	@RequiresPermissions("spm:qa:questionnaire:edit")
	@RequestMapping(value = "save")
	public String save(Questionnaire questionnaire, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, questionnaire)){
			return form(questionnaire, model);
		}
		questionnaireService.save(questionnaire);
		addMessage(redirectAttributes, "保存问卷成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/questionnaire/?repage";
	}
	
	@RequiresPermissions("spm:qa:questionnaire:edit")
	@RequestMapping(value = "delete")
	public String delete(Questionnaire questionnaire,Model model,HttpServletRequest request,HttpServletResponse response) {
		if(questionnaire == null || StringUtils.isBlank(questionnaire.getId())) {
			addMessage(model, "友情提示：未能获取到要删除的问卷信息！");
			return "error/400";
		}
		questionnaireService.delete(questionnaire);
		addMessage(model, "删除问卷成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/questionnaire/?repage";
	}
	
	
	/**保存问卷关联问题**/
	@RequiresPermissions("spm:qa:questionnaire:edit")
	@RequestMapping(value = "saveQuestion")
	public String saveQuestion(Questionnaire questionnaire,RedirectAttributes redirectAttributes, HttpServletResponse response) {
		try {
			questionnaireService.saveQuestion(questionnaire);
			addMessage(redirectAttributes, "保存问题成功!");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "操作失败！"+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/spm/qa/questionnaire/?repage";
	}
	
	
	@RequestMapping(value = "select")
	public String select(Questionnaire questionnaire,String pageKey, HttpServletRequest request, HttpServletResponse response, Model model) {
		questionnaire.setStatus(Questionnaire.STATUS_RELEASE);
		Page<Questionnaire> page = questionnaireService.findPage(new Page<Questionnaire>(request, response), questionnaire); 
		model.addAttribute("page", page);
		model.addAttribute("pagekey", pageKey);
		return "modules/spm/qa/questionnaireSelect";
	}
	
}