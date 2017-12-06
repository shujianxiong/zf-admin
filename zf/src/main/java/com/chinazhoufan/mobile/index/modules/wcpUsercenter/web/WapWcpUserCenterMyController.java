/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.wcpUsercenter.web;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 微信公众号调研用户个人中心Controller
 * @author 刘晓东
 * @version 2016-01-12
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapWcpUserCenterMyController extends BaseController {
	
	@Autowired
	MemberService wapMemberService;
	
	@RequestMapping(value = "/wcpUsercenter")
	public String wcpUsercenter(Model model, HttpServletRequest request){
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		Member member = wapMemberService.get(memberDTO.getId());
		model.addAttribute("member", member);
		return "mobile/wechat/wcpUsercenter/myCenter";
	}
}