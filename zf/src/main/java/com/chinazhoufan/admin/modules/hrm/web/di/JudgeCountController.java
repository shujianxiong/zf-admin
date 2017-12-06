/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.web.di;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.hrm.entity.di.Dish;
import com.chinazhoufan.admin.modules.hrm.service.di.DietService;
import com.chinazhoufan.admin.modules.hrm.service.di.DishService;

/**
 * 菜谱菜谱评价统计Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/judgeCount")
public class JudgeCountController extends BaseController {

	@Autowired
	private DietService dietService;
	@Autowired
	private DishService dishService;
	
	
	@RequiresPermissions("hrm:di:judgeCount:view")
	@RequestMapping(value = {"count", ""})
	public String count(Date beginDate, Date endDate, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		BigDecimal dietScore = dietService.countScore(beginDate, endDate);
		List<Dish> dishes = dishService.countScore(beginDate, endDate);
		
		
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("dietScore", dietScore);
		model.addAttribute("dishes", dishes);
		return "modules/hrm/di/judgeCount";
	}

}