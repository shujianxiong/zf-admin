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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudgeSummary;
import com.chinazhoufan.admin.modules.bus.service.pj.ProduceJudgeSummaryService;

/**
 * 产品评价摘要Controller
 * @author liut
 * @version 2017-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/pj/produceJudgeSummary")
public class ProduceJudgeSummaryController extends BaseController {

	@Autowired
	private ProduceJudgeSummaryService produceJudgeSummaryService;
	
	@ModelAttribute
	public ProduceJudgeSummary get(@RequestParam(required=false) String id) {
		ProduceJudgeSummary entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = produceJudgeSummaryService.get(id);
		}
		if (entity == null){
			entity = new ProduceJudgeSummary();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:pj:produceJudgeSummary:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProduceJudgeSummary produceJudgeSummary, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProduceJudgeSummary> page = produceJudgeSummaryService.findPage(new Page<ProduceJudgeSummary>(request, response), produceJudgeSummary); 
		model.addAttribute("page", page);
		return "modules/bus/pj/produceJudgeSummaryList";
	}

	@RequiresPermissions("bus:pj:produceJudgeSummary:view")
	@RequestMapping(value = "form")
	public String form(ProduceJudgeSummary produceJudgeSummary, Model model) {
		model.addAttribute("produceJudgeSummary", produceJudgeSummary);
		return "modules/bus/pj/produceJudgeSummaryForm";
	}

	@RequiresPermissions("bus:pj:produceJudgeSummary:edit")
	@RequestMapping(value = "save")
	public String save(ProduceJudgeSummary produceJudgeSummary, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, produceJudgeSummary)){
			return form(produceJudgeSummary, model);
		}
		produceJudgeSummaryService.save(produceJudgeSummary);
		addMessage(redirectAttributes, "保存产品评价摘要成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudgeSummary/?repage";
	}
	
	@RequiresPermissions("bus:pj:produceJudgeSummary:edit")
	@RequestMapping(value = "delete")
	public String delete(ProduceJudgeSummary produceJudgeSummary, RedirectAttributes redirectAttributes) {
		produceJudgeSummaryService.delete(produceJudgeSummary);
		addMessage(redirectAttributes, "删除产品评价摘要成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudgeSummary/?repage";
	}

    @RequiresPermissions("bus:pj:produceJudgeSummary:view")
    @RequestMapping(value = "info")
    public String info(ProduceJudgeSummary produceJudgeSummary, Model model) {
        model.addAttribute("produceJudgeSummary", produceJudgeSummary);
        return "modules/bus/pj/produceJudgeSummaryInfo";
    }
}