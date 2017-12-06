/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.si;

import java.util.List;

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
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierContract;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierContractService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;

/**
 * 供应商合同Controller
 * @author liut
 * @version 2016-04-29
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/si/supplierContract")
public class SupplierContractController extends BaseController {

	@Autowired
	private SupplierContractService supplierContractService;
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	
	@ModelAttribute
	public SupplierContract get(@RequestParam(required=false) String id) {
		SupplierContract entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = supplierContractService.get(id);
		}
		if (entity == null){
			entity = new SupplierContract();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:si:supplierContract:view")
	@RequestMapping(value = {"list", ""})
	public String list(SupplierContract supplierContract, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SupplierContract> page = supplierContractService.findPage(new Page<SupplierContract>(request, response), supplierContract); 
		model.addAttribute("page", page);
		
		/*List<Supplier> supplierList = supplierService.findList(new Supplier());
		model.addAttribute("supplierList", supplierList);*/
		return "modules/lgt/si/supplierContractList";
	}

	@RequiresPermissions("lgt:si:supplierContract:view")
	@RequestMapping(value = "form")
	public String form(SupplierContract supplierContract, Model model) {
		
		if(StringUtils.isBlank(supplierContract.getId())) {
			supplierContract.setContractNo(codeGeneratorService.generateCode(SupplierContract.GENERATECODE_BATCHNO));
		}
		model.addAttribute("supplierContract", supplierContract);
		
		List<Supplier> supplierList = supplierService.findList(new Supplier());
		model.addAttribute("supplierList", supplierList);
		return "modules/lgt/si/supplierContractForm";
	}

	@RequiresPermissions("lgt:si:supplierContract:edit")
	@RequestMapping(value = "save")
	public String save(SupplierContract supplierContract, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, supplierContract)){
			return form(supplierContract, model);
		}
		supplierContractService.save(supplierContract);
		addMessage(redirectAttributes, "保存供应商合同成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplierContract/?repage";
	}
	
	@RequiresPermissions("lgt:si:supplierContract:edit")
	@RequestMapping(value = "delete")
	public String delete(SupplierContract supplierContract, RedirectAttributes redirectAttributes) {
		if(supplierContract == null || StringUtils.isBlank(supplierContract.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的供应商合同信息！");
			return "error/400";
		}
		
		
		supplierContractService.delete(supplierContract);
		addMessage(redirectAttributes, "删除供应商合同成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplierContract/?repage";
	}

	@RequiresPermissions("lgt:si:supplierContract:view")
	@RequestMapping(value = "info")
	public String info(SupplierContract supplierContract, Model model, HttpServletRequest request, HttpServletResponse response) {
		if(supplierContract == null || StringUtils.isBlank(supplierContract.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的供应商合同信息！");
			return "error/400";
		}
		model.addAttribute("supplierContract", supplierContract);
		return "modules/lgt/si/supplierContractInfo";
	}
	
	@RequiresPermissions("lgt:si:supplierContract:view")
	@RequestMapping(value = "autoContractNo")
	public String autoContractNo(HttpServletResponse response) {
		String no = codeGeneratorService.generateCode(SupplierContract.GENERATECODE_BATCHNO);
		return renderString(response, no, "text/html");
	}
	
}