/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.utils.Md5;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.spm.entity.ic.InviteCode;
import com.chinazhoufan.admin.modules.spm.service.ic.InviteCodeService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * web前端用户注册和登录Controller
 * @author 贾斌
 * @version 2015-12-22
 */
/**
 * 会员登录成功或注册成功时，判断session中是否有openid。
 * 有的话，清空openid与所有会员的绑定，并绑定当前会员，
 * 同时设置openid到session里的memberDTO中
 * @author 张金俊
 * @version 2016-06-01
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class WapLoginController extends BaseController {

	@Autowired
	private MemberService wapMemberService;
	@Autowired
	private InviteCodeService inviteCodeService;
	
	/**
	 * 跳转到用户注册一级页面
	 * @return
	 */
	@RequestMapping(value = "smsValidate")
	public String smsValidate() {
		
		return "mobile/wechat/loginRegist/regist";
	}
	
	/**
	 * 跳转到用户注册一级页面（推荐注册页面）
	 * @return
	 */
	@RequestMapping(value = "inviteValidate")
	public String inviteValidate(String openid, HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("openid", openid);
		return "mobile/wechat/loginRegist/registInviteCode";
	}
	
	/**
	 * 跳转到登录页面
	 * @return
	 */
	@RequestMapping(value = "login")
	public String login() {
		return "mobile/wechat/loginRegist/login";
	}
	
	/**
	 * 跳转到注册二级页面
	 * @param phone 电话号码
	 * @param smsCode 验证码
	 * @return
	 */
	@RequestMapping(value = "regist")
	public String regist(String phone,String smsCode,Model model) {
		model.addAttribute("phone",phone);
		//参数检测
		if(StringUtils.isBlank(phone)||StringUtils.isBlank(smsCode)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/loginRegist/regist";
		}
		//暂时使用123456作为短信验证码
		String sms="123456";
		if(!smsCode.equals(sms)){
			model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
			return "mobile/wechat/loginRegist/regist";
		}
		//查询手机号是否已经注册
		Member userCode= wapMemberService.getByUserCodeOpenId(phone);
		if(userCode != null){
			model.addAttribute("echos",new Echos(Constants.USERCODE_EXIST));
			return "mobile/wechat/loginRegist/login";
		}
		return "mobile/wechat/loginRegist/registUserName";
	}
	
	/**
	 * 跳转到注册二级页面（邀请注册）
	 * @param openid		微信openid
	 * @param usercode 		注册账号（电话号码）
	 * @param smsCode		短信验证码
	 * @param inviteCode	邀请码
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "registByInviteCode")
	public String registByInviteCode(String openid, String usercode, String smsCode, String inviteCode, Model model) {
		
		model.addAttribute("openid",usercode);
		//参数检测
		if(StringUtils.isBlank(usercode)||StringUtils.isBlank(smsCode)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/loginRegist/regist";
		}
		//暂时使用123456作为短信验证码
		String sms="123456";
		if(!smsCode.equals(sms)){
			model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
			return "mobile/wechat/loginRegist/regist";
		}
		//查询手机号是否已经注册
		Member userCode= wapMemberService.getByUserCodeOpenId(usercode);
		if(userCode != null){
			model.addAttribute("echos",new Echos(Constants.USERCODE_EXIST));
			return "mobile/wechat/loginRegist/login";
		}
		return "mobile/wechat/loginRegist/registUserName";
	}
	
	/**
	 * 登录验证
	 * @param userCode 账号
	 * @param password 密码
	 * @return
	 */
	@RequestMapping(value = "doLogin")
	public String doLogin(String userCode, String password, String requestUri, Model model, HttpServletRequest request, HttpServletResponse response) {
		//参数检测
		if(StringUtils.isBlank(userCode)||StringUtils.isBlank(password)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/loginRegist/login";
		}
		Member member = wapMemberService.getByUserCodePassWord(userCode, Md5.toMd5(Md5.toMd5(password)));
		if(member==null){
			//帐号密码错误
			model.addAttribute("userCode", userCode);
			model.addAttribute("password", password);
			model.addAttribute("echos",new Echos(Constants.USERCODE_ERROR));
			return "mobile/wechat/loginRegist/login";
		}else{
			//判断会员账户的账号状态 1正常 2 冻结 3 限制
			if(member.getUsercodeStatus().equals(Member.USERCODESTATUS_FREEZE)){
				model.addAttribute("echos",new Echos(Constants.ACCOUNTS_FREEZE));
				return "mobile/wechat/loginRegist/login";
			}
			if(member.getUsercodeStatus().equals(Member.USERCODESTATUS_LIMIT)){
				model.addAttribute("echos",new Echos(Constants.ACCOUNTS_LIMIT));
				return "mobile/wechat/loginRegist/login";
			}

			// 登录成功，session中有openid，且与当前登录会员的openid不一致：
			//	清空openid与所有会员的绑定，并绑定当前会员，同时设置openid到memberDTO，并保存memberDTO到session中
			// 登录成功，session中没有openid，或openid与当前登录会员的openid一致：
			//	保存用户DTO对象到Session,维持登录状态
			String openidSession = (String)request.getSession().getAttribute("openid");
			if(!StringUtils.isEmpty(openidSession) && !openidSession.equals(member.getWechatOpenid())){
				// 清空openid与所有会员的绑定，并绑定当前会员
				wapMemberService.updateMemberWechatOpenid(member.getId(), openidSession);
				// 同时设置openid到memberDTO，并保存memberDTO到session中
				MemberDTO memberDTO=new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setUsercode(member.getUsercode());
				memberDTO.setWechatOpenid(openidSession);
				request.getSession().setAttribute("member", memberDTO);
			}else {
				MemberDTO memberDTO=new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setUsercode(member.getUsercode());
				memberDTO.setWechatOpenid(member.getWechatOpenid());
				request.getSession().setAttribute("member", memberDTO);
			}
			if(!StringUtils.isBlank(requestUri)){
				return "redirect:"+requestUri.replace("/zf", "");//临时替换项目名
			}
		}
		return "redirect:"+Global.getMobileIndexPath()+"/index";
	}
	
	/**
	 * 短信验证
	 * @param phone 手机号码
	 * @param smsCode 验证码
	 * @return
	 */
	@RequestMapping(value = "doSmsValidate")
	public String doSmsValidate(String phone,String smsCode,Model model) {
		return "redirect:"+Global.getMobileIndexPath()+"/regist";
	}
	
	
	
	/**
	 * 用户注册
	 * @param phone		手机号
	 * @param nickName	昵称
	 * @param pwd	新密码
	 * @param rePwd 确认密码
	 * @return
	 */
	@RequestMapping(value = "doRegist")
	public String doRegist(String phone, String nickName, String pwd, String rePwd, Model model, HttpServletRequest request) {
		try {
			model.addAttribute("phone",phone);
			//参数检测
			if(StringUtils.isBlank(phone)||StringUtils.isBlank(nickName)||StringUtils.isBlank(pwd)||StringUtils.isBlank(rePwd)){
				model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
				return "mobile/wechat/loginRegist/registUserName";
			}
			//检测密码是否数字和字母组合且不得低于六位
			if(!pwd.matches(Member.PASSWORD_REGULAR)){
				model.addAttribute("echos",new Echos(Constants.REPWD_LENGTH_ERROR));
				return "mobile/wechat/loginRegist/registUserName";
			}
			//格式检测
			if(!pwd.equals(rePwd)){
				model.addAttribute("echos",new Echos(Constants.REPWD_ERROR));
				return "mobile/wechat/loginRegist/registUserName";
			}
			//密码格式：长度6位，字母+数字
			
			
			Member members = new Member();
			members.setNickname(nickName);
			members.setUsercode(phone);
			members.setPassword(Md5.toMd5(Md5.toMd5(pwd)));
			
			//查询手机号是否已经注册
			Member userCode= wapMemberService.getByUserCodeOpenId(phone);
			if(userCode != null){
				model.addAttribute("echos",new Echos(Constants.USERCODE_EXIST));
				return "mobile/wechat/loginRegist/login";
			}
			
			wapMemberService.add(members, "");
			Member member = wapMemberService.getByUserCodePassWord(phone, members.getPassword());
			
			// 注册成功默认执行登录，保存用户DTO对象到Session,维持登录状态
			// 登录成功，session中有openid，且与当前登录会员的openid不一致：
			//	清空openid与所有会员的绑定，并绑定当前会员，同时设置openid到memberDTO，并保存memberDTO到session中
			// 登录成功，session中没有openid，或openid与当前登录会员的openid一致：
			//	保存用户DTO对象到Session,维持登录状态
			String openidSession = (String)request.getSession().getAttribute("openid");
			if(!StringUtils.isEmpty(openidSession) && !openidSession.equals(member.getWechatOpenid())){
				// 清空openid与所有会员的绑定，并绑定当前会员
				wapMemberService.updateMemberWechatOpenid(member.getId(), openidSession);
				// 同时设置openid到memberDTO，并保存memberDTO到session中
				MemberDTO memberDTO=new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setUsercode(member.getUsercode());
				memberDTO.setWechatOpenid(openidSession);
				request.getSession().setAttribute("member", memberDTO);
			}else {
				MemberDTO memberDTO=new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setUsercode(member.getUsercode());
				memberDTO.setWechatOpenid(member.getWechatOpenid());
				request.getSession().setAttribute("member", memberDTO);
			}
		} catch (Exception e) {
			model.addAttribute("echos",new Echos(Constants.MESSAGE));
			return "mobile/wechat/loginRegist/registUserName";
		}
		//注册成功跳转到首页
		return "redirect:"+Global.getMobileIndexPath()+"/index";
	}
	
	
	/**
	 * 邀请注册
	 * @param phone 手机号
	 * @param smsCode 短信验证码
	 * @param inviteCode 邀请码
	 * @param model 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "inviteRegist")
	public String inviteRegist(String phone,String smsCode,String inviteCode,Model model,HttpServletRequest request) {
		try {
			//参数检测
			if(StringUtils.isBlank(phone)||StringUtils.isBlank(inviteCode)||StringUtils.isBlank(smsCode)){
				model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
				return "mobile/wechat/loginRegist/registUserName";
			}
			//暂时使用123456作为短信验证码
			String sms="123456";
			if(!smsCode.equals(sms)){
				model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
				return "mobile/wechat/loginRegist/regist";
			}
			//检测邀请码是否存在且有效
			if(!inviteCodeService.isValid(inviteCode)){
				model.addAttribute("echos",new Echos(Constants.INVITECODE_ERROR));
				return "mobile/wechat/loginRegist/registUserName";
			}
			
			//查询手机号是否已经注册
			Member memberExist= wapMemberService.getByUserCodeOpenId(phone);
			if(memberExist != null){
				model.addAttribute("echos",new Echos(Constants.USERCODE_EXIST));
				return "mobile/wechat/loginRegist/login";
			}
			
			Member newMember = new Member();
			newMember.setUsercode(phone);
			newMember.setPassword(Md5.toMd5(Md5.toMd5("123456"))); //密码设置成123456
			wapMemberService.add(newMember, "");
			//生成邀请码使用记录
			InviteCode inviteCodeObj =inviteCodeService.getByInviteCode(inviteCode); 
			inviteCodeObj.setUseMember(newMember);
			inviteCodeService.save(inviteCodeObj);
			
			Member member = wapMemberService.getByUserCodePassWord(phone, newMember.getPassword());
			//注册成功默认执行登录，保存用户DTO对象到Session,维持登录状态
			// 登录成功，session中有openid，且与当前登录会员的openid不一致：
			//	清空openid与所有会员的绑定，并绑定当前会员，同时设置openid到memberDTO，并保存memberDTO到session中
			// 登录成功，session中没有openid，或openid与当前登录会员的openid一致：
			//	保存用户DTO对象到Session,维持登录状态
			String openidSession = (String)request.getSession().getAttribute("openid");
			if(!StringUtils.isEmpty(openidSession) && !openidSession.equals(member.getWechatOpenid())){
				// 清空openid与所有会员的绑定，并绑定当前会员
				wapMemberService.updateMemberWechatOpenid(member.getId(), openidSession);
				// 同时设置openid到memberDTO，并保存memberDTO到session中
				MemberDTO memberDTO=new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setUsercode(member.getUsercode());
				memberDTO.setWechatOpenid(openidSession);
				request.getSession().setAttribute("member", memberDTO);
			}else {
				MemberDTO memberDTO=new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setUsercode(member.getUsercode());
				memberDTO.setWechatOpenid(member.getWechatOpenid());
				request.getSession().setAttribute("member", memberDTO);
			}
		} catch (Exception e) {
			model.addAttribute("echos",new Echos(Constants.MESSAGE));
			return "mobile/wechat/loginRegist/registUserName";
		}
		//注册成功跳转到首页
		return "redirect:"+Global.getMobileIndexPath()+"/index";
	}
	
	
	/********找回密码******/
	/**
	 * 跳转到用户找回密码页面
	 * @return
	 */
	@RequestMapping(value = "smsBackPassword")
	public String smsBackPassword() {
		
		return "mobile/wechat/loginRegist/getBackPassword";
	}
	
	/**
	 * 跳转到找回密码二级页面
	 * @param phone 手机号码
	 * @param smsCode	验证码
	 * @return
	 */
	@RequestMapping(value = "getBackPassword")
	public String getBackPassword(String phone,String smsCode,Model model) {
		model.addAttribute("phone",phone);
		//参数检测
		if(StringUtils.isBlank(phone)||StringUtils.isBlank(smsCode)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/loginRegist/getBackPassword";
		}
		//暂时使用123456作为短信验证码
		String sms="123456";
		if(!smsCode.equals(sms)){
			model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
			return "mobile/wechat/loginRegist/getBackPassword";
		}
		//查询手机号是否已经注册
		Member userCode= wapMemberService.getByUserCodeOpenId(phone);
		if(userCode == null){
			model.addAttribute("echos",new Echos(Constants.USERCODE_LENGTH_NULL));
			return "mobile/wechat/loginRegist/regist";
		}
		return "mobile/wechat/loginRegist/resetPassword";
	}
	
	
	/**
	 * 找回密码，修改
	 * @param phone 手机号
	 * @param pwd	新密码
	 * @param repwd	确认密码
	 * @return
	 */
	@RequestMapping(value = "doResetPassword")
	public String doResetPassword(String phone,String pwd,String rePwd,Model model,HttpServletRequest request) {
		try {
			model.addAttribute("phone",phone);
			//参数检测
			if(StringUtils.isBlank(phone)||StringUtils.isBlank(pwd)||StringUtils.isBlank(rePwd)){
				model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
				return "mobile/wechat/loginRegist/resetPassword";
			}
			//检测密码是否数字和字母组合且不得低于六位
			if(!pwd.matches(Member.PASSWORD_REGULAR)){
				model.addAttribute("echos",new Echos(Constants.REPWD_LENGTH_ERROR));
				return "mobile/wechat/loginRegist/resetPassword";
			}
			//格式检测
			if(!pwd.equals(rePwd)){
				model.addAttribute("echos",new Echos(Constants.REPWD_ERROR));
				return "mobile/wechat/loginRegist/resetPassword";
			}
			//密码格式：长度6位，字母+数字
			
			
			Member members= wapMemberService.getByUserCodeOpenId(phone);
			members.setPassword(Md5.toMd5(Md5.toMd5(pwd)));
			wapMemberService.save(members);
			
		} catch (Exception e) {
			model.addAttribute("echos",new Echos(Constants.MESSAGE));
			return "mobile/wechat/loginRegist/getBackPassword";
		}
		//修改成功跳转到登录页面验证登录
		model.addAttribute("echos",new Echos(Constants.EDIT_PASSWORD_SUCCESS));
		return "mobile/wechat/loginRegist/login";
	}
	
	
}