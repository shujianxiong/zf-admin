/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.pj;

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
import com.chinazhoufan.admin.modules.bus.entity.pj.Summary;
import com.chinazhoufan.admin.modules.bus.service.pj.SummaryService;

/**
 * 评价摘要Controller
 * @author liut
 * @version 2017-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/pj/summary")
public class SummaryController extends BaseController {

	@Autowired
	private SummaryService summaryService;
	
	@ModelAttribute
	public Summary get(@RequestParam(required=false) String id) {
		Summary entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = summaryService.get(id);
		}
		if (entity == null){
			entity = new Summary();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:pj:summary:view")
	@RequestMapping(value = {"list", ""})
	public String list(Summary summary, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Summary> page = summaryService.findPage(new Page<Summary>(request, response), summary); 
		model.addAttribute("page", page);
		return "modules/bus/pj/summaryList";
	}

	@RequiresPermissions("bus:pj:summary:view")
	@RequestMapping(value = "form")
	public String form(Summary summary, Model model) {
		model.addAttribute("summary", summary);
		return "modules/bus/pj/summaryForm";
	}

	@RequiresPermissions("bus:pj:summary:edit")
	@RequestMapping(value = "save")
	public String save(Summary summary, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, summary)){
			return form(summary, model);
		}
		summaryService.save(summary);
		addMessage(redirectAttributes, "保存评价摘要成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/summary/?repage";
	}
	
	@RequiresPermissions("bus:pj:summary:edit")
	@RequestMapping(value = "delete")
	public String delete(Summary summary, RedirectAttributes redirectAttributes) {
		summaryService.delete(summary);
		addMessage(redirectAttributes, "删除评价摘要成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/summary/?repage";
	}

    @RequiresPermissions("bus:pj:summary:view")
    @RequestMapping(value = "info")
    public String info(Summary summary, Model model) {
        model.addAttribute("summary", summary);
        return "modules/bus/pj/summaryInfo";
    }
    
    
}