/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.wcpUsercenter.web.point;


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
 * 会员积分账户流水详情Controller
 * @author 刘晓东
 * @version 2015-12-15
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapPointController extends BaseController {

	@Autowired
	private MemberService wapMemberService;
	
	/**
	 * 查看我的积分账户
	 * @return
	 */
	@RequestMapping(value = "/myPointList")
	public String myPointList(Model model,HttpServletRequest request){
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		Member member = wapMemberService.get(memberDTO.getId());
		model.addAttribute("member", member);
		return "mobile/wechat/wcpUsercenter/myPoint/myPoint";
	}

}