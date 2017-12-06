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
import com.chinazhoufan.admin.modules.spm.entity.qa.QuestionnaireQue;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireQueService;

/**
 * 问卷问题列表Controller
 * @author 贾斌
 * @version 2015-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/qa/questionnaireQue")
public class QuestionnaireQueController extends BaseController {

	@Autowired
	private QuestionnaireQueService questionnaireQueService;
	
	@ModelAttribute
	public QuestionnaireQue get(@RequestParam(required=false) String id) {
		QuestionnaireQue entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = questionnaireQueService.get(id);
		}
		if (entity == null){
			entity = new QuestionnaireQue();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:qa:questionnaireQue:view")
	@RequestMapping(value = {"list", ""})
	public String list(QuestionnaireQue questionnaireQue, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QuestionnaireQue> page = questionnaireQueService.findPage(new Page<QuestionnaireQue>(request, response), questionnaireQue); 
		model.addAttribute("page", page);
		return "modules/spm/qa/questionnaireQueList";
	}

	@RequiresPermissions("spm:qa:questionnaireQue:view")
	@RequestMapping(value = "form")
	public String form(QuestionnaireQue questionnaireQue, Model model) {
		model.addAttribute("questionnaireQue", questionnaireQue);
		return "modules/spm/qa/questionnaireQueForm";
	}

	@RequiresPermissions("spm:qa:questionnaireQue:edit")
	@RequestMapping(value = "save")
	public String save(QuestionnaireQue questionnaireQue, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, questionnaireQue)){
			return form(questionnaireQue, model);
		}
		questionnaireQueService.save(questionnaireQue);
		addMessage(redirectAttributes, "保存问卷问题成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/questionnaireQue/?repage";
	}
	
	@RequiresPermissions("spm:qa:questionnaireQue:edit")
	@RequestMapping(value = "delete")
	public String delete(QuestionnaireQue questionnaireQue, RedirectAttributes redirectAttributes) {
		if(questionnaireQue == null || StringUtils.isBlank(questionnaireQue.getId())) {
			addMessage(redirectAttributes, "未获取到要删除的问卷问题信息！");
			return "redirect:"+Global.getAdminPath()+"/spm/qa/questionnaireQue/?repage";
		}
		
		questionnaireQueService.delete(questionnaireQue);
		addMessage(redirectAttributes, "删除问卷问题成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/questionnaireQue/?repage";
	}

}