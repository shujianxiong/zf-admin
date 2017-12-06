/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ic;

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
import com.chinazhoufan.admin.common.utils.ShareCodeUtil;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.entity.ic.InviteCode;
import com.chinazhoufan.admin.modules.spm.service.ic.InviteCodeService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 会员邀请码表Controller
 * @author 刘晓东
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ic/inviteCode")
public class InviteCodeController extends BaseController {

	public static final String CODE_LIMITNUM_USER = "inviteCodeLimitNumUser";
	public static final String CODE_LIMITNUM_MEMBER = "inviteCodeLimitNumMember";
	@Autowired
	private InviteCodeService inviteCodeService;
	
	@ModelAttribute
	public InviteCode get(@RequestParam(required=false) String id) {
		InviteCode entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = inviteCodeService.get(id);
		}
		if (entity == null){
			entity = new InviteCode();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ic:inviteCode:view")
	@RequestMapping(value = {"list", ""})
	public String list(InviteCode inviteCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		inviteCode.setCreaterId(UserUtils.getUser().getId());
		Page<InviteCode> page = inviteCodeService.findPage(new Page<InviteCode>(request, response), inviteCode); 
		model.addAttribute("page", page);
		return "modules/spm/ic/inviteCodeList";
	}

	@RequiresPermissions("spm:ic:inviteCode:view")
	@RequestMapping(value = {"listAll"})
	public String listAll(InviteCode inviteCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InviteCode> page = inviteCodeService.findPage(new Page<InviteCode>(request, response), inviteCode); 
		model.addAttribute("page", page);
		return "modules/spm/ic/inviteCodeListAll";
	}
	
	@RequiresPermissions("spm:ic:inviteCode:view")
	@RequestMapping(value = "form")
	public String form(InviteCode inviteCode, Model model) {
		if(StringUtils.isBlank(inviteCode.getId())) {
			inviteCode.setInviteCode(ShareCodeUtil.generateSerialCode(ShareCodeUtil.INVITE_CODE_LENGTH, ShareCodeUtil.INVITE_CODE_DATA_TYPE));
			inviteCode.setCreaterId(UserUtils.getUser().getId());//2016-05-24 该功能目前只支持后台工作人员使用，故直接默认为当前登录者
			inviteCode.setCreaterType(InviteCode.CREATERTYPE_USER);
		}
		model.addAttribute("inviteCode", inviteCode);
		return "modules/spm/ic/inviteCodeForm";
	}

	@RequiresPermissions("spm:ic:inviteCode:edit")
	@RequestMapping(value = "save")
	public String save(InviteCode inviteCode, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, inviteCode)){
			return form(inviteCode, model);
		}
		//默认为未使用状态，创建人类型为员工U
		if(StringUtils.isBlank(inviteCode.getId())) {
			inviteCode.setUseFlag(InviteCode.USEFLAG_NO);
		}
		
		Integer createdCount = inviteCodeService.getCountByCreaterAndActivity(inviteCode.getCreaterId(), inviteCode.getActivity().getId());
		Integer codeLimitnumUser = new Integer(ConfigUtils.getConfig(CODE_LIMITNUM_USER).getConfigValue());
		Integer codeLimitnumMember = new Integer(ConfigUtils.getConfig(CODE_LIMITNUM_MEMBER).getConfigValue());
		/** 
		 * 员工创建邀请码时，员工对该活动创建的邀请码数量未超过员工对应的系统参数设置
		 * 会员创建邀请码时，会员对该活动创建的邀请码数量未超过会员对应的系统参数设置
		 */
		if((InviteCode.CREATERTYPE_USER.equals(inviteCode.getCreaterType()) && createdCount < codeLimitnumUser)
				|| (InviteCode.CREATERTYPE_MEMBER.equals(inviteCode.getCreaterType()) && createdCount < codeLimitnumMember)){
			inviteCodeService.save(inviteCode);			
		}else {
			addMessage(redirectAttributes, "保存会员邀请码失败，您创建的邀请码已达到您可创建的数量限制");
			return "redirect:"+Global.getAdminPath()+"/spm/ic/inviteCode/?repage";
		}
		addMessage(redirectAttributes, "保存会员邀请码成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ic/inviteCode/?repage";
	}
	
	@RequiresPermissions("spm:ic:inviteCode:edit")
	@RequestMapping(value = "delete")
	public String delete(InviteCode inviteCode, RedirectAttributes redirectAttributes) {
		if(inviteCode == null || StringUtils.isBlank(inviteCode.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员邀请码信息！");
			return "error/400";
		}
		
		inviteCodeService.delete(inviteCode);
		addMessage(redirectAttributes, "删除会员邀请码成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ic/inviteCode/?repage";
	}
	
	@RequiresPermissions("spm:ic:inviteCode:view")
	@RequestMapping(value = "info")
	public String info(InviteCode inviteCode, HttpServletRequest request, HttpServletResponse response,  Model model) {
		if(inviteCode == null || StringUtils.isBlank(inviteCode.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的会员邀请码信息！");
			return "error/400";
		}
		
		model.addAttribute("inviteCode", inviteCode);
		return "modules/spm/ic/inviteCodeInfo";
	}
	
	/**
	 * 自动生成邀请码
	 * @param response
	 * @return
	 */
	@RequiresPermissions("spm:ic:inviteCode:view")
	@RequestMapping(value = "autoInviteCode")
	public String autoInviteCode(HttpServletResponse response) {
		String no = ShareCodeUtil.generateSerialCode(ShareCodeUtil.INVITE_CODE_LENGTH, ShareCodeUtil.INVITE_CODE_DATA_TYPE);
		return renderString(response, no, "text/html");
	}

	
	
	
}