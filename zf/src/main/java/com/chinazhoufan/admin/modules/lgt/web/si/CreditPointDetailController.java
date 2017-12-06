/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.si;

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
import com.chinazhoufan.admin.modules.lgt.entity.si.CreditPointDetail;
import com.chinazhoufan.admin.modules.lgt.service.si.CreditPointDetailService;

/**
 * 供应商信誉分流水Controller
 * @author 张金俊
 * @version 2017-05-03
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/si/creditPointDetail")
public class CreditPointDetailController extends BaseController {

	@Autowired
	private CreditPointDetailService creditPointDetailService;
	
	@ModelAttribute
	public CreditPointDetail get(@RequestParam(required=false) String id) {
		CreditPointDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = creditPointDetailService.get(id);
		}
		if (entity == null){
			entity = new CreditPointDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:si:creditPointDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(CreditPointDetail creditPointDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CreditPointDetail> page = creditPointDetailService.findPage(new Page<CreditPointDetail>(request, response), creditPointDetail); 
		model.addAttribute("page", page);
		return "modules/lgt/si/creditPointDetailList";
	}

	@RequiresPermissions("lgt:si:creditPointDetail:view")
	@RequestMapping(value = "form")
	public String form(CreditPointDetail creditPointDetail, Model model) {
		model.addAttribute("creditPointDetail", creditPointDetail);
		return "modules/lgt/si/creditPointDetailForm";
	}

	@RequiresPermissions("lgt:si:creditPointDetail:edit")
	@RequestMapping(value = "save")
	public String save(CreditPointDetail creditPointDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, creditPointDetail)){
			return form(creditPointDetail, model);
		}
		creditPointDetailService.save(creditPointDetail);
		addMessage(redirectAttributes, "保存供应商信誉分流水成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/creditPointDetail/?repage";
	}
	
	@RequiresPermissions("lgt:si:creditPointDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(CreditPointDetail creditPointDetail, RedirectAttributes redirectAttributes) {
		creditPointDetailService.delete(creditPointDetail);
		addMessage(redirectAttributes, "删除供应商信誉分流水成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/creditPointDetail/?repage";
	}

    @RequiresPermissions("lgt:si:creditPointDetail:view")
    @RequestMapping(value = "info")
    public String info(CreditPointDetail creditPointDetail, Model model) {
        model.addAttribute("creditPointDetail", creditPointDetail);
        return "modules/lgt/si/creditPointDetailInfo";
    }
}