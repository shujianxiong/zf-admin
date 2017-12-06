/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.web.as;

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
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;
import com.chinazhoufan.admin.modules.ser.service.as.QualityWorkordProductService;

/**
 * 质检工单货品表Controller
 * @author 舒剑雄
 * @version 2017-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/ser/as/qualityWorkordProduct")
public class QualityWorkordProductController extends BaseController {

	@Autowired
	private QualityWorkordProductService qualityWorkordProductService;
	
	@ModelAttribute
	public QualityWorkordProduct get(@RequestParam(required=false) String id) {
		QualityWorkordProduct entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = qualityWorkordProductService.get(id);
		}
		if (entity == null){
			entity = new QualityWorkordProduct();
		}
		return entity;
	}
	
	@RequiresPermissions("ser:as:qualityWorkordProduct:view")
	@RequestMapping(value = {"list", ""})
	public String list(QualityWorkordProduct qualityWorkordProduct, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QualityWorkordProduct> page = qualityWorkordProductService.findPage(new Page<QualityWorkordProduct>(request, response), qualityWorkordProduct); 
		model.addAttribute("page", page);
		return "modules/ser/as/qualityWorkordProductList";
	}

	@RequiresPermissions("ser:as:qualityWorkordProduct:view")
	@RequestMapping(value = "form")
	public String form(QualityWorkordProduct qualityWorkordProduct, Model model) {
		model.addAttribute("qualityWorkordProduct", qualityWorkordProduct);
		return "modules/ser/as/qualityWorkordProductForm";
	}

	@RequiresPermissions("ser:as:qualityWorkordProduct:edit")
	@RequestMapping(value = "save")
	public String save(QualityWorkordProduct qualityWorkordProduct, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, qualityWorkordProduct)){
			return form(qualityWorkordProduct, model);
		}
		qualityWorkordProductService.save(qualityWorkordProduct);
		addMessage(redirectAttributes, "保存质检工单货品表成功");
		return "redirect:"+Global.getAdminPath()+"/ser/as/qualityWorkordProduct/?repage";
	}
	
	@RequiresPermissions("ser:as:qualityWorkordProduct:edit")
	@RequestMapping(value = "delete")
	public String delete(QualityWorkordProduct qualityWorkordProduct, RedirectAttributes redirectAttributes) {
		qualityWorkordProductService.delete(qualityWorkordProduct);
		addMessage(redirectAttributes, "删除质检工单货品表成功");
		return "redirect:"+Global.getAdminPath()+"/ser/as/qualityWorkordProduct/?repage";
	}

    @RequiresPermissions("ser:as:qualityWorkordProduct:view")
    @RequestMapping(value = "info")
    public String info(QualityWorkordProduct qualityWorkordProduct, Model model) {
        model.addAttribute("qualityWorkordProduct", qualityWorkordProduct);
        return "modules/ser/as/qualityWorkordProductInfo";
    }
}