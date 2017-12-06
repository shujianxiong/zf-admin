/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ci;

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
import com.chinazhoufan.admin.modules.spm.entity.ci.CouponTemplate;
import com.chinazhoufan.admin.modules.spm.service.ci.CouponTemplateService;

/**
 * 优惠券模板Controller
 * @author 张金俊
 * @version 2016-12-02
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ci/couponTemplate")
public class CouponTemplateController extends BaseController {

	@Autowired
	private CouponTemplateService couponTemplateService;
	
	@ModelAttribute
	public CouponTemplate get(@RequestParam(required=false) String id) {
		CouponTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = couponTemplateService.get(id);
		}
		if (entity == null){
			entity = new CouponTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ci:couponTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(CouponTemplate couponTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CouponTemplate> page = couponTemplateService.findPage(new Page<CouponTemplate>(request, response), couponTemplate); 
		model.addAttribute("page", page);
		return "modules/spm/ci/couponTemplateList";
	}
	
	@RequiresPermissions("spm:ci:couponTemplate:view")
	@RequestMapping(value = "select")
	public String select(CouponTemplate couponTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CouponTemplate> page = couponTemplateService.selectPage(new Page<CouponTemplate>(request, response), couponTemplate); 
		model.addAttribute("page", page);
		return "modules/spm/ci/couponTemplateSelect";
	}

	@RequiresPermissions("spm:ci:couponTemplate:view")
	@RequestMapping(value = "form")
	public String form(CouponTemplate couponTemplate, Model model) {
		if(StringUtils.isBlank(couponTemplate.getId())) {
			couponTemplate.setCouponType(CouponTemplate.COUPONTYPE_MJ);
		}
		model.addAttribute("couponTemplate", couponTemplate);
		return "modules/spm/ci/couponTemplateForm";
	}

	@RequiresPermissions("spm:ci:couponTemplate:edit")
	@RequestMapping(value = "save")
	public String save(CouponTemplate couponTemplate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, couponTemplate)){
			return form(couponTemplate, model);
		}
		couponTemplateService.save(couponTemplate);
		addMessage(redirectAttributes, "保存优惠券模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ci/couponTemplate/?repage";
	}
	
	@RequiresPermissions("spm:ci:couponTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(CouponTemplate couponTemplate, RedirectAttributes redirectAttributes) {
		couponTemplateService.delete(couponTemplate);
		addMessage(redirectAttributes, "删除优惠券模板成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ci/couponTemplate/?repage";
	}

    @RequiresPermissions("spm:ci:couponTemplate:view")
    @RequestMapping(value = "info")
    public String info(CouponTemplate couponTemplate, Model model) {
        model.addAttribute("couponTemplate", couponTemplate);
        return "modules/spm/ci/couponTemplateInfo";
    }
    
    @RequiresPermissions("spm:ci:couponTemplate:edit")
    @RequestMapping(value = "generateCoupon")
    public String generateCoupon(String couponTemplateId, Integer num, HttpServletRequest request, HttpServletResponse response, Model model) {
    	CouponTemplate ct = new CouponTemplate(couponTemplateId);
    	if(num == null || num < 1 || num > 1000) {
    		addMessage(model, "生成失败：优惠券的单次生成数量不能少于1，且不能大于1000，请重新输入");
    		return list(ct, request, response, model);
    	}
    	ct = couponTemplateService.get(ct);
    	couponTemplateService.generateCoupon(ct, num);
    	addMessage(model, "优惠券已经成功生成");
    	ct = new CouponTemplate();
    	return list(ct, request, response, model);
    }
}