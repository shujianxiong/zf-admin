/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

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
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduct;
import com.chinazhoufan.admin.modules.bus.service.ol.SendProductService;

/**
 * 发货货品Controller
 * @author 张金俊
 * @version 2017-04-12
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/sendProduct")
public class SendProductController extends BaseController {

	@Autowired
	private SendProductService sendProductService;
	
	@ModelAttribute
	public SendProduct get(@RequestParam(required=false) String id) {
		SendProduct entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sendProductService.get(id);
		}
		if (entity == null){
			entity = new SendProduct();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ol:sendProduct:view")
	@RequestMapping(value = {"list", ""})
	public String list(SendProduct sendProduct, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SendProduct> page = sendProductService.findPage(new Page<SendProduct>(request, response), sendProduct); 
		model.addAttribute("page", page);
		return "modules/bus/ol/sendProductList";
	}

	@RequiresPermissions("bus:ol:sendProduct:view")
	@RequestMapping(value = "form")
	public String form(SendProduct sendProduct, Model model) {
		model.addAttribute("sendProduct", sendProduct);
		return "modules/bus/ol/sendProductForm";
	}

	@RequiresPermissions("bus:ol:sendProduct:edit")
	@RequestMapping(value = "save")
	public String save(SendProduct sendProduct, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sendProduct)){
			return form(sendProduct, model);
		}
		sendProductService.save(sendProduct);
		addMessage(redirectAttributes, "保存发货货品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendProduct/?repage";
	}

	@RequiresPermissions("bus:ol:sendProduct:edit")
	@RequestMapping(value = "delete")
	public String delete(SendProduct sendProduct, RedirectAttributes redirectAttributes) {
		sendProductService.delete(sendProduct);
		addMessage(redirectAttributes, "删除发货货品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/sendProduct/?repage";
	}

    @RequiresPermissions("bus:ol:sendProduct:view")
    @RequestMapping(value = "info")
    public String info(SendProduct sendProduct, Model model) {
        model.addAttribute("sendProduct", sendProduct);
        return "modules/bus/ol/sendProductInfo";
    }	
	
}
