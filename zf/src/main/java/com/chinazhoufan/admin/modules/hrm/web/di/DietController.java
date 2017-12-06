/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.di;

import java.math.BigDecimal;

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
import com.chinazhoufan.admin.modules.hrm.entity.di.Diet;
import com.chinazhoufan.admin.modules.hrm.service.di.DietService;

/**
 * 日常菜谱管理Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/diet")
public class DietController extends BaseController {

	@Autowired
	private DietService dietService;
	
	@ModelAttribute
	public Diet get(@RequestParam(required=false) String id) {
		Diet entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dietService.get(id);
		}
		if (entity == null){
			entity = new Diet();
		}
		if (entity.getScore() == null){
			entity.setScore(new BigDecimal("5.00"));
		}
		return entity;
	}
	
	@RequiresPermissions("hrm:di:diet:view")
	@RequestMapping(value = {"list", ""})
	public String list(Diet diet, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Diet> page = dietService.findPage(new Page<Diet>(request, response), diet); 
		model.addAttribute("page", page);
		return "modules/hrm/di/dietList";
	}

	@RequiresPermissions("hrm:di:diet:view")
	@RequestMapping(value = "form")
	public String form(Diet diet, Model model) {
		model.addAttribute("diet", diet);
		return "modules/hrm/di/dietForm";
	}

	@RequiresPermissions("hrm:di:diet:edit")
	@RequestMapping(value = "save")
	public String save(Diet diet, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, diet)){
			return form(diet, model);
		}
		dietService.save(diet);
		addMessage(redirectAttributes, "保存日常菜谱成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/diet/?repage";
	}
	
	@RequiresPermissions("hrm:di:diet:edit")
	@RequestMapping(value = "delete")
	public String delete(Diet diet, RedirectAttributes redirectAttributes) {
		dietService.delete(diet);
		addMessage(redirectAttributes, "删除日常菜谱成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/diet/?repage";
	}

    @RequiresPermissions("hrm:di:diet:view")
    @RequestMapping(value = "info")
    public String info(Diet diet, Model model) {
        model.addAttribute("diet", diet);
        return "modules/hrm/di/dietInfo";
    }
}