/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.web.sl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.sl.SmsLink;
import com.chinazhoufan.admin.modules.crm.service.sl.SmsLinkService;


@Controller
@RequestMapping(value = "${adminPath}/crm/sl/smsLink/smsLinkImport")
public class SmsLinkImportController extends BaseController {

	@Autowired
	private SmsLinkService smsLinkService;

	/**
	 * 导入数据
	 * @param file
	 * @return
	 */
	@RequiresPermissions("crm:sl:smsLink:view")
	@RequestMapping(value = "importFile")
	public String importFile(SmsLink smsLink , MultipartFile file ,HttpServletRequest request, HttpServletResponse response,  RedirectAttributes redirectAttributes) {
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			smsLinkService.importSendMsg(smsLink ,ei);
			addMessage(redirectAttributes, "导入成功！");
		}catch(ServiceException se) {
			addMessage(redirectAttributes, se.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入失败！");
		}
		return "redirect:"+Global.getAdminPath()+"/crm/sl/smsLink/?repage";
	}
}