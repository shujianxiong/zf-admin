/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.zi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
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
import com.chinazhoufan.admin.modules.spm.entity.zi.QrCode;
import com.chinazhoufan.admin.modules.spm.service.zi.QrCodeService;

/**
 * 二维码管理配置Controller
 * @author 舒剑雄
 * @version 2017-09-25
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/zi/qrCode")
public class QrCodeController extends BaseController {

	@Autowired
	private QrCodeService qrCodeService;
	@Autowired
	private MemberService memberService;
	
	@ModelAttribute
	public QrCode get(@RequestParam(required=false) String id) {
		QrCode entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = qrCodeService.get(id);
		}
		if (entity == null){
			entity = new QrCode();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:zi:qrCode:view")
	@RequestMapping(value = {"list", ""})
	public String list(QrCode qrCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QrCode> page = qrCodeService.findPage(new Page<QrCode>(request, response), qrCode); 
		model.addAttribute("page", page);
		return "modules/spm/zi/qrCodeList";
	}

	@RequiresPermissions("spm:zi:qrCode:view")
	@RequestMapping(value = "form")
	public String form(QrCode qrCode, Model model) {
		model.addAttribute("qrCode", qrCode);
		return "modules/spm/zi/qrCodeForm";
	}

	@RequiresPermissions("spm:zi:qrCode:edit")
	@RequestMapping(value = "save")
	public String save(QrCode qrCode, Model model, RedirectAttributes redirectAttributes) {
		try {
			qrCodeService.save(qrCode);
			addMessage(redirectAttributes, "保存二维码管理配置成功");
		}catch (Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/spm/zi/qrCode/?repage";
	}
	
	@RequiresPermissions("spm:zi:qrCode:edit")
	@RequestMapping(value = "delete")
	public String delete(QrCode qrCode, RedirectAttributes redirectAttributes) {
		qrCodeService.delete(qrCode);
		addMessage(redirectAttributes, "删除二维码管理配置成功");
		return "redirect:"+Global.getAdminPath()+"/spm/zi/qrCode/?repage";
	}

    @RequiresPermissions("spm:zi:qrCode:view")
    @RequestMapping(value = "info")
    public String info(QrCode qrCode, Model model) {
        model.addAttribute("qrCode", qrCode);
        return "modules/spm/zi/qrCodeInfo";
    }
	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = "registerMemberList")
	public String registerMemberList(String openIds, Member member, HttpServletRequest request, HttpServletResponse response, Model model) {
		String[] codes = openIds.split(",");
		member.setOpenIds(codes);
		member.setSmsFlag("true");
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), member);
		model.addAttribute("page", page);
		model.addAttribute("openids", openIds);
		return "modules/spm/zi/registMemberList";
	}
}