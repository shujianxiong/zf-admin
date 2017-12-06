/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsRcCategory;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsRcCategoryService;

/**
 * 商品推荐分类表Controller
 * @author 刘晓东
 * @version 2016-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodsRcCategory")
public class GoodsRcCategoryController extends BaseController {

	@Autowired
	private GoodsRcCategoryService goodsRcCategoryService;
	
	@ModelAttribute
	public GoodsRcCategory get(@RequestParam(required=false) String id) {
		GoodsRcCategory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsRcCategoryService.get(id);
		}
		if (entity == null){
			entity = new GoodsRcCategory();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:goodsRcCategory:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsRcCategory goodsRcCategory, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodsRcCategory> page = goodsRcCategoryService.findPage(new Page<GoodsRcCategory>(request, response), goodsRcCategory); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodsRcCategoryList";
	}

	@RequiresPermissions("lgt:ps:goodsRcCategory:view")
	@RequestMapping(value = "form")
	public String form(GoodsRcCategory goodsRcCategory, Model model) {
		model.addAttribute("goodsRcCategory", goodsRcCategory);
		return "modules/lgt/ps/goodsRcCategoryForm";
	}

	@RequiresPermissions("lgt:ps:goodsRcCategory:edit")
	@RequestMapping(value = "save")
	public String save(GoodsRcCategory goodsRcCategory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsRcCategory)){
			return form(goodsRcCategory, model);
		}
		goodsRcCategoryService.save(goodsRcCategory);
		addMessage(redirectAttributes, "保存商品推荐分类表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsRcCategory/?repage";
	}
	
	@RequiresPermissions("lgt:ps:goodsRcCategory:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsRcCategory goodsRcCategory, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(goodsRcCategory.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品推荐分类信息！");
			return "error/400";
		}
		goodsRcCategoryService.delete(goodsRcCategory);
		addMessage(redirectAttributes, "删除商品推荐分类表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodsRcCategory/?repage";
	}

}