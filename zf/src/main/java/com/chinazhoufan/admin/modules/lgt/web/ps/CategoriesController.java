/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.utils.MyUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.service.ps.CategoriesService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 商品分类管理Controller
 * @author 杨晓辉
 * @version 2015-10-12
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/category")
public class CategoriesController extends BaseController {

	@Autowired
	private CategoriesService categoryService;
	
	@ModelAttribute
	public Categories get(@RequestParam(required=false) String id) {
		Categories entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = categoryService.get(id);
		}
		if (entity == null){
			entity = new Categories();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsCategory:view")
	@RequestMapping(value = {"list", ""})
	public String list(Categories category, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Categories> list = Lists.newArrayList();
		List<Categories> sourcelist = categoryService.findList();
		
		//取出父级下的子集
		for (Categories l : sourcelist) {
			if(l.getParent()==null||StringUtils.isBlank(l.getParent().getId())){
				//保存顶级父级
				list.add(l);
				//迭代取出子集
				Categories.sortList(list, sourcelist, l.getId(), true);
			}
		}
        model.addAttribute("list", list);
        model.addAttribute("category", new Categories());
		
		return "modules/lgt/ps/categoryList";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsCategory:view")
	@RequestMapping(value = "search")
	public String search(Categories category, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(category==null||StringUtils.isBlank(category.getCategoryName()))
			return list(category, request, response, model);
		category.setCategoryTag(category.getCategoryName());
		List<Categories> list = categoryService.findListBySearch(category);
        model.addAttribute("list", list);
        model.addAttribute("category", category);
		return "modules/lgt/ps/categoryList";
	}

	@RequiresPermissions("lgt:ps:lgtPsCategory:view")
	@RequestMapping(value = "form")
	public String form(Categories category, Model model) {
		model.addAttribute("category", category);
		return "modules/lgt/ps/categoryForm";
	}
	
	@RequiresPermissions("lgt:ps:lgtPsCategory:view")
	@RequestMapping(value = "view")
	public String view(Categories category, Model model) {
		model.addAttribute("category", category);
		return "modules/lgt/ps/categoryView";
	}

	@RequiresPermissions("lgt:ps:lgtPsCategory:edit")
	@RequestMapping(value = "save")
	public String save(Categories category, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, category)){
			return form(category, model);
		}
		if(!MyUtils.isInteger(category.getOrderNo())){
			addMessage(model, "分类排序必须为数字");
		}else{
			categoryService.save(category);
			addMessage(model, "保存商品分类成功");
			return "redirect:"+Global.getAdminPath()+"/lgt/ps/category/?repage";
		}
		return form(category, model);
	}
	
	@RequiresPermissions("lgt:ps:lgtPsCategory:edit")
	@RequestMapping(value = "delete")
	public String delete(Categories lgtPsCategory, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(lgtPsCategory.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品分类信息！");
			return "error/400";
		}
		
		categoryService.delete(lgtPsCategory);
		addMessage(redirectAttributes, "删除商品分类成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/category/?repage";
	}
	
	/**
	 * @param extId
	 * @param isShowHidden
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "categoryData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Categories> list = categoryService.findList();
		for (int i=0; i<list.size(); i++){
			Categories e = list.get(i);
			
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParent()==null?"":e.getParent().getId());
			map.put("name", e.getCategoryName());
			mapList.add(map);
		}
		return mapList;
	}
	
}