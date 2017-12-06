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
import com.chinazhoufan.admin.modules.spm.entity.ep.InvitationDetail;
import com.chinazhoufan.admin.modules.spm.service.ep.InvitationDetailService;

/**
 * 邀请人记录Controller
 * @author 舒剑雄
 * @version 2017-09-04
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ep/invitationDetail")
public class InvitationDetailController extends BaseController {

	@Autowired
	private InvitationDetailService invitationDetailService;
	
	@ModelAttribute
	public InvitationDetail get(@RequestParam(required=false) String id) {
		InvitationDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = invitationDetailService.get(id);
		}
		if (entity == null){
			entity = new InvitationDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ep:invitationDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(InvitationDetail invitationDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InvitationDetail> page = invitationDetailService.findPage(new Page<InvitationDetail>(request, response), invitationDetail); 
		model.addAttribute("page", page);
		return "modules/spm/ep/invitationDetailList";
	}

	@RequiresPermissions("spm:ep:invitationDetail:view")
	@RequestMapping(value = "form")
	public String form(InvitationDetail invitationDetail, Model model) {
		model.addAttribute("invitationDetail", invitationDetail);
		return "modules/spm/ep/invitationDetailForm";
	}

	@RequiresPermissions("spm:ep:invitationDetail:edit")
	@RequestMapping(value = "save")
	public String save(InvitationDetail invitationDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, invitationDetail)){
			return form(invitationDetail, model);
		}
		invitationDetailService.save(invitationDetail);
		addMessage(redirectAttributes, "保存邀请人记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/invitationDetail/?repage";
	}
	
	@RequiresPermissions("spm:ep:invitationDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(InvitationDetail invitationDetail, RedirectAttributes redirectAttributes) {
		invitationDetailService.delete(invitationDetail);
		addMessage(redirectAttributes, "删除邀请人记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ep/invitationDetail/?repage";
	}

    @RequiresPermissions("spm:ep:invitationDetail:view")
    @RequestMapping(value = "info")
    public String info(InvitationDetail invitationDetail, Model model) {
        model.addAttribute("invitationDetail", invitationDetail);
        return "modules/spm/ep/invitationDetailInfo";
    }
}