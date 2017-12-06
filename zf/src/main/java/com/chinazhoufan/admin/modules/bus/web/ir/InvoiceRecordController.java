/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ir;

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
import com.chinazhoufan.admin.modules.bus.entity.ir.InvoiceRecord;
import com.chinazhoufan.admin.modules.bus.service.ir.InvoiceRecordService;

/**
 * 发票开票记录Controller
 * @author 张金俊
 * @version 2017-08-07
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ir/invoiceRecord")
public class InvoiceRecordController extends BaseController {

	@Autowired
	private InvoiceRecordService invoiceRecordService;
	
	@ModelAttribute
	public InvoiceRecord get(@RequestParam(required=false) String id) {
		InvoiceRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = invoiceRecordService.get(id);
		}
		if (entity == null){
			entity = new InvoiceRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ir:invoiceRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(InvoiceRecord invoiceRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InvoiceRecord> page = invoiceRecordService.findPage(new Page<InvoiceRecord>(request, response), invoiceRecord); 
		model.addAttribute("page", page);
		return "modules/bus/ir/invoiceRecordList";
	}

	@RequiresPermissions("bus:ir:invoiceRecord:view")
	@RequestMapping(value = "form")
	public String form(InvoiceRecord invoiceRecord, Model model) {
		model.addAttribute("invoiceRecord", invoiceRecord);
		return "modules/bus/ir/invoiceRecordForm";
	}

	@RequiresPermissions("bus:ir:invoiceRecord:edit")
	@RequestMapping(value = "save")
	public String save(InvoiceRecord invoiceRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, invoiceRecord)){
			return form(invoiceRecord, model);
		}
		invoiceRecordService.save(invoiceRecord);
		addMessage(redirectAttributes, "保存发票开票记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ir/invoiceRecord/?repage";
	}
	
	@RequiresPermissions("bus:ir:invoiceRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(InvoiceRecord invoiceRecord, RedirectAttributes redirectAttributes) {
		invoiceRecordService.delete(invoiceRecord);
		addMessage(redirectAttributes, "删除发票开票记录成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ir/invoiceRecord/?repage";
	}

    @RequiresPermissions("bus:ir:invoiceRecord:view")
    @RequestMapping(value = "info")
    public String info(InvoiceRecord invoiceRecord, Model model) {
        model.addAttribute("invoiceRecord", invoiceRecord);
        return "modules/bus/ir/invoiceRecordInfo";
    }
}