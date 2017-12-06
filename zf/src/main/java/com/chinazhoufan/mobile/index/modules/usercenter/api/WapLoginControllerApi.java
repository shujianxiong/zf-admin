/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.utils.Md5;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * web前端用户注册和登录Controller
 * @author 贾斌
 * @version 2015-12-22
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class WapLoginControllerApi extends BaseController {

	@Autowired
	private MemberService wapMemberService;
	
	/**
	 * 获取短信验证码
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/login/getsms/{phone}", method = {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String getSmsCode(@PathVariable("phone")String phone){
		if(StringUtils.isBlank(phone)){
			return JsonMapper.toJsonString(new Echos(Constants.PARAMETER_ISNULL));
		}
		//后期生成验证码发送消息
 		return JsonMapper.toJsonString(new Echos(Constants.SUCCESS,"123456"));
	}
	
	/**
	 * 快捷登录
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/fastLogin", method = {RequestMethod.POST})
	public @ResponseBody String fastLogin(String userCode,String pwd,HttpServletRequest request){
 		//参数检测
		if(StringUtils.isBlank(userCode)||StringUtils.isBlank(pwd)){
			return JsonMapper.toJsonString(new Echos(Constants.PARAMETER_ISNULL));
		}
		Member member = wapMemberService.getByUserCodePassWord(userCode, Md5.toMd5(Md5.toMd5(pwd)));
		if(member==null){
			//帐号密码错误
			return JsonMapper.toJsonString(new Echos(Constants.USERCODE_ERROR));
		}else{
			//登录成功，保存用户DTO对象到Session,维持登录状态
			MemberDTO memberDTO=new MemberDTO();
			memberDTO.setId(member.getId());
			memberDTO.setUsercode(member.getUsercode());
			memberDTO.setWechatOpenid(member.getWechatOpenid());
			request.getSession().setAttribute("member", memberDTO);
			return JsonMapper.toJsonString(new Echos(Constants.SUCCESS));
		}
	}
}