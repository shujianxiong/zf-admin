/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.di;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.hrm.entity.di.Diet;
import com.chinazhoufan.admin.modules.hrm.entity.di.Dish;
import com.chinazhoufan.admin.modules.hrm.entity.di.DishJudge;
import com.chinazhoufan.admin.modules.hrm.service.di.DietJudgeService;
import com.chinazhoufan.admin.modules.hrm.service.di.DietService;
import com.chinazhoufan.admin.modules.hrm.service.di.DishJudgeService;
import com.chinazhoufan.admin.modules.hrm.service.di.DishService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 我的日常菜品Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/myDish")
public class MyDishController extends BaseController {

	@Autowired
	private DietJudgeService dietJudgeService;
	@Autowired
	private DishJudgeService dishJudgeService;
	@Autowired
	private DietService dietService;
	@Autowired
	private DishService dishService;
	
	
	@ModelAttribute
	public DishJudge get(@RequestParam(required=false) String id) {
		DishJudge entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dishJudgeService.get(id);
		}
		if (entity == null){
			entity = new DishJudge();
		}
		return entity;
	}
	
	/**
	 * 菜品列表
	 * @param diet
	 * @param model
	 * @param redirectAttributes
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("hrm:di:dishJudge:edit")
	@RequestMapping(value = {"list", ""})
	public String list(String dietId, Dish dish, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) {
		Diet diet = dietService.get(dietId);
		dish.setDiet(diet);
		if(dish.getDishJudge() == null){
			dish.setDishJudge(new DishJudge());
		}
		dish.getDishJudge().setJudgeBy(UserUtils.getUser());
		Page<Dish> page = dishService.findPageWithCurrentJudge(new Page<Dish>(request, response), dish);
		model.addAttribute("diet", diet);
		model.addAttribute("page", page);
		return "modules/hrm/di/my/myDishList";
	}
	
	/**AJAX
	 * 评价菜品
	 * @param dishId	菜品ID
	 * @param level		评价级别
	 * @param request
	 * @return
	 */
	@RequiresPermissions("hrm:di:dishJudge:edit")
	@ResponseBody
	@RequestMapping(value = "judge/{dishId}", method = RequestMethod.POST)
	public String judge(
			@PathVariable("dishId")String dishId, 
			@RequestParam(required=false)String level, 
			HttpServletRequest request) {
		if(StringUtils.isBlank(dishId) || StringUtils.isBlank(level)){
			return "{\"status\":\"0\",\"message\":\"菜谱评价失败：未能获取到菜谱标记或评价级别\"}";
		}
		
		DishJudge dishJudgeParam = new DishJudge();
		dishJudgeParam.setDish(new Dish(dishId));
		dishJudgeParam.setJudgeBy(UserUtils.getUser());
		List<DishJudge> dishJudges= dishJudgeService.findList(dishJudgeParam);
		DishJudge dishJudge;
		if(dishJudges == null || dishJudges.size()==0){
			dishJudge = new DishJudge();
			dishJudge.setDish(new Dish(dishId));
			dishJudge.setJudgeBy(UserUtils.getUser());
			dishJudge.setJudgeLevel(level);
		}else {
			dishJudge = dishJudges.get(0);
			dishJudge.setJudgeLevel(level);
		}
		BigDecimal score = dishJudgeService.judgeSave(dishJudge);
		return "{\"status\":\"1\",\"score\":\""+score+"\",\"message\":\"菜谱评价成功\"}";
	}
	
	/**
	 * 菜品评价表单
	 * @param dishId
	 * @param dietJudge
	 * @param model
	 * @return
	 */
	@RequiresPermissions("hrm:di:dishJudge:edit")
	@RequestMapping(value = "judgeForm")
	public String judgeForm(String dishId, DishJudge dishJudge, Model model) {
		Dish dish = dishService.get(dishId);
		dishJudge.setDish(dish);
		dishJudge.setJudgeBy(UserUtils.getUser());
		model.addAttribute("dishJudge", dishJudge);
		return "modules/hrm/di/my/myDishJudgeForm";
	}
	
	/**
	 * 菜品评价保存
	 * @param dishJudge
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("hrm:di:dishJudge:edit")
	@RequestMapping(value = "judgeSave")
	public String judgeSave(DishJudge dishJudge, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dishJudge)){
			return judgeForm(dishJudge.getDish().getId(), dishJudge, model);
		}
		dishJudgeService.judgeSave(dishJudge);
		addMessage(redirectAttributes, "保存日常菜品评价成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/myDish/?repage&dietId="+dishJudge.getDish().getDiet().getId();
	}

    @RequiresPermissions("hrm:di:dishJudge:view")
    @RequestMapping(value = "info")
    public String info(String dishId, DishJudge dishJudge, Model model) {
    	Dish dish = dishService.get(dishId);
		dishJudge.setDish(dish);
		dishJudge.setJudgeBy(UserUtils.getUser());
		model.addAttribute("dishJudge", dishJudge);
        return "modules/hrm/di/my/myDishJudgeInfo";
    }
}