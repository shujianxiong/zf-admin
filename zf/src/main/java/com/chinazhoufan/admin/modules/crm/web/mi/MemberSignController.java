/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mi;

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
import com.chinazhoufan.admin.modules.crm.entity.mi.MemberSign;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberSignService;

/**
 * 会员签到Controller
 * @author liut
 * @version 2016-11-25
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mi/memberSign")
public class MemberSignController extends BaseController {

	@Autowired
	private MemberSignService memberSignService;
	
	@ModelAttribute
	public MemberSign get(@RequestParam(required=false) String id) {
		MemberSign entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = memberSignService.get(id);
		}
		if (entity == null){
			entity = new MemberSign();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mi:memberSign:view")
	@RequestMapping(value = {"list", ""})
	public String list(MemberSign memberSign, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MemberSign> page = memberSignService.findPage(new Page<MemberSign>(request, response), memberSign); 
		model.addAttribute("page", page);
		return "modules/crm/mi/memberSignList";
	}

	@RequiresPermissions("crm:mi:memberSign:view")
	@RequestMapping(value = "form")
	public String form(MemberSign memberSign, Model model) {
		model.addAttribute("memberSign", memberSign);
		return "modules/crm/mi/memberSignForm";
	}

	@RequiresPermissions("crm:mi:memberSign:edit")
	@RequestMapping(value = "save")
	public String save(MemberSign memberSign, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, memberSign)){
			return form(memberSign, model);
		}
		memberSignService.save(memberSign);
		addMessage(redirectAttributes, "保存会员签到成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/memberSign/?repage";
	}
	
	@RequiresPermissions("crm:mi:memberSign:edit")
	@RequestMapping(value = "delete")
	public String delete(MemberSign memberSign, RedirectAttributes redirectAttributes) {
		memberSignService.delete(memberSign);
		addMessage(redirectAttributes, "删除会员签到成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/memberSign/?repage";
	}

    @RequiresPermissions("crm:mi:memberSign:view")
    @RequestMapping(value = "info")
    public String info(MemberSign memberSign, Model model) {
        model.addAttribute("memberSign", memberSign);
        return "modules/crm/mi/memberSignInfo";
    }
}