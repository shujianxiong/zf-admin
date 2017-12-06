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
import com.chinazhoufan.admin.modules.spm.entity.pd.DiscountProperty;
import com.chinazhoufan.admin.modules.spm.service.pd.DiscountPropertyService;

/**
 * 产品筛选属性Controller
 * @author liut
 * @version 2017-07-04
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pd/discountProperty")
public class DiscountPropertyController extends BaseController {

	@Autowired
	private DiscountPropertyService discountPropertyService;
	
	@ModelAttribute
	public DiscountProperty get(@RequestParam(required=false) String id) {
		DiscountProperty entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = discountPropertyService.get(id);
		}
		if (entity == null){
			entity = new DiscountProperty();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pd:discountProperty:view")
	@RequestMapping(value = {"list", ""})
	public String list(DiscountProperty discountProperty, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DiscountProperty> page = discountPropertyService.findPage(new Page<DiscountProperty>(request, response), discountProperty); 
		model.addAttribute("page", page);
		return "modules/spm/pd/discountPropertyList";
	}

	@RequiresPermissions("spm:pd:discountProperty:view")
	@RequestMapping(value = "form")
	public String form(DiscountProperty discountProperty, Model model) {
		model.addAttribute("discountProperty", discountProperty);
		return "modules/spm/pd/discountPropertyForm";
	}

	@RequiresPermissions("spm:pd:discountProperty:edit")
	@RequestMapping(value = "save")
	public String save(DiscountProperty discountProperty, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, discountProperty)){
			return form(discountProperty, model);
		}
		discountPropertyService.save(discountProperty);
		addMessage(redirectAttributes, "保存产品筛选属性记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pd/discountProperty/?repage";
	}
	
	@RequiresPermissions("spm:pd:discountProperty:edit")
	@RequestMapping(value = "delete")
	public String delete(DiscountProperty discountProperty, RedirectAttributes redirectAttributes) {
		discountPropertyService.delete(discountProperty);
		addMessage(redirectAttributes, "删除产品筛选属性记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pd/discountProperty/?repage";
	}

    @RequiresPermissions("spm:pd:discountProperty:view")
    @RequestMapping(value = "info")
    public String info(DiscountProperty discountProperty, Model model) {
        model.addAttribute("discountProperty", discountProperty);
        return "modules/spm/pd/discountPropertyInfo";
    }
}