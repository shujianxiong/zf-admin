/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.service.ps.CategoriesService;
import com.chinazhoufan.admin.modules.lgt.service.ps.PropertyService;
import com.google.common.collect.Lists;

/**
 * 属性表Controller
 * @author 张金俊
 * @version 2015-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/property")
public class PropertyController extends BaseController {

	@Autowired
	private PropertyService propertyService;
	
	@Autowired
	private CategoriesService categoryService;
	
	@ModelAttribute
	public Property get(@RequestParam(required=false) String id) {
		Property entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = propertyService.get(id);
		}
		if (entity == null){
			entity = new Property();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:lgtPsProperty:view")
	@RequestMapping(value = {"list", ""})
	public String list(Property property, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Property> page = propertyService.findPage(new Page<Property>(request, response), property); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/propertyList";
	}

	@RequiresPermissions("lgt:ps:lgtPsProperty:view")
	@RequestMapping(value = "form")
	public String form(Property property, Model model) {
		//获取所有的分类
		if(StringUtils.isBlank(property.getId()) || StringUtils.isBlank(property.getFilterFlag())) {
			property.setFilterFlag(Property.FALSE_FLAG);
		}
		if(StringUtils.isBlank(property.getId()) || StringUtils.isBlank(property.getNecessaryFlag())) {
			property.setNecessaryFlag(Property.FALSE_FLAG);
		}
		if(StringUtils.isBlank(property.getId()) || StringUtils.isBlank(property.getShowFlag())) {
			property.setShowFlag(Property.FALSE_FLAG);
		}
		if(StringUtils.isBlank(property.getId()) || StringUtils.isBlank(property.getTitleFlag())) {
			property.setTitleFlag(Property.FALSE_FLAG);
		}
		model.addAttribute("property", property);
		return "modules/lgt/ps/propertyForm";
	}
	
	@RequestMapping(value = "info")
	public String info(Property property, Model model) {
		//获取所有的分类
		model.addAttribute("property", property);
		model.addAttribute("categoryAll", categoryService.findList());
		return "modules/lgt/ps/propertyInfo";
	}


	@RequiresPermissions("lgt:ps:lgtPsProperty:edit")
	@RequestMapping(value = "save")
	public String save(Property property, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, property)){
			return form(property, model);
		}
		propertyService.save(property);
		addMessage(redirectAttributes, "保存属性成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/property/list?repage";
	}
	
	
	@RequiresPermissions("lgt:ps:lgtPsProperty:edit")
	@RequestMapping(value = "delete")
	public String delete(Property property, RedirectAttributes redirectAttributes) {
		if(property == null || StringUtils.isBlank(property.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的属性信息！");
			return "error/400";
		}
		
		propertyService.delete(property);
		addMessage(redirectAttributes, "删除属性成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/property/?repage";
	}

	@RequestMapping(value = "findCategoryById")
	public List<Property> findCategoryById(String categoryId, Model model){
//		List<Property> propertys = propertyService.findCategoryById(categoryId);
		
		return null;
	}
	
	
	/**
	 * Api 查询所有属性（根据条件）
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "findPropertyData")
	public String findPropertyData(Property property, HttpServletResponse response) {
		if(property == null)
			property = new Property();
		List<Property> propertyList = Lists.newArrayList();
		propertyList = propertyService.findListData(property);
		return JsonMapper.toJsonString(propertyList);
	}
	
	
}