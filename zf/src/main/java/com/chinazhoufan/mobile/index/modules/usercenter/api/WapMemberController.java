/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.api;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 会员列表Controller
 * @author 刘晓东
 * @version 2015-11-03
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/usercenter")
public class WapMemberController extends BaseController {

	@Autowired
	private MemberService wapMemberService;
	
	/**
	 * 会员基本信息数据接口
	 * @param memberId
	 * @param modeType
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/member/{memberId}/{modeType}" , method = RequestMethod.GET)
	public @ResponseBody
	String getMember(@PathVariable("memberId")String memberId, @PathVariable("modeType")Integer modeType){
		Echos echos = null;
		try {
			if (!(modeType == 1 || modeType == 2)) {
				echos= new Echos(Constants.PARAMETER_ERROR, "请求参数出错");
			}else {
				Member member = wapMemberService.getByModeType(memberId,modeType);
				if (member == null | StringUtils.isBlank(member.getId())) {
					echos = new Echos(Constants.NO_MESSAGE);
				}else {
					echos = new Echos(Constants.SUCCESS, member);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 会员基本信息修改接口
	 * @param member
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "save")
	public String save(Member member, HttpServletResponse response, Model model) {
		Echos echos = null ;
		if (!beanValidator(model, member)){
			echos = new Echos(Constants.PARAMETER_ERROR,"参数出错");
		}
		try {
			wapMemberService.save(member);
			echos = new Echos(Constants.SUCCESS,"更新成功");
		} catch (Exception e) {
			echos = new Echos(Constants.ERROR, "更新失败");
			e.printStackTrace();
		}
		return renderString(response, JsonMapper.toJsonString(echos));
	}
	
}