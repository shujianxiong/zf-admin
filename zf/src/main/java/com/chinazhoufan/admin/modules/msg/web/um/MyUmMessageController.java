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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessageVO;
import com.chinazhoufan.admin.modules.msg.service.um.UmMessageService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 员工消息中心Controller
 * @author 刘晓东
 * @version 2015-12-11
 */
@Controller
@RequestMapping(value = "${adminPath}/msg/um/myUmMessage")
public class MyUmMessageController extends BaseController {

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
	
	/**
	 * 收件箱(需要过滤掉已删除的消息)
	 * @param umMessage
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("msg:um:myUmMessage:view")
	@RequestMapping(value = {"list", ""})
	public String list(UmMessage umMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UmMessage> page = umMessageService.findMyPage(new Page<UmMessage>(request, response), umMessage); 
		model.addAttribute("page", page);
		return "modules/msg/um/myUmMessageList";
	}
	
	/**
	 * 发件箱（获取所有发出的消息）
	 * @param umMessage
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("msg:um:myUmMessage:view")
	@RequestMapping(value = "sendList")
	public String sendList(UmMessage umMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UmMessage> page = umMessageService.findSendPage(new Page<UmMessage>(request, response), umMessage); 
		model.addAttribute("page", page);
		return "modules/msg/um/myUmMessageSendList";
	}
	
	/**
	 * 所有和当前登录者相关的消息
	 * @param umMessage
	 * @param request
	 * @param response
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("msg:um:myUmMessage:view")
	@RequestMapping(value = "listAllMy")
	public String listAllMy(UmMessage umMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UmMessage> page = umMessageService.findAllMyPage(new Page<UmMessage>(request, response), umMessage); 
		model.addAttribute("page", page);
		return "modules/msg/um/myUmMessageListAll";
	}
	
	@RequiresPermissions("msg:um:myUmMessage:view")
	@ResponseBody
	@RequestMapping(value = "listData")
	public UmMessageVO listData(UmMessage umMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page page=new Page<UmMessage>(request, response);
		page = umMessageService.findMyPageByNotViewed(page, umMessage); 
		int count=umMessageService.countNotReadMessage(UserUtils.getUser().getId());
		return new UmMessageVO(page.getList(),count);
	}

	@RequiresPermissions("msg:um:myUmMessage:view")
	@RequestMapping(value = "form")
	public String form(UmMessage umMessage, Model model) {
		if (!StringUtils.isBlank(umMessage.getId())) {
			if (umMessage.getStatus().equals(UmMessage.STATUS_NOT_VIEWED)) {
				umMessageService.view(umMessage);
			}
		}
		model.addAttribute("umMessage", umMessage);
		model.addAttribute("myFalg", true);
		return "modules/msg/um/umMessageForm";
	}

	@RequiresPermissions("msg:um:myUmMessage:edit")
	@RequestMapping(value = "save")
	public String save(UmMessage umMessage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, umMessage)){
			return form(umMessage, model);
		}
		umMessageService.save(umMessage);
		addMessage(redirectAttributes, "保存员工消息成功");
		return "redirect:"+Global.getAdminPath()+"/msg/um/myUmMessage/?repage";
	}
	
	@RequiresPermissions("msg:um:myUmMessage:edit")
	@RequestMapping(value = "delete")
	public String delete(UmMessage umMessage, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(umMessage.getId())) {
			addMessage(redirectAttributes,"操作失败，未获取到有效的消息信息！");
			return "redirect:"+Global.getAdminPath()+"/msg/um/myUmMessage/?repage";
		}
		umMessageService.deleteUmMessageByReceive(umMessage);
		addMessage(redirectAttributes, "删除员工消息成功");
		return "redirect:"+Global.getAdminPath()+"/msg/um/myUmMessage/?repage";
	}


	@RequiresPermissions("msg:um:umMessage:view")
	@RequestMapping(value="view")
	public String view(UmMessage umMessage, HttpServletRequest request, HttpServletResponse response, Model model){
		if (StringUtils.isBlank(umMessage.getId())) {
			addMessage(model, "操作失败，未获取到有效的消息信息！");
			return list(umMessage, request, response, model);
		}
		try {
			UmMessage umMessageOld = umMessageService.get(umMessage.getId());
			umMessageService.view(umMessageOld);
			addMessage(model, "操作成功！");
			return list(umMessage, request, response, model);
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败！");
			return list(umMessage, request, response, model);
		}
	}
	
}