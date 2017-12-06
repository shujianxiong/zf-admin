/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.fd;

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
import com.chinazhoufan.admin.modules.spm.entity.fd.FreeDeposit;
import com.chinazhoufan.admin.modules.spm.service.fd.FreeDepositService;

/**
 * 免押金活动配置表Controller
 * @author liuxiaodong
 * @version 2017-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/fd/freeDeposit")
public class FreeDepositController extends BaseController {

	@Autowired
	private FreeDepositService freeDepositService;
	
	@ModelAttribute
	public FreeDeposit get(@RequestParam(required=false) String id) {
		FreeDeposit entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = freeDepositService.get(id);
		}
		if (entity == null){
			entity = new FreeDeposit();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:fd:freeDeposit:view")
	@RequestMapping(value = {"list", ""})
	public String list(FreeDeposit freeDeposit, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FreeDeposit> page = freeDepositService.findPage(new Page<FreeDeposit>(request, response), freeDeposit); 
		model.addAttribute("page", page);
		return "modules/spm/fd/freeDepositList";
	}

	@RequiresPermissions("spm:fd:freeDeposit:view")
	@RequestMapping(value = "form")
	public String form(FreeDeposit freeDeposit, Model model) {
		model.addAttribute("freeDeposit", freeDeposit);
		return "modules/spm/fd/freeDepositForm";
	}

	@RequiresPermissions("spm:fd:freeDeposit:edit")
	@RequestMapping(value = "save")
	public String save(FreeDeposit freeDeposit, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, freeDeposit)){
			return form(freeDeposit, model);
		}
		try {
			freeDepositService.save(freeDeposit);
			addMessage(redirectAttributes, "保存免押金活动配置表成功");
		} catch (Exception e) {
			addMessage(model, e.getMessage());
			return form(freeDeposit, model);
		}
		return "redirect:"+Global.getAdminPath()+"/spm/fd/freeDeposit/?repage";
	}
	
	@RequiresPermissions("spm:fd:freeDeposit:edit")
	@RequestMapping(value = "delete")
	public String delete(FreeDeposit freeDeposit, RedirectAttributes redirectAttributes) {
		freeDepositService.delete(freeDeposit);
		addMessage(redirectAttributes, "删除免押金活动配置表成功");
		return "redirect:"+Global.getAdminPath()+"/spm/fd/freeDeposit/?repage";
	}

    @RequiresPermissions("spm:fd:freeDeposit:view")
    @RequestMapping(value = "info")
    public String info(FreeDeposit freeDeposit, Model model) {
        model.addAttribute("freeDeposit", freeDeposit);
        return "modules/spm/fd/freeDepositInfo";
    }
    
    
	@RequiresPermissions("spm:fd:freeDeposit:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(FreeDeposit freeDeposit, RedirectAttributes redirectAttributes) {
		freeDeposit.setActiveFlag(FreeDeposit.TRUE_FLAG.equals(freeDeposit.getActiveFlag()) ? FreeDeposit.FALSE_FLAG : FreeDeposit.TRUE_FLAG);
		freeDepositService.save(freeDeposit);
		addMessage(redirectAttributes, (FreeDeposit.TRUE_FLAG.equals(freeDeposit.getActiveFlag()) ? "启用" : "停用")+"免押金配置成功");
		return "redirect:"+Global.getAdminPath()+"/spm/fd/freeDeposit/?repage";
    }
}