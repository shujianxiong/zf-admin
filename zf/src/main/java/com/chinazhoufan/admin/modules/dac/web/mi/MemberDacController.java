/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.dac.web.mi;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.utils.excel.ExportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.mi.MemberStat;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;

/**
 * 会员数据统计Controller
 * @author 张金俊
 * @version 2017-03-02
 */
@Controller
@RequestMapping(value = "${adminPath}/dac/mi/memberDac")
public class MemberDacController extends BaseController {

	@Autowired
	private MemberService memberService;
	
	@ModelAttribute
	public Member get(@RequestParam(required=false) String id) {
		Member entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = memberService.get(id);
		}
		if (entity == null){
			entity = new Member();
		}
		return entity;
	}

	/**
	 * 根据时间段统计查询指定日期内，每天注册总数
	 * @param member
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("dac:mi:memberDac:register")
	@RequestMapping(value = "statNewRegister")
	public String statNewRegister(Member member, HttpServletRequest request, HttpServletResponse response, Model model) {
		int registerNum = memberService.getRegisterNum(member);
		model.addAttribute("registerNum", registerNum);
		List<Member> list = memberService.statNewRegisterByTime(member);
		model.addAttribute("list", list);
		
		return "modules/dac/mi/memberRegister";
	}
	
	/**
	 * 绘制线状图
	 * @param member
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@ResponseBody
	@RequiresPermissions("dac:mi:memberDac:register")
	@RequestMapping(value = "drawNewRegister", method=RequestMethod.POST)
	public String drawNewRegister(Member member, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<MemberStat> list = memberService.drawNewRegister(member);
		return JsonMapper.toJsonString(list);
	}
	
	
	
	@RequiresPermissions("dac:mi:memberDac:register")
    @RequestMapping(value = "export", method=RequestMethod.POST)
	public String export(Member member, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "会员注册数据统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            List<Member> list = memberService.statNewRegisterByTime(member);
    		new ExportExcel("会员注册数据统计", Member.class).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出会员注册统计数据失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/dac/mi/memberDac/statNewRegister?repage";
	}
	
}