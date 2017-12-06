/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
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
 * 货品入库出库批量导入Controller
 * @author 舒剑雄
 * @version 2017-08-169
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/ProductWpIoImport")
public class ProductWpIoImportController extends BaseController {

	@Autowired
	private ProductWpIoService productWpIoService;

	/**
	 * 入库导入数据
	 * @param file
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = "importFile")
	public String importFile(MultipartFile file ,HttpServletRequest request, HttpServletResponse response,  RedirectAttributes redirectAttributes) {
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			productWpIoService.importProduct(ei);
			addMessage(redirectAttributes, "导入成功！");
		}catch(ServiceException se) {
			addMessage(redirectAttributes, se.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入失败！");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpIo/list";
	}
	/**
	 * 出库导入数据
	 * @param file
	 * @return
	 */
	@RequiresPermissions("lgt:ps:productWpIo:edit")
	@RequestMapping(value = "outImportFile")
	public String outImportFile(MultipartFile file ,HttpServletRequest request, HttpServletResponse response,  RedirectAttributes redirectAttributes) {
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			productWpIoService.outImportProduct(ei);
			addMessage(redirectAttributes, "导入成功！");
		}catch(ServiceException se) {
			addMessage(redirectAttributes, se.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入失败！");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productWpIo/list";
	}
}