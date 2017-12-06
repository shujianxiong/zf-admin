package com.chinazhoufan.admin.modules.data.web.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.data.service.member.MemberStatService;
import com.chinazhoufan.admin.modules.data.vo.member.MemberRegStat;

public class MemberStatController extends BaseController  {

	@Autowired
	private MemberStatService memberStatService;
	
	/**
	 * 柱状图名称修改为：会员注册量环比
	 * 查询历史六个月内会员注册量，最大值为6个月，根据月份分组形成集合数据，绘制柱状图
	 * @param request
	 * @param response
	 * @return
	 */
	public String statMemberRegisterBar(HttpServletRequest request, HttpServletResponse response) {
		List<MemberRegStat> list = memberStatService.statMemberRegisterBar();
		return JsonMapper.toJsonString(list);
	}
	
}
