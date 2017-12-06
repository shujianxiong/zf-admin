/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.hc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
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
import com.chinazhoufan.admin.modules.ser.entity.hc.Suggestion;
import com.chinazhoufan.admin.modules.ser.service.hc.SuggestionService;

/**
 * 帮助中心建议Controller
 * @author 张金俊
 * @version 2017-07-31
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/hc/suggestion")
public class SuggestionController extends BaseController {

	@Autowired
	private SuggestionService suggestionService;
	
	@ModelAttribute
	public Suggestion get(@RequestParam(required=false) String id) {
		Suggestion entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = suggestionService.get(id);
		}
		if (entity == null){
			entity = new Suggestion();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:hc:suggestion:view")
	@RequestMapping(value = {"list", ""})
	public String list(Suggestion suggestion, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Suggestion> page = suggestionService.findPage(new Page<Suggestion>(request, response), suggestion); 
		model.addAttribute("page", page);
		return "modules/ser/hc/suggestionList";
	}

	@RequiresPermissions("ser:hc:suggestion:view")
	@RequestMapping(value = "form")
	public String form(Suggestion suggestion, Model model) {
		model.addAttribute("suggestion", suggestion);
		return "modules/ser/hc/suggestionForm";
	}

	@RequiresPermissions("ser:hc:suggestion:edit")
	@RequestMapping(value = "save")
	public String save(Suggestion suggestion, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, suggestion)){
			return form(suggestion, model);
		}*/
		try {
			suggestionService.save(suggestion);
			addMessage(redirectAttributes, "保存帮助中心建议成功");
			}catch(ServiceException e){
				e.printStackTrace();
				addMessage(redirectAttributes, e.getMessage());
			} catch (Exception e) {
				e.printStackTrace();
				addMessage(redirectAttributes, "失败：保存帮助中心建议异常");
		}
		return "redirect:"+Global.getAdminPath()+"/ser/hc/suggestion/?repage";
	}
	
	@RequiresPermissions("ser:hc:suggestion:edit")
	@RequestMapping(value = "delete")
	public String delete(Suggestion suggestion, RedirectAttributes redirectAttributes) {
		suggestionService.delete(suggestion);
		addMessage(redirectAttributes, "删除帮助中心建议成功");
		return "redirect:"+Global.getAdminPath()+"/ser/hc/suggestion/?repage";
	}

    @RequiresPermissions("ser:hc:suggestion:view")
    @RequestMapping(value = "info")
    public String info(Suggestion suggestion, Model model) {
        model.addAttribute("suggestion", suggestion);
        return "modules/ser/hc/suggestionInfo";
    }
}