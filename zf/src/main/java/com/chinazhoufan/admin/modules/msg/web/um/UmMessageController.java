/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.web.um;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;
import com.chinazhoufan.admin.modules.msg.service.um.UmMessageService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 员工消息中心Controller
 * @author 刘晓东
 * @version 2015-12-11
 */
@Controller
@RequestMapping(value = "${adminPath}/msg/um/umMessage")
public class UmMessageController extends BaseController {

	@Autowired
	private UmMessageService umMessageService;
	
	@ModelAttribute
	public UmMessage get(@RequestParam(required=false) String id) {
		UmMessage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = umMessageService.get(id);
		}
		if (entity == null){
			entity = new UmMessage();
		}
		return entity;
	}
	
	@RequiresPermissions("msg:um:umMessage:view")
	@RequestMapping(value = {"list", ""})
	public String list(UmMessage umMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UmMessage> page = umMessageService.findPage(new Page<UmMessage>(request, response), umMessage); 
		model.addAttribute("page", page);
		return "modules/msg/um/umMessageList";
	}

	@RequiresPermissions("msg:um:umMessage:view")
	@RequestMapping(value = "form")
	public String form(UmMessage umMessage, Model model) {
		if (StringUtils.isBlank(umMessage.getId())) {
			umMessage.setSendUser(UserUtils.getUser());
			umMessage.setCategory(UmMessage.CATEGORY_MESSAGE);
			umMessage.setType(umMessage.TYPE_PERSON);
		}
		model.addAttribute("umMessage", umMessage);
		return "modules/msg/um/umMessageForm";
	}
	
	@RequiresPermissions("msg:um:umMessage:view")
	@RequestMapping(value = "info")
	public String info(UmMessage umMessage, Model model) {
		if (!StringUtils.isBlank(umMessage.getId())) {
			if (umMessage.getStatus().equals(UmMessage.STATUS_NOT_VIEWED)) {
				umMessageService.view(umMessage);
			}
		}
		model.addAttribute("umMessage", umMessage);
		return "modules/msg/um/umMessageInfo";
	}
	
	@RequiresPermissions("msg:um:umMessage:edit")
	@RequestMapping(value = "save")
	public String save(UmMessage umMessage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, umMessage)){
			return form(umMessage, model);
		}
		umMessageService.save(umMessage);
		addMessage(redirectAttributes, "保存员工消息成功");
		return "redirect:"+Global.getAdminPath()+"/msg/um/umMessage/?repage";
	}
	
	@RequiresPermissions("msg:um:umMessage:edit")
	@RequestMapping(value = "delete")
	public String delete(UmMessage umMessage, RedirectAttributes redirectAttributes) {
		if(umMessage == null || StringUtils.isBlank(umMessage.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的员工消息记录！");
			return "error/400";
		}
		umMessageService.delete(umMessage);
		addMessage(redirectAttributes, "删除员工消息成功");
		return "redirect:"+Global.getAdminPath()+"/msg/um/umMessage/?repage";
	}

}