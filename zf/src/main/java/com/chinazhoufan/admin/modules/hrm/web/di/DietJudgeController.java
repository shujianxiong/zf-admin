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
import com.chinazhoufan.admin.modules.hrm.entity.di.DietJudge;
import com.chinazhoufan.admin.modules.hrm.service.di.DietJudgeService;

/**
 * 日常菜谱评价Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/dietJudge")
public class DietJudgeController extends BaseController {

	@Autowired
	private DietJudgeService dietJudgeService;
	
	@ModelAttribute
	public DietJudge get(@RequestParam(required=false) String id) {
		DietJudge entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dietJudgeService.get(id);
		}
		if (entity == null){
			entity = new DietJudge();
		}
		return entity;
	}
	
	@RequiresPermissions("hrm:di:dietJudge:view")
	@RequestMapping(value = {"list", ""})
	public String list(DietJudge dietJudge, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DietJudge> page = dietJudgeService.findPage(new Page<DietJudge>(request, response), dietJudge); 
		model.addAttribute("page", page);
		return "modules/hrm/di/dietJudgeList";
	}

	@RequiresPermissions("hrm:di:dietJudge:view")
	@RequestMapping(value = "form")
	public String form(DietJudge dietJudge, Model model) {
		model.addAttribute("dietJudge", dietJudge);
		return "modules/hrm/di/dietJudgeForm";
	}

	@RequiresPermissions("hrm:di:dietJudge:edit")
	@RequestMapping(value = "save")
	public String save(DietJudge dietJudge, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dietJudge)){
			return form(dietJudge, model);
		}
		dietJudgeService.save(dietJudge);
		addMessage(redirectAttributes, "保存日常菜谱评价成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/dietJudge/?repage";
	}
	
	@RequiresPermissions("hrm:di:dietJudge:edit")
	@RequestMapping(value = "delete")
	public String delete(DietJudge dietJudge, RedirectAttributes redirectAttributes) {
		dietJudgeService.delete(dietJudge);
		addMessage(redirectAttributes, "删除日常菜谱评价成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/dietJudge/?repage";
	}

    @RequiresPermissions("hrm:di:dietJudge:view")
    @RequestMapping(value = "info")
    public String info(DietJudge dietJudge, Model model) {
        model.addAttribute("dietJudge", dietJudge);
        return "modules/hrm/di/dietJudgeInfo";
    }
}