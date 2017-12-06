/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mb;

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
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansDetail;
import com.chinazhoufan.admin.modules.crm.service.mb.BeansDetailService;

/**
 * 会员魅力豆流水Controller
 * @author 张金俊
 * @version 2017-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mb/beansDetail")
public class BeansDetailController extends BaseController {

	@Autowired
	private BeansDetailService beansDetailService;
	
	@ModelAttribute
	public BeansDetail get(@RequestParam(required=false) String id) {
		BeansDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = beansDetailService.get(id);
		}
		if (entity == null){
			entity = new BeansDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mb:beansDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(BeansDetail beansDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BeansDetail> page = beansDetailService.findPage(new Page<BeansDetail>(request, response), beansDetail); 
		model.addAttribute("page", page);
		return "modules/crm/mb/beansDetailList";
	}


	@RequestMapping(value = "userInfolist")
	public String userInfolist(BeansDetail beansDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BeansDetail> page = beansDetailService.findPage(new Page<BeansDetail>(request, response), beansDetail);
		model.addAttribute("page", page);
		return "modules/crm/mb/beansDetailUserInfoList";
	}

	@RequiresPermissions("crm:mb:beansDetail:view")
	@RequestMapping(value = "form")
	public String form(BeansDetail beansDetail, Model model) {
		model.addAttribute("beansDetail", beansDetail);
		return "modules/crm/mb/beansDetailForm";
	}

	@RequiresPermissions("crm:mb:beansDetail:edit")
	@RequestMapping(value = "save")
	public String save(BeansDetail beansDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, beansDetail)){
			return form(beansDetail, model);
		}

		beansDetailService.save(beansDetail);
		addMessage(redirectAttributes, "保存会员魅力豆流水成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beansDetail/?repage";
	}
	
	@RequiresPermissions("crm:mb:beansDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(BeansDetail beansDetail, RedirectAttributes redirectAttributes) {
		beansDetailService.delete(beansDetail);
		addMessage(redirectAttributes, "删除会员魅力豆流水成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mb/beansDetail/?repage";
	}

    @RequiresPermissions("crm:mb:beansDetail:view")
    @RequestMapping(value = "info")
    public String info(BeansDetail beansDetail, Model model) {
        model.addAttribute("beansDetail", beansDetail);
        return "modules/crm/mb/beansDetailInfo";
    }
}