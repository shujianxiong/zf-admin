/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.bs;

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
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;
import com.chinazhoufan.admin.modules.lgt.service.bs.BrandService;

/**
 * 品牌管理Controller
 * @author 贾斌
 * @version 2015-11-04
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/bs/brand")
public class BrandController extends BaseController {

	@Autowired
	private BrandService brandService;
	
	@ModelAttribute
	public Brand get(@RequestParam(required=false) String id) {
		Brand entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = brandService.get(id);
		}
		if (entity == null){
			entity = new Brand();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:bs:brand:view")
	@RequestMapping(value = {"list", ""})
	public String list(Brand brand, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Brand> page = brandService.findPage(new Page<Brand>(request, response), brand);
		model.addAttribute("page", page);
		return "modules/lgt/bs/brandList";
	}

	@RequiresPermissions("lgt:bs:brand:view")
	@RequestMapping(value = "form")
	public String form(Brand brand, Model model) {
		if(StringUtils.isBlank(brand.getId())) {
			brand.setBrandStatus(Brand.TRUE_FLAG);
		}
		model.addAttribute("brand", brand);
		return "modules/lgt/bs/brandForm";
	}

	@RequiresPermissions("lgt:bs:brand:edit")
	@RequestMapping(value = "save")
	public String save(Brand brand, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, brand)){
			return form(brand, model);
		}
		brandService.save(brand);
		addMessage(redirectAttributes, "保存品牌成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/brand/list?repage";
	}
	
	@RequiresPermissions("lgt:bs:brand:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(Brand brand, Model model, RedirectAttributes redirectAttributes){
		brand = brandService.get(brand.getId());
		if(Brand.TRUE_FLAG.equals(brand.getBrandStatus())){
			brand.setBrandStatus(Brand.FALSE_FLAG);
		}else {
			brand.setBrandStatus(Brand.TRUE_FLAG);
		}
		brandService.save(brand);
		addMessage(redirectAttributes, "品牌状态修改成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/brand/list?repage";
	}
	
	@RequiresPermissions("lgt:bs:brand:edit")
	@RequestMapping(value = "delete")
	public String delete(Brand brand,String id,Model model,HttpServletRequest request,HttpServletResponse response) {
		if(StringUtils.isBlank(brand.getId())) {
			addMessage(model, "友情提示：未能获取到要删除的品牌信息！");
			return "error/400";
		}
		Brand b = brandService.get(id);
		b.setId(id);
		brandService.delete(b);
		addMessage(model, "删除品牌成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/brand/list?repage";
	}
	
	
	/**
	 * 品牌选择器
	 * @param brand
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:bs:brand:view")
	@RequestMapping(value = "select")
	public String select(Brand brand, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Brand> page = brandService.findPage(new Page<Brand>(request, response), brand); 
		model.addAttribute("page", page);
		return "modules/lgt/bs/brandSelect";
	}
	
	@RequiresPermissions("lgt:bs:brand:view")
	@RequestMapping(value = "info")
	public String info(Brand brand, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(brand.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的品牌信息！");
			return "error/400";
		}
		model.addAttribute("brand", brand);
		return "modules/lgt/bs/brandInfo";
	}
}