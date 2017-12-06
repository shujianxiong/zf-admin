package com.chinazhoufan.admin.modules.spm.web.ss;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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
import com.chinazhoufan.admin.common.emay.SendMsgUtil;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.entity.ss.SendSms;
import com.chinazhoufan.admin.modules.spm.service.ss.SendSmsService;

@Controller
@RequestMapping(value = "${adminPath}/spm/ss/sendSms")
public class SendSmsController extends BaseController {

	@Autowired
	private SendSmsService sendSmsService;
	
	@ModelAttribute
	public SendSms get(@RequestParam(required=false) String id) {
		SendSms entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sendSmsService.get(id);
		}
		if (entity == null){
			entity = new SendSms();
		}
		return entity;
	}

	@RequiresPermissions("spm:ss:sendSms:view")
	@RequestMapping(value = {"list", ""})
	public String list(SendSms sendSms, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendSms> page = sendSmsService.findPage(new Page<SendSms>(request, response), sendSms); 
		model.addAttribute("page", page);
		return "modules/spm/ss/sendSmsList";
	}

	@RequiresPermissions("spm:ss:sendSms:view")
	@RequestMapping(value = "form")
	public String form(SendSms sendSms, Model model) {
		model.addAttribute("sendSms", sendSms);
		return "modules/spm/ss/sendSmsForm";
	}

	@RequiresPermissions("spm:ss:sendSms:edit")
	@RequestMapping(value = "save")
	public String save(SendSms sendSms, Model model, RedirectAttributes redirectAttributes) {
		SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		sendSms.setSendTime(new Date());
		if (!beanValidator(model, sendSms)){
			return form(sendSms, model);
		}

		String code = SendMsgUtil.sendSales(sendSms.getPhone(), sendSms.getContext(), "");
		if ("0".equals(code)){
             sendSms.setStatus(code);
			 sendSmsService.save(sendSms);
		} else {
			 throw new ServiceException("发送短信失败");
		}

		addMessage(redirectAttributes, "保存发送短信记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ss/sendSms/?repage";
	}

}