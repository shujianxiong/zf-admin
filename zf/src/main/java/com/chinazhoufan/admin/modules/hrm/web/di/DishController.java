/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.di;

import java.math.BigDecimal;

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
import com.chinazhoufan.admin.modules.hrm.entity.di.Diet;
import com.chinazhoufan.admin.modules.hrm.entity.di.Dish;
import com.chinazhoufan.admin.modules.hrm.service.di.DietService;
import com.chinazhoufan.admin.modules.hrm.service.di.DishService;

/**
 * 日常菜品管理Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/dish")
public class DishController extends BaseController {
	
	@Autowired
	private DietService dietService;
	@Autowired
	private DishService dishService;
	
	@ModelAttribute
	public Dish get(@RequestParam(required=false) String id) {
		Dish entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dishService.get(id);
		}
		if (entity == null){
			entity = new Dish();
		}
		if(entity.getScore() == null){
			entity.setScore(new BigDecimal("5.00"));			
		}
		return entity;
	}
	
	/**
	 * 某日常菜谱下日常菜品列表
	 * @param diet
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("hrm:di:dish:view")
	@RequestMapping(value = {"list", ""})
	public String list(Diet diet, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		Dish dishParam = new Dish(diet);
		Page<Dish> page = dishService.findPage(new Page<Dish>(request, response), dishParam);
		model.addAttribute("diet", diet);
		model.addAttribute("page", page);
		return "modules/hrm/di/dishList";
	}
	
	/**
	 * 某日常菜谱下日常菜品表单编辑
	 * @param dietId
	 * @param dish
	 * @param model
	 * @return
	 */
	@RequiresPermissions("hrm:di:dish:edit")
	@RequestMapping(value = "form")
	public String form(String dietId, Dish dish, Model model) {
		Diet diet = dietService.get(dietId);
		dish.setDiet(diet);
		model.addAttribute("dish", dish);
		return "modules/hrm/di/dishForm";
	}
	
	/**
	 * 某日常菜谱下日常菜品保存
	 * @param dish
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("hrm:di:dish:edit")
	@RequestMapping(value = "save")
	public String save(Dish dish, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dish)){
			return form(dish.getDiet().getId(), dish, model);
		}
		dishService.save(dish);
		addMessage(redirectAttributes, "保存日常菜谱下菜品成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/dish/?repage&id="+dish.getDiet().getId();
	}
	
	@RequiresPermissions("hrm:di:dish:edit")
	@RequestMapping(value = "delete")
	public String delete(Dish dish, RedirectAttributes redirectAttributes) {
		dishService.delete(dish);
		addMessage(redirectAttributes, "删除日常菜品成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/dish/?repage&id="+dish.getDiet().getId();
	}

    @RequiresPermissions("hrm:di:dish:view")
    @RequestMapping(value = "info")
    public String info(Dish dish, Model model) {
        model.addAttribute("dish", dish);
        return "modules/hrm/di/dishInfo";
    }
}