/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.bb;

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
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookTemp;
import com.chinazhoufan.admin.modules.crm.service.bb.BankbookTempService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;

/**
 * 会员资金账户临时条目审核Controller
 * @author 张金俊
 * @version 2015-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/bb/bankbookTempChk")
public class BankbookTempChkController extends BaseController {

	@Autowired
	private BankbookTempService bankbookTempService;
	
	@ModelAttribute
	public BankbookTemp get(@RequestParam(required=false) String id) {
		BankbookTemp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bankbookTempService.get(id);
		}
		if (entity == null){
			entity = new BankbookTemp();
			entity.setCreateType("U");
		}
		return entity;
	}
	
	@RequiresPermissions("crm:bb:bankbookTempChk:view")
	@RequestMapping(value = {"list", ""})
	public String list(BankbookTemp bankbookTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BankbookTemp> page = bankbookTempService.findPage(new Page<BankbookTemp>(request, response), bankbookTemp); 
		model.addAttribute("page", page);
		return "modules/crm/bb/bankbookTempChkList";
	}

	@RequiresPermissions("crm:bb:bankbookTempChk:view")
	@RequestMapping(value = "form")
	public String form(BankbookTemp bankbookTemp, Model model) {
		model.addAttribute("bankbookTemp", bankbookTemp);
		model.addAttribute("moneyType",DictUtils.getDictList("crm_bb_bankbook_moneyType"));
		return "modules/crm/bb/bankbookTempChkForm";
	}

	/**
	 * 审核临时存折条目
	 * @param bankbookTemp
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("crm:bb:bankbookTempChk:check")
	@RequestMapping(value = "check")
	public String check(String checkType, BankbookTemp bankbookTemp, RedirectAttributes redirectAttributes) {
		try{
			bankbookTempService.checkTemp(bankbookTemp, checkType);			
		}catch(ServiceException se){
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
			return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookTempChk/list/?repage";
		}
		addMessage(redirectAttributes, "审核会员资金账户临时条目成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookTempChk/list/?repage";
	}
	
	@RequiresPermissions("crm:bb:bankbookTempChk:check")
	@RequestMapping(value = "delete")
	public String delete(BankbookTemp bankbookTemp, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(bankbookTemp.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员资金账户临时条目信息！");
			return "error/400";
		}
		
		bankbookTempService.delete(bankbookTemp);
		addMessage(redirectAttributes, "删除会员资金账户临时条目成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookTempChk/list/?repage";
	}

}