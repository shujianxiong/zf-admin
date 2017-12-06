/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.ar;

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
import com.chinazhoufan.admin.modules.spm.entity.ar.ArArticle;
import com.chinazhoufan.admin.modules.spm.service.ar.ArArticleService;

/**
 * 宣传文章Controller
 * @author 张金俊
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ar/arArticle")
public class ArArticleController extends BaseController {

	@Autowired
	private ArArticleService arArticleService;
	
	@ModelAttribute
	public ArArticle get(@RequestParam(required=false) String id) {
		ArArticle entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = arArticleService.get(id);
		}
		if (entity == null){
			entity = new ArArticle();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ar:arArticle:view")
	@RequestMapping(value = {"list", ""})
	public String list(ArArticle arArticle, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ArArticle> page = arArticleService.findPage(new Page<ArArticle>(request, response), arArticle); 
		model.addAttribute("page", page);
		return "modules/spm/ar/arArticleList";
	}

	@RequiresPermissions("spm:ar:arArticle:view")
	@RequestMapping(value = "info")
	public String info(ArArticle arArticle, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(arArticle == null || StringUtils.isBlank(arArticle.getId())) {
			addMessage(model, "友情提示：未能获取到要删除的宣传文章信息！");
			return "error/400";
		}
		
		model.addAttribute("arArticle", arArticle);
		return "modules/spm/ar/arArticleInfo";
	}
	
	@RequiresPermissions("spm:ar:arArticle:view")
	@RequestMapping(value = "form")
	public String form(ArArticle arArticle, Model model) {
		if (StringUtils.isBlank(arArticle.getId())){
			arArticle.setActiveFlag(ArArticle.TRUE_FLAG);
		}
		model.addAttribute("arArticle", arArticle);
		return "modules/spm/ar/arArticleForm";
	}

	@RequiresPermissions("spm:ar:arArticle:edit")
	@RequestMapping(value = "save")
	public String save(ArArticle arArticle, Model model, RedirectAttributes redirectAttributes) {
		if(StringUtils.isEmpty(arArticle.getId())){
			arArticle.setReadNum(0);
			arArticle.setLikeNum(0);
		}
		if (!beanValidator(model, arArticle)){
			return form(arArticle, model);
		}
		arArticleService.save(arArticle);
		addMessage(redirectAttributes, "保存宣传文章成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ar/arArticle/?repage";
	}
	
	@RequiresPermissions("spm:ar:arArticle:edit")
	@RequestMapping(value = "delete")
	public String delete(ArArticle arArticle, RedirectAttributes redirectAttributes) {
		if(arArticle == null || StringUtils.isBlank(arArticle.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要查看的宣传文章信息！");
			return "error/400";
		}
		
		arArticleService.delete(arArticle);
		addMessage(redirectAttributes, "删除宣传文章成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ar/arArticle/?repage";
	}

}