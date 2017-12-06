/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mi;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyProduceService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.crm.service.mb.BeansService;
import com.chinazhoufan.admin.modules.crm.service.mi.AddressService;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackItemService;
import com.chinazhoufan.admin.modules.spm.service.ep.InvitationDetailService;
import com.chinazhoufan.admin.modules.spm.service.ep.InvitationService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.vo.NotifyMemberVO;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 会员列表Controller
 * @author 贾斌
 * @version 2015-10-20
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mi/member")
public class MemberController extends BaseController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private BuyProduceService buyProduceService;
	@Autowired
	private ServiceApplyService serviceApplyService;
	@Autowired
	private InvitationService invitationService;
	@Autowired
	private InvitationDetailService invitationDetailService;
	@Autowired
	private ReturnProductService returnProductService;
	@Autowired
	private BeansService beansService;
	@Autowired
	private ExperiencePackItemService experiencePackItemService;

	
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
	
	@RequiresPermissions("crm:mi:member:view")
	@RequestMapping(value = {"list", ""})
	public String list(Member member, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), member); 
		model.addAttribute("page", page);
		return "modules/crm/mi/memberList";
	}

	@RequiresPermissions("crm:mi:member:view")
	@RequestMapping(value = "form")
	public String form(Member member, Model model) {
		model.addAttribute("member", member);
		return "modules/crm/mi/memberForm";
	}
	
	@RequiresPermissions("crm:mi:member:view")
	@RequestMapping(value = "info")
	public String info(Member member, Model model) {
		model.addAttribute("member", member);
		model.addAttribute("address", addressService.findDefaultByMember(member.getId())); //默认地址
		model.addAttribute("exTradeInfo", experienceOrderService.getMemberTradeInfo(member.getId())); //体验单交易信息
		model.addAttribute("buyTradeInfo", buyOrderService.getMemberTradeInfo(member.getId())); //购买单交易信息
		model.addAttribute("buyProduceNum", buyProduceService.getTotalNumByMember(member.getId())); //购买商品总数
		model.addAttribute("saCancel" ,serviceApplyService.countByApplyBy(member.getId(), ServiceApply.ADT_CANCEL)); //售后申请取消订单
		model.addAttribute("saAll" ,serviceApplyService.countByApplyBy(member.getId(), null)); //售后申请总数
		model.addAttribute("saRelife" ,serviceApplyService.countByApplyBy(member.getId(), ServiceApply.ADT_RELIEF));// 售后申请免责数
		model.addAttribute("exGift" ,invitationService.getByMember(member.getId()).getHistoryInviteder());// 体验包奖励数
		model.addAttribute("inviteExOrderNum" ,invitationDetailService.countByMember(member.getId(), BaseEntity.TRUE_FLAG));// 邀请体验下单数
		model.addAttribute("inviteNum", invitationDetailService.countByMember(member.getId(), null)); // 邀请总数
		model.addAttribute("lostNum", returnProductService.countByMemberAndBreakdownType(member.getId(), ReturnProduct.Dt_5)); // 货品遗失数
		model.addAttribute("slightDamageNum", returnProductService.countByMemberAndBreakdownType(member.getId(), ReturnProduct.Dt_1)); // 轻微损坏数
		model.addAttribute("upSlightDamageNum", returnProductService.countByMemberAndBreakdownType(member.getId(), ReturnProduct.Dt_2)
																+returnProductService.countByMemberAndBreakdownType(member.getId(), ReturnProduct.Dt_3)); // 轻微以上损坏数
		model.addAttribute("inviteBuyTradeInfo", buyOrderService.getMemberTradeInfo(invitationDetailService.getInviteMemberIds(member.getId()))); //购买单交易信息
		model.addAttribute("returnOverdueNum", experienceOrderService.countReturnOverDue(member.getId())); //购买单交易信息
		model.addAttribute("beans", beansService.getByMemberId(member.getId())); //魅力豆信息
		ExperiencePackItem experiencePackItem = experiencePackItemService.getByMember(member.getId());

		model.addAttribute("currentExPack", experiencePackItem==null?new ExperiencePack():experiencePackItem.getExperiencePack()); //体验包信息
		return "modules/crm/mi/memberInfo";
	}

    @RequiresPermissions("crm:mi:member:edit")
    @RequestMapping(value = "saveRemarks")
    @ResponseBody
    public String saveRemarks(String memberId, String remarks, @RequestParam(value = "blackwhiteRemark", required = false) String blackwhiteRemark,
                              @RequestParam(value = "arrearageRemark", required = false)String arrearageRemark){
	    try {
            Member member = memberService.get(memberId);
            member.setRemarks(StringUtils.isNotBlank(remarks)?remarks:member.getRemarks());
            member.setBlackwhiteRemark(StringUtils.isNotBlank(blackwhiteRemark)?blackwhiteRemark:member.getBlackwhiteRemark());
            member.setArrearageRemark(StringUtils.isNotBlank(arrearageRemark)?arrearageRemark:member.getArrearageRemark());
            memberService.save(member);
            return "{\"status\":"+"1"+"}";
        } catch (Exception e){
            return "{\"status\":"+"0"+"}";
        }
    }

	@RequiresPermissions("crm:mi:member:edit")
    @RequestMapping(value = "save")
	public String save(Member member, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, member)){
			return form(member, model);
		}
		memberService.save(member);
		addMessage(redirectAttributes, "保存会员列表成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/member/?repage";
	}
	
	@RequiresPermissions("crm:mi:member:edit")
	@RequestMapping(value = "delete")
	public String delete(Member member, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(member.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员信息！");
			return "error/400";
		}
		memberService.delete(member);
		addMessage(redirectAttributes, "删除会员列表成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/member/?repage";
	}
	
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> hmChannelSceneTreeData(@RequestParam(required = false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Map<String, Object> map =  Maps.newHashMap();
		map.put("id", "0");
		map.put("pId", "");
		map.put("name", "选择用户");
		map.put("isParent", true);
		List<Member> list = memberService.findList(new Member());
		for (Member e : list) {
			map =  Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", "0");
			map.put("name", e.getUsercode());
			mapList.add(map);
		}
		return mapList;
	}
	
	@RequestMapping(value = "select")
	public String select(Member member, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), member); 
		model.addAttribute("page", page);
		return "modules/crm/mi/memberSelect";
	}
	
	@RequestMapping(value = "notifySelect")
	public String notifySelect(NotifyMemberVO notifyMemberVO, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Member> page = memberService.findPage(new Page<Member>(request, response), notifyMemberVO); 
		model.addAttribute("page", page);
		return "modules/crm/mi/notifyMemberSelect";
	}
	
	/**
	 * 变更会员状态 启用或停用
	 * @param member
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("crm:mi:member:edit")
	@RequestMapping(value = "setMemberStatus")
	public String setMemberStatus(Member member, HttpServletRequest request, HttpServletResponse response, Model model){
		try {
			Member memberOld = memberService.get(member.getId());
			memberService.setMemberStatus(memberOld);
			addMessage(model, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败！");
		}
		return list(member, request, response, model);
	}
	
	/**
	 * 变更账号状态 1_正常，2_冻结，3_限制下单
	 * @param member
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("crm:mi:member:edit")
	@RequestMapping(value = "setUsercodeStatus")
	public String setUsercodeStatus(Member member,String status, HttpServletRequest request, HttpServletResponse response, Model model){
		try {
			Member memberOld = memberService.get(member.getId());
			memberService.setUsercodeStatus(memberOld,status);
			addMessage(model, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败！");
		}
		return list(member, request, response, model);
	}
	
	/**
	 * 设置黑白名单状态
	 * @param member
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("crm:mi:member:edit")
	@RequestMapping(value = "setBlackwhiteStatus")
	public String setBlackwhiteStatus(Member member,String status, HttpServletRequest request, HttpServletResponse response, Model model){
		try {
			Member memberOld = memberService.get(member.getId());
			memberService.setBlackwhiteStatus(memberOld,status);
			addMessage(model, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败！");
		}
		return list(member, request, response, model);
	}
	
	
}