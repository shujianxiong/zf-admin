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
import com.chinazhoufan.admin.modules.spm.entity.qa.BaseQuestion;
import com.chinazhoufan.admin.modules.spm.entity.qa.Questionnaire;
import com.chinazhoufan.admin.modules.spm.service.qa.BaseAnswerService;
import com.chinazhoufan.admin.modules.spm.service.qa.BaseQuestionService;
import com.chinazhoufan.admin.modules.spm.service.qa.QuestionnaireService;

/**
 * 问题基本信息Controller
 * @author 贾斌
 * @version 2015-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/qa/baseQuestion")
public class BaseQuestionController extends BaseController {

	@Autowired
	private BaseQuestionService baseQuestionService;
	@Autowired
	private QuestionnaireService questionnaireService;
	@Autowired
	private BaseAnswerService baseAnswerService;
	
	@ModelAttribute
	public BaseQuestion get(@RequestParam(required=false) String id) {
		BaseQuestion entity = null;
		if (StringUtils.isNotBlank(id)){
			//entity = baseQuestionService.get(id);
		}
		if (entity == null){
			entity = new BaseQuestion();
		}
		return entity; 
	}
	
	@RequiresPermissions("spm:qa:baseQuestion:view")
	@RequestMapping(value = {"list", ""})
	public String list(BaseQuestion baseQuestion, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseQuestion> page = baseQuestionService.findPage(new Page<BaseQuestion>(request, response), baseQuestion); 
		model.addAttribute("page", page);
		return "modules/spm/qa/baseQuestionList";
	}

	@RequiresPermissions("spm:qa:baseQuestion:view")
	@RequestMapping(value = "form")
	public String form(BaseQuestion baseQuestion, Model model) {
		model.addAttribute("baseQuestion", baseQuestion);
		return "modules/spm/qa/baseQuestionForm";
	}
	
	/**
	 * 详情
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "info")
	public String info(String id, Model model) {
		BaseQuestion baseQuestion=baseQuestionService.find(id);
		model.addAttribute("baseQuestion", baseQuestion);
		return "modules/spm/qa/baseQuestionInfo";
	}
	

	/**
	 * 保存问题，不支持修改操作
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions("spm:qa:baseQuestion:edit")
	@RequestMapping(value = "save")
	public String save(BaseQuestion baseQuestion, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baseQuestion)){
			return form(baseQuestion, model);
		}
		
		if(StringUtils.isBlank(baseQuestion.getName())){
			addMessage(model, "问卷问题项保存失败：问题不能为空");
			return form(baseQuestion, model);
		}
		if(StringUtils.isBlank(baseQuestion.getType())){
			addMessage(model, "问卷问题项保存失败：问题类型不能为空");
			return form(baseQuestion, model);
		}
		baseQuestion.setActiveFlag(BaseQuestion.FALSE_FLAG);
		baseQuestionService.save(baseQuestion);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/baseQuestion/list?repage";
	}
	
	/**
	 * 是否停用
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions("spm:qa:baseQuestion:edit")
	@RequestMapping(value = "isstop")
	public String isStop(BaseQuestion baseQuestion,Model model,HttpServletResponse response,HttpServletRequest request) {
		if(StringUtils.isBlank(baseQuestion.getId())){
			addMessage(model, "问卷问题项停用失败：未能获取到问题项标记");
			return list(baseQuestion, request, response, model);
		}
		BaseQuestion oldBaseQuestion = baseQuestionService.get(baseQuestion.getId());
		if(BaseQuestion.TRUE_FLAG.equals(oldBaseQuestion.getActiveFlag()))
			oldBaseQuestion.setActiveFlag(BaseQuestion.FALSE_FLAG);
		else
			oldBaseQuestion.setActiveFlag(BaseQuestion.TRUE_FLAG);
		baseQuestionService.update(oldBaseQuestion);
		addMessage(model, "修改成功");
		return list(baseQuestion, request, response, model);
	}
	
	/**
	 * 伪删除
	 * @param id
	 * @param model
	 * @return
	 */
	@RequiresPermissions("spm:qa:baseQuestion:edit")
	@RequestMapping(value = "delete")
	public String delete(BaseQuestion baseQuestion,Model model,HttpServletResponse response,HttpServletRequest request) {
		if(StringUtils.isBlank(baseQuestion.getId())){
			addMessage(model, "问卷问题项删除失败：未能获取到问题项标记");
			return list(baseQuestion, request, response, model);
		}
		BaseQuestion oldBaseQuestion = baseQuestionService.find(baseQuestion.getId());
		baseQuestionService.delete(oldBaseQuestion);
		addMessage(model, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/spm/qa/baseQuestion/list?repage";
	}
	
	
	/**
	 * 问卷关联问题选择器
	 * @param baseQuestion
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"questionSelect"})
	public String questionSelect(String questionnaireId,BaseQuestion baseQuestion, HttpServletRequest request, HttpServletResponse response, Model model) {
		baseQuestion.setActiveFlag(BaseQuestion.TRUE_FLAG); //只查启用状态问题
		Page<BaseQuestion> page = baseQuestionService.findPage(new Page<BaseQuestion>(request, response), baseQuestion); 
		Questionnaire quePage =questionnaireService.get(questionnaireId);
		model.addAttribute("page", page);
		model.addAttribute("quePage", quePage);
		model.addAttribute("questionnaireId", questionnaireId);
		return "modules/spm/qa/questionSelect";
	}

}