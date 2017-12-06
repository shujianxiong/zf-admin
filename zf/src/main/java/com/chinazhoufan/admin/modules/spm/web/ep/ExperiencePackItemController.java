/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ep;

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
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackItemService;

/**
 * 体验包体验记录Controller
 * @author 舒剑雄
 * @version 2017-08-31
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ep/experiencePackItem")
public class ExperiencePackItemController extends BaseController {

	@Autowired
	private ExperiencePackItemService experiencePackItemService;
	
	@ModelAttribute
	public ExperiencePackItem get(@RequestParam(required=false) String id) {
		ExperiencePackItem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = experiencePackItemService.get(id);
		}
		if (entity == null){
			entity = new ExperiencePackItem();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ep:experiencePackItem:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExperiencePackItem experiencePackItem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExperiencePackItem> page = experiencePackItemService.findPage(new Page<ExperiencePackItem>(request, response), experiencePackItem); 
		model.addAttribute("page", page);
		return "modules/spm/ep/experiencePackItemList";
	}

	@RequiresPermissions("spm:ep:experiencePackItem:view")
	@RequestMapping(value = "form")
	public String form(ExperiencePackItem experiencePackItem, Model model) {
		model.addAttribute("experiencePackItem", experiencePackItem);
		return "modules/spm/ep/experiencePackItemForm";
	}

	@RequiresPermissions("spm:ep:experiencePackItem:edit")
	@RequestMapping(value = "save")
	public String save(ExperiencePackItem experiencePackItem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, experiencePackItem)){
			return form(experiencePackItem, model);
		}
		experiencePackItemService.save(experiencePackItem);
		addMessage(redirectAttributes, "保存体验包体验记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/experiencePackItem/?repage";
	}
	
	@RequiresPermissions("spm:ep:experiencePackItem:edit")
	@RequestMapping(value = "delete")
	public String delete(ExperiencePackItem experiencePackItem, RedirectAttributes redirectAttributes) {
		experiencePackItemService.delete(experiencePackItem);
		addMessage(redirectAttributes, "删除体验包体验记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/experiencePackItem/?repage";
	}

    @RequiresPermissions("spm:ep:experiencePackItem:view")
    @RequestMapping(value = "info")
    public String info(ExperiencePackItem experiencePackItem, Model model) {
        model.addAttribute("experiencePackItem", experiencePackItem);
        return "modules/spm/ep/experiencePackItemInfo";
    }

    /**
     * 历史体验包
     * @param experienceOrder
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("spm:ep:experiencePackItem:view")
	@RequestMapping(value = {"historicalExperiencePackItem"})
	public String historicalExperiencePackItem(ExperiencePackItem experiencePackItem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExperiencePackItem> page = experiencePackItemService.findPage(new Page<ExperiencePackItem>(request, response), experiencePackItem); 
		model.addAttribute("page", page);
		return "modules/spm/ep/historicalExperiencePackItem";
	}
}