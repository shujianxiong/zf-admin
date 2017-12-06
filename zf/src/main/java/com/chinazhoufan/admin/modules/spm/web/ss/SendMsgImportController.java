/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ss;

import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.spm.service.ss.SendSmsService;


@Controller
@RequestMapping(value = "${adminPath}/spm/ss/sendSms/sendSmsImport")
public class SendMsgImportController extends BaseController {

	@Autowired
	private SendSmsService sendSmsService;

	/**
	 * 导入数据
	 * @param file
	 * @return
	 */
	@RequiresPermissions("spm:ss:sendSms:view")
	@RequestMapping(value = "importFile")
	public String importFile(@RequestParam(required=true) String contexts ,@RequestParam(required=false) String remarks , MultipartFile file ,HttpServletRequest request, HttpServletResponse response,  RedirectAttributes redirectAttributes) {
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			sendSmsService.importSendMsg(contexts, remarks ,ei);
			addMessage(redirectAttributes, "导入成功！");
		}catch(ServiceException se) {
			addMessage(redirectAttributes, se.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入失败！");
		}
		return "redirect:"+Global.getAdminPath()+"/spm/ss/sendSms/list";
	}
}