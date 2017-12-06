/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
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
import com.chinazhoufan.admin.modules.bus.entity.ol.ExpressBroken;
import com.chinazhoufan.admin.modules.bus.service.ol.ExpressBrokenService;

/**
 * 快递包裹损坏记录Controller
 * @author 张金俊
 * @version 2017-08-14
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/expressBroken")
public class ExpressBrokenController extends BaseController {

	@Autowired
	private ExpressBrokenService expressBrokenService;
	
	@ModelAttribute
	public ExpressBroken get(@RequestParam(required=false) String id) {
		ExpressBroken entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = expressBrokenService.get(id);
		}
		if (entity == null){
			entity = new ExpressBroken();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ol:expressBroken:view")
	@RequestMapping(value = {"list", ""})
	public String list(ExpressBroken expressBroken, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExpressBroken> page = expressBrokenService.findPage(new Page<ExpressBroken>(request, response), expressBroken); 
		model.addAttribute("page", page);
		return "modules/bus/ol/expressBrokenList";
	}
	/**
	 * 退货单包裹核对
	 * @param expressBroken
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "save")
	public String save(ExpressBroken expressBroken, Model model, RedirectAttributes redirectAttributes) {
		expressBrokenService.save(expressBroken);

		addMessage(redirectAttributes, "保存快递包裹损坏记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnOrder/bagCheck?repage";
	}
	
	@RequiresPermissions("bus:ol:expressBroken:edit")
	@RequestMapping(value = "delete")
	public String delete(ExpressBroken expressBroken, RedirectAttributes redirectAttributes) {
		expressBrokenService.delete(expressBroken);
		addMessage(redirectAttributes, "删除快递包裹损坏记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/expressBroken/?repage";
	}

    @RequiresPermissions("bus:ol:expressBroken:view")
    @RequestMapping(value = "info")
    public String info(ExpressBroken expressBroken, Model model) {
        model.addAttribute("expressBroken", expressBroken);
        return "modules/bus/ol/expressBrokenInfo";
    }

}