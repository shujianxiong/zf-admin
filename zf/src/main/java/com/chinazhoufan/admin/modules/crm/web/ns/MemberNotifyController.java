/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.ns;

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
import com.chinazhoufan.admin.modules.crm.entity.ns.MemberNotify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;

/**
 * 会员消息Controller
 * @author 张金俊
 * @version 2017-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/ns/memberNotify")
public class MemberNotifyController extends BaseController {

	@Autowired
	private MemberNotifyService memberNotifyService;
	
	@ModelAttribute
	public MemberNotify get(@RequestParam(required=false) String id) {
		MemberNotify entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = memberNotifyService.get(id);
		}
		if (entity == null){
			entity = new MemberNotify();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:ns:memberNotify:view")
	@RequestMapping(value = {"list", ""})
	public String list(MemberNotify memberNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MemberNotify> page = memberNotifyService.findPage(new Page<MemberNotify>(request, response), memberNotify); 
		model.addAttribute("page", page);
		return "modules/crm/ns/memberNotifyList";
	}

	@RequiresPermissions("crm:ns:memberNotify:view")
	@RequestMapping(value = "form")
	public String form(MemberNotify memberNotify, Model model) {
		model.addAttribute("memberNotify", memberNotify);
		return "modules/crm/ns/memberNotifyForm";
	}

	@RequiresPermissions("crm:ns:memberNotify:edit")
	@RequestMapping(value = "save")
	public String save(MemberNotify memberNotify, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, memberNotify)){
			return form(memberNotify, model);
		}
		memberNotifyService.save(memberNotify);
		addMessage(redirectAttributes, "保存会员消息成功");
		return "redirect:"+Global.getAdminPath()+"/crm/ns/memberNotify/?repage";
	}
	
	@RequiresPermissions("crm:ns:memberNotify:edit")
	@RequestMapping(value = "delete")
	public String delete(MemberNotify memberNotify, RedirectAttributes redirectAttributes) {
		memberNotifyService.delete(memberNotify);
		addMessage(redirectAttributes, "删除会员消息成功");
		return "redirect:"+Global.getAdminPath()+"/crm/ns/memberNotify/?repage";
	}

    @RequiresPermissions("crm:ns:memberNotify:view")
    @RequestMapping(value = "info")
    public String info(MemberNotify memberNotify, Model model) {
        model.addAttribute("memberNotify", memberNotify);
        return "modules/crm/ns/memberNotifyInfo";
    }
}