/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.di;

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
import com.chinazhoufan.admin.modules.hrm.entity.di.DishJudge;
import com.chinazhoufan.admin.modules.hrm.service.di.DishJudgeService;

/**
 * 日常菜品评价Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/dishJudge")
public class DishJudgeController extends BaseController {

	@Autowired
	private DishJudgeService dishJudgeService;
	
	@ModelAttribute
	public DishJudge get(@RequestParam(required=false) String id) {
		DishJudge entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dishJudgeService.get(id);
		}
		if (entity == null){
			entity = new DishJudge();
		}
		return entity;
	}
	
	@RequiresPermissions("hrm:di:dishJudge:view")
	@RequestMapping(value = {"list", ""})
	public String list(DishJudge dishJudge, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DishJudge> page = dishJudgeService.findPage(new Page<DishJudge>(request, response), dishJudge); 
		model.addAttribute("page", page);
		return "modules/hrm/di/dishJudgeList";
	}

	@RequiresPermissions("hrm:di:dishJudge:view")
	@RequestMapping(value = "form")
	public String form(DishJudge dishJudge, Model model) {
		model.addAttribute("dishJudge", dishJudge);
		return "modules/hrm/di/dishJudgeForm";
	}

	@RequiresPermissions("hrm:di:dishJudge:edit")
	@RequestMapping(value = "save")
	public String save(DishJudge dishJudge, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dishJudge)){
			return form(dishJudge, model);
		}
		dishJudgeService.save(dishJudge);
		addMessage(redirectAttributes, "保存日常菜品评价成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/dishJudge/?repage";
	}
	
	@RequiresPermissions("hrm:di:dishJudge:edit")
	@RequestMapping(value = "delete")
	public String delete(DishJudge dishJudge, RedirectAttributes redirectAttributes) {
		dishJudgeService.delete(dishJudge);
		addMessage(redirectAttributes, "删除日常菜品评价成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/dishJudge/?repage";
	}

    @RequiresPermissions("hrm:di:dishJudge:view")
    @RequestMapping(value = "info")
    public String info(DishJudge dishJudge, Model model) {
        model.addAttribute("dishJudge", dishJudge);
        return "modules/hrm/di/dishJudgeInfo";
    }
}