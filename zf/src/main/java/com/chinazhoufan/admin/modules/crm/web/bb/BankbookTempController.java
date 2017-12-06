/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.bb;

import java.util.List;

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
import com.chinazhoufan.admin.modules.sys.entity.Dict;
import com.chinazhoufan.admin.modules.sys.service.DictService;
import com.google.common.collect.Lists;

/**
 * 会员资金账户临时条目新增Controller
 * @author 陈适
 * @version 2015-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/bb/bankbookTemp")
public class BankbookTempController extends BaseController {

	@Autowired
	private BankbookTempService bankbookTempService;
	@Autowired
	private DictService dictService;
	
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
	
	@RequiresPermissions("crm:bb:bankbookTemp:view")
	@RequestMapping(value = {"list", ""})
	public String list(BankbookTemp bankbookTemp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BankbookTemp> page = bankbookTempService.findPage(new Page<BankbookTemp>(request, response), bankbookTemp); 
		model.addAttribute("page", page);
		return "modules/crm/bb/bankbookTempList";
	}

	@RequiresPermissions("crm:bb:bankbookTemp:view")
	@RequestMapping(value = "form")
	public String form(BankbookTemp bankbookTemp, Model model) {
		List<Dict> moneyTypeList = Lists.newArrayList();
		if(StringUtils.isBlank(bankbookTemp.getId())) {
			bankbookTemp.setStatus(BankbookTemp.STATUS_NEW);
		} else {
			moneyTypeList = dictService.listByTypeAndValueLike("crm_bb_bankbook_moneyType", bankbookTemp.getChangeType());
		}
		model.addAttribute("bankbookTemp", bankbookTemp);
		model.addAttribute("moneyTypeList", moneyTypeList);
		return "modules/crm/bb/bankbookTempForm";
	}

	@RequiresPermissions("crm:bb:bankbookTemp:edit")
	@RequestMapping(value = "save")
	public String save(BankbookTemp bankbookTemp, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bankbookTemp)){
			return form(bankbookTemp, model);
		}
		try {
			if(!BankbookTemp.STATUS_NEW.equals(bankbookTemp.getStatus())) {
				addMessage(redirectAttributes, "提示：该资金账户条目已审核，不允许修改!");
				return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookTemp/list/?repage";
			}
			bankbookTempService.save(bankbookTemp);
			addMessage(redirectAttributes, "保存会员资金账户临时条目成功");
		}catch(ServiceException e){
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "失败：保存会员资金账户临时条目异常");
		}
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookTemp/list/?repage";
	}
	
	@RequiresPermissions("crm:bb:bankbookTemp:edit")
	@RequestMapping(value = "delete")
	public String delete(BankbookTemp bankbookTemp, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(bankbookTemp.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员资金账号临时条目信息！");
			return "error/400";
		}
		bankbookTempService.delete(bankbookTemp);
		addMessage(redirectAttributes, "删除会员资金账户临时条目成功");
		return "redirect:"+Global.getAdminPath()+"/crm/bb/bankbookTemp/list/?repage";
	}

	@RequiresPermissions("crm:bb:bankbookTemp:view")
	@RequestMapping(value = "info")
	public String info(BankbookTemp bankbookTemp, Model model) {
		model.addAttribute("bankbookTemp", bankbookTemp);
		return "modules/crm/bb/bankbookTempInfo";
	}

}