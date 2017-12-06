/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.bs;

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
import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import com.chinazhoufan.admin.modules.bus.service.bs.BreakdownStandardService;

/**
 * 货品定损标准Controller
 * @author liut
 * @version 2016-11-19
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/bs/breakdownStandard")
public class BreakdownStandardController extends BaseController {

	@Autowired
	private BreakdownStandardService breakdownStandardService;
	
	@ModelAttribute
	public BreakdownStandard get(@RequestParam(required=false) String id) {
		BreakdownStandard entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = breakdownStandardService.get(id);
		}
		if (entity == null){
			entity = new BreakdownStandard();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:bs:breakdownStandard:view")
	@RequestMapping(value = {"list", ""})
	public String list(BreakdownStandard breakdownStandard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BreakdownStandard> page = breakdownStandardService.findPage(new Page<BreakdownStandard>(request, response), breakdownStandard); 
		model.addAttribute("page", page);
		return "modules/bus/bs/breakdownStandardList";
	}

	@RequiresPermissions("bus:bs:breakdownStandard:view")
	@RequestMapping(value = "form")
	public String form(BreakdownStandard breakdownStandard, Model model) {
		model.addAttribute("breakdownStandard", breakdownStandard);
		return "modules/bus/bs/breakdownStandardForm";
	}

	@RequiresPermissions("bus:bs:breakdownStandard:edit")
	@RequestMapping(value = "save")
	public String save(BreakdownStandard breakdownStandard, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, breakdownStandard)){
			return form(breakdownStandard, model);
		}
		breakdownStandardService.save(breakdownStandard);
		addMessage(redirectAttributes, "保存货品定损标准成功");
		return "redirect:"+Global.getAdminPath()+"/bus/bs/breakdownStandard/?repage";
	}
	
	@RequiresPermissions("bus:bs:breakdownStandard:edit")
	@RequestMapping(value = "delete")
	public String delete(BreakdownStandard breakdownStandard, RedirectAttributes redirectAttributes) {
		breakdownStandardService.delete(breakdownStandard);
		addMessage(redirectAttributes, "删除货品定损标准成功");
		return "redirect:"+Global.getAdminPath()+"/bus/bs/breakdownStandard/?repage";
	}

    @RequiresPermissions("bus:bs:breakdownStandard:view")
    @RequestMapping(value = "info")
    public String info(BreakdownStandard breakdownStandard, Model model) {
        model.addAttribute("breakdownStandard", breakdownStandard);
        return "modules/bus/bs/breakdownStandardInfo";
    }
}