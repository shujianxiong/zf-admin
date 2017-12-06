/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.zi;

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
import com.chinazhoufan.admin.modules.spm.entity.zi.Zmxy;
import com.chinazhoufan.admin.modules.spm.service.zi.ZmxyService;

/**
 * 芝麻信用配置Controller
 * @author liuxiaodong
 * @version 2017-09-23
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/zi/zmxy")
public class ZmxyController extends BaseController {

	@Autowired
	private ZmxyService zmxyService;
	
	@ModelAttribute
	public Zmxy get(@RequestParam(required=false) String id) {
		Zmxy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zmxyService.get(id);
		}
		if (entity == null){
			entity = new Zmxy();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:zi:zmxy:view")
	@RequestMapping(value = {"list", ""})
	public String list(Zmxy zmxy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Zmxy> page = zmxyService.findPage(new Page<Zmxy>(request, response), zmxy); 
		model.addAttribute("page", page);
		return "modules/spm/zi/zmxyList";
	}

	@RequiresPermissions("spm:zi:zmxy:view")
	@RequestMapping(value = "form")
	public String form(Zmxy zmxy, Model model) {
		model.addAttribute("zmxy", zmxy);
		return "modules/spm/zi/zmxyForm";
	}

	@RequiresPermissions("spm:zi:zmxy:edit")
	@RequestMapping(value = "save")
	public String save(Zmxy zmxy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zmxy)){
			return form(zmxy, model);
		}
		try {
			zmxyService.save(zmxy);
			addMessage(redirectAttributes, "保存芝麻信用配置成功");
		} catch (Exception e) {
			addMessage(model, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/spm/zi/zmxy/?repage";
	}
	
	@RequiresPermissions("spm:zi:zmxy:edit")
	@RequestMapping(value = "delete")
	public String delete(Zmxy zmxy, RedirectAttributes redirectAttributes) {
		zmxyService.delete(zmxy);
		addMessage(redirectAttributes, "删除芝麻信用配置成功");
		return "redirect:"+Global.getAdminPath()+"/spm/zi/zmxy/?repage";
	}

    @RequiresPermissions("spm:zi:zmxy:view")
    @RequestMapping(value = "info")
    public String info(Zmxy zmxy, Model model) {
        model.addAttribute("zmxy", zmxy);
        return "modules/spm/zi/zmxyInfo";
    }
    
    
	@RequiresPermissions("spm:zi:zmxy:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(Zmxy zmxy, RedirectAttributes redirectAttributes) {
		zmxy.setActiveFlag(Zmxy.TRUE_FLAG.equals(zmxy.getActiveFlag()) ? Zmxy.FALSE_FLAG : Zmxy.TRUE_FLAG);
		zmxyService.save(zmxy);
		addMessage(redirectAttributes, (Zmxy.TRUE_FLAG.equals(zmxy.getActiveFlag()) ? "启用" : "停用")+"芝麻信用配置成功");
		return "redirect:"+Global.getAdminPath()+"/spm/zi/zmxy/?repage";
    }
}