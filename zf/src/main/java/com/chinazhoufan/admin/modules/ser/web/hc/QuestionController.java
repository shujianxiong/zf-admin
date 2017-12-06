/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.hc;

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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.ser.entity.hc.Question;
import com.chinazhoufan.admin.modules.ser.service.hc.QuestionService;

/**
 * 帮助中心问题Controller
 * @author 张金俊
 * @version 2017-07-31
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/hc/question")
public class QuestionController extends BaseController {

	@Autowired
	private QuestionService questionService;
	
	@ModelAttribute
	public Question get(@RequestParam(required=false) String id) {
		Question entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = questionService.get(id);
		}
		if (entity == null){
			entity = new Question();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:hc:question:view")
	@RequestMapping(value = {"list", ""})
	public String list(Question question, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Question> page = questionService.findPage(new Page<Question>(request, response), question); 
		model.addAttribute("page", page);
		return "modules/ser/hc/questionList";
	}

	@RequiresPermissions("ser:hc:question:view")
	@RequestMapping(value = "form")
	public String form(Question question, Model model) {
		model.addAttribute("question", question);
		return "modules/ser/hc/questionForm";
	}

	@RequiresPermissions("ser:hc:question:edit")
	@RequestMapping(value = "save")
	public String save(Question question, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, question)){
			return form(question, model);
		}*/
		questionService.save(question);
		addMessage(redirectAttributes, "保存帮助中心问题成功");
		return "redirect:"+Global.getAdminPath()+"/ser/hc/question/?repage";
	}
	
	@RequiresPermissions("ser:hc:question:edit")
	@RequestMapping(value = "delete")
	public String delete(Question question, RedirectAttributes redirectAttributes) {
		questionService.delete(question);
		addMessage(redirectAttributes, "删除帮助中心问题成功");
		return "redirect:"+Global.getAdminPath()+"/ser/hc/question/?repage";
	}

    @RequiresPermissions("ser:hc:question:view")
    @RequestMapping(value = "info")
    public String info(Question question, Model model) {
        model.addAttribute("question", question);
        return "modules/ser/hc/questionInfo";
    }
}