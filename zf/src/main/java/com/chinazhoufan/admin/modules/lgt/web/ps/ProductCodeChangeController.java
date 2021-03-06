/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductCodeChange;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductCodeChangeService;

/**
 * 货品编码变动记录Controller
 * @author 张金俊
 * @version 2017-04-20
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/productCodeChange")
public class ProductCodeChangeController extends BaseController {

	@Autowired
	private ProductCodeChangeService productCodeChangeService;
	
	@ModelAttribute
	public ProductCodeChange get(@RequestParam(required=false) String id) {
		ProductCodeChange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = productCodeChangeService.get(id);
		}
		if (entity == null){
			entity = new ProductCodeChange();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:productCodeChange:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProductCodeChange productCodeChange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProductCodeChange> page = productCodeChangeService.findPage(new Page<ProductCodeChange>(request, response), productCodeChange); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/productCodeChangeList";
	}

	@RequiresPermissions("lgt:ps:productCodeChange:view")
	@RequestMapping(value = "form")
	public String form(ProductCodeChange productCodeChange, Model model) {
		model.addAttribute("productCodeChange", productCodeChange);
		return "modules/lgt/ps/productCodeChangeForm";
	}

	@RequiresPermissions("lgt:ps:productCodeChange:edit")
	@RequestMapping(value = "save")
	public String save(ProductCodeChange productCodeChange, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, productCodeChange)){
//			return form(productCodeChange, model);
//		}
		productCodeChangeService.save(productCodeChange);
		addMessage(redirectAttributes, "保存货品编码变动记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productCodeChange/?repage";
	}
	
	@RequiresPermissions("lgt:ps:productCodeChange:edit")
	@RequestMapping(value = "delete")
	public String delete(ProductCodeChange productCodeChange, RedirectAttributes redirectAttributes) {
		productCodeChangeService.delete(productCodeChange);
		addMessage(redirectAttributes, "删除货品编码变动记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/productCodeChange/?repage";
	}

    @RequiresPermissions("lgt:ps:productCodeChange:view")
    @RequestMapping(value = "info")
    public String info(ProductCodeChange productCodeChange, Model model) {
        model.addAttribute("productCodeChange", productCodeChange);
        return "modules/lgt/ps/productCodeChangeInfo";
    }
}