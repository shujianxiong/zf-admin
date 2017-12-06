/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.wcpUsercenter.web.InviteCode;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.spm.entity.ic.InviteCode;
import com.chinazhoufan.admin.modules.spm.service.ic.InviteCodeService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 会员邀请码表Controller
 * @author 刘晓东
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapInviteCodeController extends BaseController {

	public static final String CODE_LIMITNUM_MEMBER = "inviteCodeLimitNumMember";
	@Autowired
	private InviteCodeService inviteCodeService;
	@Autowired
	private MemberService wapMemberService;
	
	/**
	 * 查看我的邀请码
	 * @return
	 */
	@RequestMapping(value = "/myInviteList")
	public String myInviteList(Model model, HttpServletRequest request){
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		InviteCode inviteCode = new InviteCode();
		inviteCode.setCreaterId(memberDTO.getId());
		List<InviteCode> list = inviteCodeService.findMemberInviteCodeList(inviteCode);
		model.addAttribute("list", list);
		return "mobile/wechat/wcpUsercenter/myInvite/myInvite";
	}
	
	/**
	 * 跳转到继续邀请页
	 * @return
	 */
	@RequestMapping(value = "/continueInvite")
	public String continueInvite(@RequestParam(value="activityId",required=true)String activityId, HttpServletRequest request,Model model){
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		Integer codeLimitnumMember = new Integer(ConfigUtils.getConfig(CODE_LIMITNUM_MEMBER).getConfigValue()); //会员生成邀请码上限
		Integer inviteCodeExist = inviteCodeService.getCountByCreaterAndActivity(memberDTO.getId(), activityId); //查询当前会员已生成的邀请码数量
		if (inviteCodeExist < codeLimitnumMember) {
			return this.toCreateInviteCode(activityId, request, model); //跳转到邀请码生成界面
		}else {
			return this.myInviteList(model, request);
		}
	}
	/**
	 * 跳转到邀请码生成页
	 * @param activityId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toCreateInviteCode")
	public String toCreateInviteCode(@RequestParam(value="activityId",required=true)String activityId, HttpServletRequest request,Model model){
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		Integer codeLimitnumMember = new Integer(ConfigUtils.getConfig(CODE_LIMITNUM_MEMBER).getConfigValue()); //会员生成邀请码上限
		Integer inviteCodeExist = inviteCodeService.getCountByCreaterAndActivity(memberDTO.getId(), activityId); //查询当前会员已生成的邀请码数量
		model.addAttribute("createNum", codeLimitnumMember-inviteCodeExist); //当前邀请码最大生成数量
		model.addAttribute("activityId", activityId); //活动ID
		return "mobile/wechat/wcpUsercenter/myInvite/createInviteCode";
	}
	
	/**
	 * 生成邀请码
	 * @param activityId
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/createInviteCode",method = RequestMethod.POST)
	public String createInviteCode(@RequestParam(value="activityId",required=true)String activityId, @RequestParam(value = "createNum",required=true)Integer createNum, HttpServletRequest request,Model model){
		Echos echos = null;
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		Integer codeLimitnumMember = new Integer(ConfigUtils.getConfig(CODE_LIMITNUM_MEMBER).getConfigValue()); //会员生成邀请码上限
		Integer inviteCodeExist = inviteCodeService.getCountByCreaterAndActivity(memberDTO.getId(), activityId); //查询当前会员已生成的邀请码数量
		if (createNum > (codeLimitnumMember-inviteCodeExist)) {
			model.addAttribute("message", "最多只能生成"+(codeLimitnumMember-inviteCodeExist)+"已超过生成上限！");
			return toCreateInviteCode(activityId, request, model);
		}
		try {
			inviteCodeService.createInviteCode(activityId,memberDTO.getId(),createNum);
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
}