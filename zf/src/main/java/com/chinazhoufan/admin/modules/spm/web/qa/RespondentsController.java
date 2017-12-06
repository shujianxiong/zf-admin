/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.qa;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.entity.qa.QuestionnaireQue;
import com.chinazhoufan.admin.modules.spm.entity.qa.Respondents;
import com.chinazhoufan.admin.modules.spm.service.qa.BaseAnswerService;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireQueService;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireService;
import com.chinazhoufan.admin.modules.spm.service.qa.RespondentsAnsService;
import com.chinazhoufan.admin.modules.spm.service.qa.RespondentsService;

/**
 * 答卷列表Controller
 * @author 贾斌
 * @version 2015-11-18
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/qa/respondents")
public class RespondentsController extends BaseController {

	@Autowired
	private QuestionnaireService questionnaireService;//问卷
	@Autowired
	private RespondentsService respondentsService;//用户答卷
	@Autowired
	private QuestionnaireQueService questionnaireQueService;//问卷问题
	@Autowired
	private RespondentsAnsService respondentsAnsService;//用户回答问卷问题答案
	@Autowired
	private BaseAnswerService baseAnswerService;//问题答案
	
	@ModelAttribute
	public Respondents get(@RequestParam(required=false) String id) {
		Respondents entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = respondentsService.get(id);
		}
		if (entity == null){
			entity = new Respondents();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:qa:respondents:view")
	@RequestMapping(value = {"list", ""})
	public String list(Respondents respondents, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Respondents> page = respondentsService.findPage(new Page<Respondents>(request, response), respondents); 
		model.addAttribute("page", page);
		return "modules/spm/qa/respondentsList";
	}

	/**
	 * 答卷详情
	 * @param respondents
	 * @param model
	 * @return
	 */
	@RequiresPermissions("spm:qa:respondents:view")
	@RequestMapping(value = "info")
	public String info(Respondents respondents, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(respondents == null || StringUtils.isBlank(respondents.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的答卷信息！");
			return "error/400";
		}
		
		// 获取答卷对应的问卷（包含问卷问题、答卷答案）
		Questionnaire questionnaire = questionnaireService.getInfoByRespondentsId(respondents.getId());
		List<QuestionnaireQue> questionnaireQueList = questionnaireQueService.getByRespondents(respondents);
		model.addAttribute("questionnaire", questionnaire);	// 问卷
		model.addAttribute("respondents", respondents);		// 答卷
		model.addAttribute("questionnaireQueList", questionnaireQueList);	// 问卷问题
		
		return "modules/spm/qa/respondentsFormDetail";
	}
	
	@RequiresPermissions("spm:qa:respondents:view")
	@RequestMapping(value = "form")
	public String form(Respondents respondents, Model model) {
		model.addAttribute("respondents", respondents);
		return "modules/spm/qa/respondentsForm";
	}

	@RequiresPermissions("spm:qa:respondents:edit")
	@RequestMapping(value = "save")
	public String save(Respondents respondents, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, respondents)){
			return form(respondents, model);
		}
		respondentsService.save(respondents);
		addMessage(redirectAttributes, "保存答卷列表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/respondents/?repage";
	}
	
	@RequiresPermissions("spm:qa:respondents:edit")
	@RequestMapping(value = "delete")
	public String delete(Respondents respondents, RedirectAttributes redirectAttributes) {
		if(respondents == null || StringUtils.isBlank(respondents.getId())) {
			 addMessage(redirectAttributes, "友情提示：未能获取到要删除的答卷信息！");
			 return "error/400";
		}
		
		respondentsService.delete(respondents);
		addMessage(redirectAttributes, "删除答卷列表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/respondents/?repage";
	}

}