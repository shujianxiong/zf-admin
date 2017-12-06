/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.sl;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.sl.SmsLink;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.service.sl.SmsLinkService;
import com.chinazhoufan.admin.modules.crm.vo.NotifyMemberVO;
import com.chinazhoufan.admin.modules.spm.entity.ss.SendSms;
import com.chinazhoufan.admin.modules.spm.service.ss.SendSmsService;

/**
 * 短信链接模块Controller
 * @author 舒剑雄
 * @version 2017-09-26
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/sl/smsLink")
public class SmsLinkController extends BaseController {

	@Autowired
	private SmsLinkService smsLinkService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SendSmsService sendSmsService;

	@ModelAttribute
	public SmsLink get(@RequestParam(required=false) String id) {
		SmsLink entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = smsLinkService.get(id);
		}
		if (entity == null){
			entity = new SmsLink();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = {"list", ""})
	public String list(SmsLink smsLink, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SmsLink> page = smsLinkService.findPage(new Page<SmsLink>(request, response), smsLink); 
		model.addAttribute("page", page);
		return "modules/crm/sl/smsLinkList";
	}

	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = "form")
	public String form(SmsLink smsLink, Model model) {
		if(smsLink.getActiveFlag() == null){
			smsLink.setActiveFlag(SmsLink.TRUE_FLAG);
		}
		model.addAttribute("smsLink", smsLink);
		return "modules/crm/sl/smsLinkForm";
	}

	@RequiresPermissions("crm:sl:smsLink:edit")
	@RequestMapping(value = "save")
	public String save(SmsLink smsLink, Model model, RedirectAttributes redirectAttributes) {
		smsLinkService.save(smsLink);
		addMessage(redirectAttributes, "保存短信链接模块成功");
		return "redirect:"+Global.getAdminPath()+"/crm/sl/smsLink/?repage";
	}
	
	@RequiresPermissions("crm:sl:smsLink:edit")
	@RequestMapping(value = "delete")
	public String delete(SmsLink smsLink, RedirectAttributes redirectAttributes) {
		smsLinkService.delete(smsLink);
		addMessage(redirectAttributes, "删除短信链接模块成功");
		return "redirect:"+Global.getAdminPath()+"/crm/sl/smsLink/?repage";
	}

    @RequiresPermissions("crm:sl:smsLink:view")
    @RequestMapping(value = "info")
    public String info(SmsLink smsLink, Model model) {
        model.addAttribute("smsLink", smsLink);
        return "modules/crm/sl/smsLinkInfo";
    }
	@RequiresPermissions("crm:sl:smsLink:edit")
	@RequestMapping(value = "toSend")
	public String toSend(SmsLink smsLink, Model model) {
		model.addAttribute("smsLink", smsLink);
		return "modules/crm/sl/smsSendForm";
	}
	@RequiresPermissions("crm:sl:smsLink:edit")
	@RequestMapping(value = "send")
	public String send(SmsLink smsLink, Model model, RedirectAttributes redirectAttributes) {
		smsLinkService.send(smsLink);
		addMessage(redirectAttributes, "短信发送成功");
		return "redirect:"+Global.getAdminPath()+"/crm/sl/smsLink/?repage";
	}
	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = "select")
	public String select(Member member, String pageKey, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), member);
		model.addAttribute("page", page);
		model.addAttribute("pageKey", pageKey);
		model.addAttribute("member", member);
		return "modules/crm/sl/memberSelect";
	}
	@RequestMapping(value = "memberSelect")
	public String notifySelect(NotifyMemberVO notifyMemberVO, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), notifyMemberVO);
		model.addAttribute("page", page);
		return "modules/crm/sl/memberSelect";
	}
	/**
	 * 更新短信模板配置启用状态
	 * @param id
	 * @param activeFlag  操作类型，（启用=1， 停用=0）
	 * @param model
	 * @return
	 */
	@RequiresPermissions("idx:sw:starsWear:edit")
	@RequestMapping(value = "updateUsable")
	public String updateStatus(String id, String activeFlag, RedirectAttributes redirectAttributes, Model model) {
		//获取操作类型（启用=1， 停用=0）
		String returnUrl = Global.getAdminPath()+"/crm/sl/smsLink/?repage";
		if(StringUtils.isBlank(id)){
			addMessage(redirectAttributes, "短信模板启用状态变更失败：未获取到状态信息");
			return returnUrl;

		}

		//获取原有的明星穿搭状态参数信息
		SmsLink smsLinkOld = smsLinkService.get(id);
		//获取明星穿搭对应的状态信息
		if("0".equals(activeFlag)){
			smsLinkOld.setActiveFlag(SmsLink.FALSE_FLAG);
		}else if("1".equals(activeFlag)){
			smsLinkOld.setActiveFlag(SmsLink.TRUE_FLAG);
		}
		smsLinkService.save(smsLinkOld);
		addMessage(redirectAttributes, "短信模板状态操作成功");
		return "redirect:"+returnUrl;
	}

	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = "sendMemberList")
	public String list(String userCodes,Member member, HttpServletRequest request, HttpServletResponse response, Model model) {
		String[] codes = userCodes.split(",");
		member.setSendUserCodes(codes);
		member.setSmsFlag("true");
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), member);
		model.addAttribute("page", page);
		model.addAttribute("userCodes", userCodes);
		return "modules/crm/sl/sendMemberList";
	}

	
	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = {"msgList"})
	public String list(String userCodes, SendSms sendSms, HttpServletRequest request, HttpServletResponse response, Model model) {
		String[] codes = userCodes.split(",");
		sendSms.setSendUserCodes(codes);
		sendSms.setDelFlag(SendSms.DEL_FLAG_NORMAL);
		Page<SendSms> page = sendSmsService.findPage(new Page<SendSms>(request, response), sendSms); 
		model.addAttribute("page", page);
		return "modules/crm/sl/sendSmsList";
	}
	
	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = {"smsList"})
	public String list( SendSms sendSms, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendSms> page = sendSmsService.findPage(new Page<SendSms>(request, response), sendSms); 
		model.addAttribute("page", page);
		return "modules/crm/sl/sendSmsList";
	}
}