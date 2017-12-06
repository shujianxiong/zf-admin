/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.po;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 采购货品导入Controller
 * @author 舒剑雄
 * @version 2017-08-169
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/po/purchaseProductImport")
public class PurchaseProductImportController extends BaseController {

	@Autowired
	private PurchaseOrderService purchaseOrderService;

	/**
	 * 导入数据
	 * @param file
	 * @return
	 */
	@RequiresPermissions("lgt:po:purchaseOrderExport:view")
	@RequestMapping(value = "importFile")
	public String importFile(@RequestParam(required=false) String purchaseOrderId ,@RequestParam(required=false) String produceId ,MultipartFile file ,HttpServletRequest request, HttpServletResponse response,  RedirectAttributes redirectAttributes) {
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			purchaseOrderService.importProduct(purchaseOrderId,produceId,ei);
			addMessage(redirectAttributes, "导入成功！");
		}catch(ServiceException se) {
			addMessage(redirectAttributes, se.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入失败！");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/form?id="+purchaseOrderId;
	}
}