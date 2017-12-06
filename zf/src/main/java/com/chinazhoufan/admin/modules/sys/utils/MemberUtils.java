/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.utils;

import javax.servlet.http.HttpServletRequest;

import com.chinazhoufan.admin.common.utils.SpringContextHolder;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 会员工具类
 * @author 张金俊
 * @version 2016-01-11
 */
public class MemberUtils {

	private static MemberDao memberDao = SpringContextHolder.getBean(MemberDao.class);

	/**
	 * 根据会员ID获取会员对象
	 * @param memberId
	 * @return
	 */
	public static Member getMemberById(String memberId){
		return memberDao.get(memberId);
	}
	
	/**
	 * 获取当前登录会员DTO（传输对象）
	 * @return 返回当前登录会员的memberDTO，未登录则返回null
	 */
	public static MemberDTO getMemberDTO(HttpServletRequest request){
		// 如果没有登录，则返回实例化空的Member对象。 
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		return memberDTO;
	}
	
	/**
	 * 获取当前登录会员
	 * @return 返回当前登录会员member，未登录则返回null
	 */
	public static Member getMember(HttpServletRequest request){
		MemberDTO memberDTO = getMemberDTO(request);
		if (memberDTO != null){
			Member member = memberDao.get(memberDTO.getId());
			return member;
		}
		// 如果没有登录，则返回null。
		return null;
	}
	
	/**
	 * 清除会员session
	 * @param user
	 */
	public static void clearMember(HttpServletRequest request){
		request.getSession().setAttribute("member", null);
	}
	
}
