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
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudge;
import com.chinazhoufan.admin.modules.bus.service.pj.ProduceJudgeService;

/**
 * 产品评价Controller
 * @author liut
 * @version 2017-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/pj/produceJudge")
public class ProduceJudgeController extends BaseController {

	@Autowired
	private ProduceJudgeService produceJudgeService;
	
	@ModelAttribute
	public ProduceJudge get(@RequestParam(required=false) String id) {
		ProduceJudge entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = produceJudgeService.get(id);
		}
		if (entity == null){
			entity = new ProduceJudge();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:pj:produceJudge:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProduceJudge produceJudge, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProduceJudge> page = produceJudgeService.findPage(new Page<ProduceJudge>(request, response), produceJudge); 
		model.addAttribute("page", page);
		return "modules/bus/pj/produceJudgeList";
	}

	@RequiresPermissions("bus:pj:produceJudge:view")
	@RequestMapping(value = "form")
	public String form(ProduceJudge produceJudge, Model model) {
		model.addAttribute("produceJudge", produceJudge);
		return "modules/bus/pj/produceJudgeForm";
	}

	@RequiresPermissions("bus:pj:produceJudge:edit")
	@RequestMapping(value = "save")
	public String save(ProduceJudge produceJudge, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, produceJudge)){
			return form(produceJudge, model);
		}
		produceJudgeService.save(produceJudge);
		addMessage(redirectAttributes, "保存产品评价成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudge/?repage";
	}
	
	@RequiresPermissions("bus:pj:produceJudge:edit")
	@RequestMapping(value = "delete")
	public String delete(ProduceJudge produceJudge, RedirectAttributes redirectAttributes) {
		produceJudgeService.delete(produceJudge);
		addMessage(redirectAttributes, "删除产品评价成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudge/?repage";
	}

    @RequiresPermissions("bus:pj:produceJudge:view")
    @RequestMapping(value = "info")
    public String info(ProduceJudge produceJudge, Model model) {
        model.addAttribute("produceJudge", produceJudge);
        return "modules/bus/pj/produceJudgeInfo";
    }
    
    @RequiresPermissions("bus:pj:produceJudge:edit")
	@RequestMapping(value = "checkProduceJudge")
    public String checkProduceJudge(ProduceJudge produceJudge, RedirectAttributes redirectAttributes) {
    	if(ProduceJudge.CHECKSTATUS_TO_CHECK.equals(produceJudge.getCheckStatus())) {
    		addMessage(redirectAttributes, "审核失败：当前产品评价状态为待审核，请先判定审核结果!");
    		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudge/?repage";
    	}
    	ProduceJudge old = produceJudgeService.get(produceJudge);
    	if(!ProduceJudge.CHECKSTATUS_TO_CHECK.equals(old.getCheckStatus())) {
    		addMessage(redirectAttributes, "审核失败：当前产品评价状态已审核完成，请勿重复审核!");
    		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudge/?repage";
    	}
    	produceJudgeService.checkProduceJudge(produceJudge);
		addMessage(redirectAttributes, "操作成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudge/?repage";
    }
    
    
}