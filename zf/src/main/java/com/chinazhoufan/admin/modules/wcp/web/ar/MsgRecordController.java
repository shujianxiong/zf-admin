/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.web.ar;

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
import com.chinazhoufan.admin.modules.wcp.entity.ar.MsgRecord;
import com.chinazhoufan.admin.modules.wcp.service.ar.MsgRecordService;

/**
 * 消息发送记录Controller
 * @author 张金俊
 * @version 2016-05-30
 */
@Controller
@RequestMapping(value = "${adminPath}/wcp/ar/msgRecord")
public class MsgRecordController extends BaseController {

	@Autowired
	private MsgRecordService msgRecordService;
	
	@ModelAttribute
	public MsgRecord get(@RequestParam(required=false) String id) {
		MsgRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = msgRecordService.get(id);
		}
		if (entity == null){
			entity = new MsgRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("wcp:ar:msgRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(MsgRecord msgRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MsgRecord> page = msgRecordService.findPage(new Page<MsgRecord>(request, response), msgRecord); 
		model.addAttribute("page", page);
		return "modules/wcp/ar/msgRecordList";
	}
	
	@RequiresPermissions("wcp:ar:msgRecord:view")
	@RequestMapping(value = "info")
	public String info(MsgRecord msgRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(msgRecord == null || StringUtils.isBlank(msgRecord.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的消息发送记录信息！");
			return "error/400";
		}
		model.addAttribute("msgRecord", msgRecord);
		return "modules/wcp/ar/msgRecordInfo";
	}

	@RequiresPermissions("wcp:ar:msgRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(MsgRecord msgRecord, RedirectAttributes redirectAttributes) {
		if(msgRecord == null || StringUtils.isBlank(msgRecord.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的消息发送记录信息！");
			return "error/400";
		}
		
		msgRecordService.delete(msgRecord);
		addMessage(redirectAttributes, "删除消息发送记录成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/msgRecord/?repage";
	}

}