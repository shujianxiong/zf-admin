/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.pd;

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
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountPropvalue;
import com.chinazhoufan.admin.modules.spm.service.pd.DiscountPropvalueService;

/**
 * 产品筛选属性值表Controller
 * @author liut
 * @version 2017-07-04
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pd/discountPropvalue")
public class DiscountPropvalueController extends BaseController {

	@Autowired
	private DiscountPropvalueService discountPropvalueService;
	
	@ModelAttribute
	public DiscountPropvalue get(@RequestParam(required=false) String id) {
		DiscountPropvalue entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = discountPropvalueService.get(id);
		}
		if (entity == null){
			entity = new DiscountPropvalue();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pd:discountPropvalue:view")
	@RequestMapping(value = {"list", ""})
	public String list(DiscountPropvalue discountPropvalue, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DiscountPropvalue> page = discountPropvalueService.findPage(new Page<DiscountPropvalue>(request, response), discountPropvalue); 
		model.addAttribute("page", page);
		return "modules/spm/pd/discountPropvalueList";
	}

	@RequiresPermissions("spm:pd:discountPropvalue:view")
	@RequestMapping(value = "form")
	public String form(DiscountPropvalue discountPropvalue, Model model) {
		model.addAttribute("discountPropvalue", discountPropvalue);
		return "modules/spm/pd/discountPropvalueForm";
	}

	@RequiresPermissions("spm:pd:discountPropvalue:edit")
	@RequestMapping(value = "save")
	public String save(DiscountPropvalue discountPropvalue, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, discountPropvalue)){
			return form(discountPropvalue, model);
		}
		discountPropvalueService.save(discountPropvalue);
		addMessage(redirectAttributes, "保存产品筛选属性值记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pd/discountPropvalue/?repage";
	}
	
	@RequiresPermissions("spm:pd:discountPropvalue:edit")
	@RequestMapping(value = "delete")
	public String delete(DiscountPropvalue discountPropvalue, RedirectAttributes redirectAttributes) {
		discountPropvalueService.delete(discountPropvalue);
		addMessage(redirectAttributes, "删除产品筛选属性值记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pd/discountPropvalue/?repage";
	}

    @RequiresPermissions("spm:pd:discountPropvalue:view")
    @RequestMapping(value = "info")
    public String info(DiscountPropvalue discountPropvalue, Model model) {
        model.addAttribute("discountPropvalue", discountPropvalue);
        return "modules/spm/pd/discountPropvalueInfo";
    }
}