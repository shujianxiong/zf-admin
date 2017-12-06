/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.cl;

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
import com.chinazhoufan.admin.modules.crm.entity.cl.CollocationCollect;
import com.chinazhoufan.admin.modules.crm.service.cl.CollocationCollectService;

/**
 * 会员搭配收藏Controller
 * @author 张金俊
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/cl/collocationCollect")
public class CollocationCollectController extends BaseController {

	@Autowired
	private CollocationCollectService collocationCollectService;
	
	@ModelAttribute
	public CollocationCollect get(@RequestParam(required=false) String id) {
		CollocationCollect entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = collocationCollectService.get(id);
		}
		if (entity == null){
			entity = new CollocationCollect();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:cl:collocationCollect:view")
	@RequestMapping(value = {"list", ""})
	public String list(CollocationCollect collocationCollect, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CollocationCollect> page = collocationCollectService.findPage(new Page<CollocationCollect>(request, response), collocationCollect); 
		model.addAttribute("page", page);
		return "modules/crm/cl/collocationCollectList";
	}

	@RequiresPermissions("crm:cl:collocationCollect:view")
	@RequestMapping(value = "form")
	public String form(CollocationCollect collocationCollect, Model model) {
		model.addAttribute("collocationCollect", collocationCollect);
		return "modules/crm/cl/collocationCollectForm";
	}

	@RequiresPermissions("crm:cl:collocationCollect:edit")
	@RequestMapping(value = "save")
	public String save(CollocationCollect collocationCollect, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, collocationCollect)){
			return form(collocationCollect, model);
		}
		collocationCollectService.save(collocationCollect);
		addMessage(redirectAttributes, "保存会员搭配收藏成功");
		return "redirect:"+Global.getAdminPath()+"/crm/cl/collocationCollect/?repage";
	}
	
	@RequiresPermissions("crm:cl:collocationCollect:edit")
	@RequestMapping(value = "delete")
	public String delete(CollocationCollect collocationCollect, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(collocationCollect.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的会员搭配收藏记录！");
			return "error/400";
		}
		collocationCollectService.delete(collocationCollect);
		addMessage(redirectAttributes, "删除会员搭配收藏成功");
		return "redirect:"+Global.getAdminPath()+"/crm/cl/collocationCollect/?repage";
	}

    @RequiresPermissions("crm:cl:collocationCollect:view")
    @RequestMapping(value = "info")
    public String info(CollocationCollect collocationCollect, HttpServletRequest request, HttpServletResponse response, Model model) {
    	if(StringUtils.isBlank(collocationCollect.getId())) {
    		addMessage(model, "友情提示：未能获取到要查看的会员搭配收藏记录！");
    		return "error/400";
    	}
        model.addAttribute("collocationCollect", collocationCollect);
        return "modules/crm/cl/collocationCollectInfo";
    }
}