/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.pm;

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
import com.chinazhoufan.admin.modules.spm.entity.pm.PointExchange;
import com.chinazhoufan.admin.modules.spm.service.pm.PointExchangeService;

/**
 * 积分商品兑换记录Controller
 * @author 张金俊
 * @version 2016-12-02
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pm/pointExchange")
public class PointExchangeController extends BaseController {

	@Autowired
	private PointExchangeService pointExchangeService;
	
	@ModelAttribute
	public PointExchange get(@RequestParam(required=false) String id) {
		PointExchange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = pointExchangeService.get(id);
		}
		if (entity == null){
			entity = new PointExchange();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pm:pointExchange:view")
	@RequestMapping(value = {"list", ""})
	public String list(PointExchange pointExchange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PointExchange> page = pointExchangeService.findPage(new Page<PointExchange>(request, response), pointExchange); 
		model.addAttribute("page", page);
		return "modules/spm/pm/pointExchangeList";
	}

	@RequiresPermissions("spm:pm:pointExchange:view")
	@RequestMapping(value = "form")
	public String form(PointExchange pointExchange, Model model) {
		model.addAttribute("pointExchange", pointExchange);
		return "modules/spm/pm/pointExchangeForm";
	}

	@RequiresPermissions("spm:pm:pointExchange:edit")
	@RequestMapping(value = "save")
	public String save(PointExchange pointExchange, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, pointExchange)){
			return form(pointExchange, model);
		}
		pointExchangeService.save(pointExchange);
		addMessage(redirectAttributes, "保存积分商品兑换记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pm/pointExchange/?repage";
	}
	
	@RequiresPermissions("spm:pm:pointExchange:edit")
	@RequestMapping(value = "delete")
	public String delete(PointExchange pointExchange, RedirectAttributes redirectAttributes) {
		pointExchangeService.delete(pointExchange);
		addMessage(redirectAttributes, "删除积分商品兑换记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pm/pointExchange/?repage";
	}

    @RequiresPermissions("spm:pm:pointExchange:view")
    @RequestMapping(value = "info")
    public String info(PointExchange pointExchange, Model model) {
        model.addAttribute("pointExchange", pointExchange);
        return "modules/spm/pm/pointExchangeInfo";
    }
}