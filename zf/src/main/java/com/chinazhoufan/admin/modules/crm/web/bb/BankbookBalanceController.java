/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.bb;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.bb.BankbookBalanceService;
import com.chinazhoufan.admin.modules.crm.service.bb.BankbookItemService;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.google.common.collect.Maps;

/**
 * 会员资金账户余额表Controller
 * @author 张金俊
 * @version 2015-11-20
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/bb/bankbookBalance")
public class BankbookBalanceController extends BaseController {
	
	@Autowired
	private BankbookBalanceService bankbookBalanceService;
	@Autowired
	private BankbookItemService bankbookItemService;
	@Autowired
	private MemberService memberService;
	
	
	@ModelAttribute
	public BankbookBalance get(@RequestParam(required=false) String id) {
		BankbookBalance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bankbookBalanceService.get(id);
		}
		if (entity == null){
			entity = new BankbookBalance();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:bb:bankbookBalance:view")
	@RequestMapping(value = {"list", ""})
	public String list(BankbookBalance bankbookBalance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BankbookBalance> page = bankbookBalanceService.findPage(new Page<BankbookBalance>(request, response), bankbookBalance); 
		model.addAttribute("page", page);
		return "modules/crm/bb/bankbookBalanceList";
	}

	@RequiresPermissions("crm:bb:bankbookBalance:view")
	@RequestMapping(value = "form")
	public String form(BankbookBalance bankbookBalance, Model model) {
//		bankbookBalanceService.getBankbookBalanceByMemberIdForUpdate("1");
		model.addAttribute("bankbookBalance", bankbookBalance);
		return "modules/crm/bb/bankbookBalanceForm";
	}

	/**
	 * 保存方法只提供更新备注的操作（会员资金账户金额变动必须通过统一的BankbookItemService.saveBankbookBalanceOperate()方法）
	 * @param bankbookBalance
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("crm:bb:bankbookBalance:edit")
	@RequestMapping(value = "save")
	public String save(BankbookBalance bankbookBalance, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, bankbookBalance)){
//			return form(bankbookBalance, model);
//		}
		bankbookBalanceService.saveRemarks(bankbookBalance);
		addMessage(redirectAttributes, "保存会员资金账户备注成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookBalance/?repage";
	}
	
	@RequiresPermissions("crm:bb:bankbookBalance:edit")
	@RequestMapping(value = "delete")
	public String delete(BankbookBalance bankbookBalance, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(bankbookBalance.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员资金账号余额记录！");
			return "error/400";
		}
		bankbookBalanceService.delete(bankbookBalance);
		addMessage(redirectAttributes, "删除会员资金账户余额成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookBalance/?repage";
	}
	
	/**
	 * 检查会员账号状态
	 * @param member
	 * @param response
	 */
	@RequestMapping(value = "checkMemberUsercodeStatus")
	public void checkMemberUsercodeStatus(String usercode, HttpServletResponse response){
		Map<String, Object> map = Maps.newConcurrentMap();
		boolean flag = false; 
		String msg = "";
		try{
			Member member = memberService.getByUsercode(usercode);
			bankbookItemService.checkBankbookBalanceOperateable(member);
			flag = true;
			msg = "对应会员账号状态正常，可以进行资金账户操作！";
		} catch (ServiceException se){
			msg = se.getMessage();
		} catch (Exception e){
			e.printStackTrace();
			msg = "检测异常！";
		}
		map.put("flag", flag);
		map.put("msg", msg);
		renderString(response, JsonMapper.toJsonString(map));
	}
	
	@RequiresPermissions("crm:bb:bankbookBalance:view")
	@RequestMapping(value = "info")
	public String info(BankbookBalance bankbookBalance, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(bankbookBalance.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的会员资金账号余额记录！");
			return "error/400";
		}
		model.addAttribute("bankbookBalance", bankbookBalance);
		return "modules/crm/bb/bankbookBalanceInfo";
	}
	
}