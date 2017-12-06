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
import com.chinazhoufan.admin.modules.spm.entity.ep.Invitation;
import com.chinazhoufan.admin.modules.spm.service.ep.InvitationService;

/**
 * 邀请人Controller
 * @author 舒剑雄
 * @version 2017-08-31
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ep/invitation")
public class InvitationController extends BaseController {

	@Autowired
	private InvitationService invitationService;
	
	@ModelAttribute
	public Invitation get(@RequestParam(required=false) String id) {
		Invitation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = invitationService.get(id);
		}
		if (entity == null){
			entity = new Invitation();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ep:invitation:view")
	@RequestMapping(value = {"list", ""})
	public String list(Invitation invitation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Invitation> page = invitationService.findPage(new Page<Invitation>(request, response), invitation); 
		model.addAttribute("page", page);
		return "modules/spm/ep/invitationList";
	}

	@RequiresPermissions("spm:ep:invitation:view")
	@RequestMapping(value = "form")
	public String form(Invitation invitation, Model model) {
		model.addAttribute("invitation", invitation);
		return "modules/spm/ep/invitationForm";
	}

	@RequiresPermissions("spm:ep:invitation:edit")
	@RequestMapping(value = "save")
	public String save(Invitation invitation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, invitation)){
			return form(invitation, model);
		}
		invitationService.save(invitation);
		addMessage(redirectAttributes, "保存邀请人成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/invitation/?repage";
	}
	
	@RequiresPermissions("spm:ep:invitation:edit")
	@RequestMapping(value = "delete")
	public String delete(Invitation invitation, RedirectAttributes redirectAttributes) {
		invitationService.delete(invitation);
		addMessage(redirectAttributes, "删除邀请人成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/invitation/?repage";
	}

    @RequiresPermissions("spm:ep:invitation:view")
    @RequestMapping(value = "info")
    public String info(Invitation invitation, Model model) {
        model.addAttribute("invitation", invitation);
        return "modules/spm/ep/invitationInfo";
    }
}