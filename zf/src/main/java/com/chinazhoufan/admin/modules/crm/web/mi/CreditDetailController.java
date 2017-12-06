/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.mi;

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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.entity.mi.CreditDetail;
import com.chinazhoufan.admin.modules.crm.service.mi.CreditDetailService;

/**
 * 会员信誉流水Controller
 * @author 张金俊
 * @version 2017-04-26
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/mi/creditDetail")
public class CreditDetailController extends BaseController {

	@Autowired
	private CreditDetailService creditDetailService;
	
	@ModelAttribute
	public CreditDetail get(@RequestParam(required=false) String id) {
		CreditDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = creditDetailService.get(id);
		}
		if (entity == null){
			entity = new CreditDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:mi:creditDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(CreditDetail creditDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CreditDetail> page = creditDetailService.findPage(new Page<CreditDetail>(request, response), creditDetail); 
		model.addAttribute("page", page);
		return "modules/crm/mi/creditDetailList";
	}

	@RequiresPermissions("crm:mi:creditDetail:view")
	@RequestMapping(value = "form")
	public String form(CreditDetail creditDetail, Model model) {
		model.addAttribute("creditDetail", creditDetail);
		return "modules/crm/mi/creditDetailForm";
	}

	@RequiresPermissions("crm:mi:creditDetail:edit")
	@RequestMapping(value = "save")
	public String save(CreditDetail creditDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, creditDetail)){
			return form(creditDetail, model);
		}
		try {
			creditDetail.setOperaterType(CreditDetail.OPERATER_TYPE_STAFF);
			creditDetailService.updateCredit(creditDetail);
			addMessage(redirectAttributes, "更新会员信誉成功");
		} catch (Exception e) {
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/crm/mi/creditDetail/?repage";
	}
	
	@RequiresPermissions("crm:mi:creditDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(CreditDetail creditDetail, RedirectAttributes redirectAttributes) {
		creditDetailService.delete(creditDetail);
		addMessage(redirectAttributes, "删除会员信誉流水成功");
		return "redirect:"+Global.getAdminPath()+"/crm/mi/creditDetail/?repage";
	}

    @RequiresPermissions("crm:mi:creditDetail:view")
    @RequestMapping(value = "info")
    public String info(CreditDetail creditDetail, Model model) {
        model.addAttribute("creditDetail", creditDetail);
        return "modules/crm/mi/creditDetailInfo";
    }
}