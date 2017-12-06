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
import com.chinazhoufan.admin.modules.hrm.entity.di.DietJudge;
import com.chinazhoufan.admin.modules.hrm.service.di.DietJudgeService;
import com.chinazhoufan.admin.modules.hrm.service.di.DietService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 我的日常菜谱Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/hrm/di/myDiet")
public class MyDietController extends BaseController {

	@Autowired
	private DietJudgeService dietJudgeService;
	@Autowired
	private DietService dietService;
	
	
	@ModelAttribute
	public DietJudge get(@RequestParam(required=false) String id) {
		DietJudge entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dietJudgeService.get(id);
		}
		if (entity == null){
			entity = new DietJudge();
		}
		return entity;
	}
	
	/**
	 * 菜谱（评价）列表
	 * @param diet
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("hrm:di:dietJudge:view")
	@RequestMapping(value = {"list", ""})
	public String list(Diet diet, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(diet.getDietJudge() == null){
			diet.setDietJudge(new DietJudge());
		}
		diet.getDietJudge().setJudgeBy(UserUtils.getUser());
		Page<Diet> page = dietService.findPageWithCurrentJudge(new Page<Diet>(request, response), diet); 
		model.addAttribute("page", page);
		return "modules/hrm/di/my/myDietList";
	}
	
	/**AJAX
	 * 评价菜谱
	 * @param dietId	菜谱ID
	 * @param level		评价级别
	 * @param request
	 * @return
	 */
	@RequiresPermissions("hrm:di:dietJudge:edit")
	@ResponseBody
	@RequestMapping(value = "judge/{dietId}", method = RequestMethod.POST)
	public String judge(
			@PathVariable("dietId")String dietId, 
			@RequestParam(required=false)String level, 
			HttpServletRequest request) {
		if(StringUtils.isBlank(dietId) || StringUtils.isBlank(level)){
			return "{\"status\":\"0\",\"message\":\"菜谱评价失败：未能获取到菜谱标记或评价级别\"}";
		}
		
		DietJudge dietJudgeParam = new DietJudge();
		dietJudgeParam.setDiet(new Diet(dietId));
		dietJudgeParam.setJudgeBy(UserUtils.getUser());
		List<DietJudge> dietJudges= dietJudgeService.findList(dietJudgeParam);
		DietJudge dietJudge;
		if(dietJudges == null || dietJudges.size()==0){
			dietJudge = new DietJudge();
			dietJudge.setDiet(new Diet(dietId));
			dietJudge.setJudgeBy(UserUtils.getUser());
			dietJudge.setJudgeLevel(level);
		}else {
			dietJudge = dietJudges.get(0);
			dietJudge.setJudgeLevel(level);
		}
		BigDecimal score = dietJudgeService.judgeSave(dietJudge);
		return "{\"status\":\"1\",\"score\":\""+score+"\",\"message\":\"菜谱评价成功\"}";
	}

	/**
	 * 菜谱评价表单
	 * @param dietId
	 * @param dietJudge
	 * @param model
	 * @return
	 */
	@RequiresPermissions("hrm:di:dietJudge:view")
	@RequestMapping(value = "judgeForm")
	public String judgeForm(String dietId, DietJudge dietJudge, Model model) {
		Diet diet = dietService.get(dietId);
		dietJudge.setDiet(diet);
		dietJudge.setJudgeBy(UserUtils.getUser());
		model.addAttribute("dietJudge", dietJudge);
		return "modules/hrm/di/my/myDietJudgeForm";
	}

	/**
	 * 菜谱评价保存
	 * @param dietJudge
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("hrm:di:dietJudge:edit")
	@RequestMapping(value = "judgeSave")
	public String judgeSave(DietJudge dietJudge, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dietJudge)){
			return judgeForm(dietJudge.getDiet().getId(), dietJudge, model);
		}
		dietJudgeService.judgeSave(dietJudge);
		addMessage(redirectAttributes, "保存日常菜谱评价成功");
		return "redirect:"+Global.getAdminPath()+"/hrm/di/myDiet/?repage";
	}

    @RequiresPermissions("hrm:di:dietJudge:view")
    @RequestMapping(value = "info")
    public String info(String dietId, DietJudge dietJudge, Model model) {
    	Diet diet = dietService.get(dietId);
		dietJudge.setDiet(diet);
		dietJudge.setJudgeBy(UserUtils.getUser());
		model.addAttribute("dietJudge", dietJudge);
        return "modules/hrm/di/my/myDietJudgeInfo";
    }
}