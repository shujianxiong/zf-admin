/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.ns;

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
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.NotifyService;

/**
 * 消息Controller
 * @author 张金俊
 * @version 2017-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/crm/ns/notify")
public class NotifyController extends BaseController {

	@Autowired
	private NotifyService notifyService;
	
	@ModelAttribute
	public Notify get(@RequestParam(required=false) String id) {
		Notify entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = notifyService.get(id);
		}
		if (entity == null){
			entity = new Notify();
		}
		return entity;
	}
	
	@RequiresPermissions("crm:ns:notify:view")
	@RequestMapping(value = {"list", ""})
	public String list(Notify notify, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Notify> page = notifyService.findPage(new Page<Notify>(request, response), notify); 
		model.addAttribute("page", page);
		return "modules/crm/ns/notifyList";
	}

	@RequiresPermissions("crm:ns:notify:view")
	@RequestMapping(value = "form")
	public String form(Notify notify, Model model) {
		model.addAttribute("notify", notify);
		return "modules/crm/ns/notifyForm";
	}

	@RequiresPermissions("crm:ns:notify:edit")
	@RequestMapping(value = "save")
	public String save(Notify notify, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, notify)){
			return form(notify, model);
		}
		try {
			notifyService.save(notify);
		} catch (Exception e) {
			addMessage(model, "操作失败："+e.getMessage());
			return form(notify, model);
		}
		addMessage(redirectAttributes, "保存消息成功");
		return "redirect:"+Global.getAdminPath()+"/crm/ns/notify/?repage";
	}
	
	@RequiresPermissions("crm:ns:notify:edit")
	@RequestMapping(value = "publish")
	public String publish(Notify notify, Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		if (notify == null||StringUtils.isBlank(notify.getId())) {
			addMessage(redirectAttributes, "操作失败，未能获取到有效的消息信息！");
			return list(notify, request, response, model);
		}
		try {
			Notify notifyOld = notifyService.get(notify);
			notifyService.publish(notifyOld);
			addMessage(redirectAttributes, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "操作失败！"+e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/crm/ns/notify/?repage";
	}
	
    @RequiresPermissions("crm:ns:notify:view")
    @RequestMapping(value = "info")
    public String info(Notify notify, Model model) {
        model.addAttribute("notify", notify);
        return "modules/crm/ns/notifyInfo";
    }
    
	@RequiresPermissions("crm:ns:notify:edit")
	@RequestMapping(value = "delete")
	public String delete(Notify notify, RedirectAttributes redirectAttributes) {
		try {
			notifyService.delete(notify);
			addMessage(redirectAttributes, "删除消息成功！");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "操作失败："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/crm/ns/notify/?repage";
	}
}