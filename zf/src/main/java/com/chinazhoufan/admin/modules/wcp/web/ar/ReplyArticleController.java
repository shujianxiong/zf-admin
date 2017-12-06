/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.web.ar;

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
import com.chinazhoufan.admin.modules.wcp.entity.ar.ReplyArticle;
import com.chinazhoufan.admin.modules.wcp.service.ar.ReplyArticleService;

/**
 * 回复图文关联表Controller
 * @author liut
 * @version 2016-05-25
 */
@Controller
@RequestMapping(value = "${adminPath}/wcp/ar/replyArticle")
public class ReplyArticleController extends BaseController {

	@Autowired
	private ReplyArticleService replyArticleService;
	
	@ModelAttribute
	public ReplyArticle get(@RequestParam(required=false) String id) {
		ReplyArticle entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = replyArticleService.get(id);
		}
		if (entity == null){
			entity = new ReplyArticle();
		}
		return entity;
	}
	
	@RequiresPermissions("wcp:ar:replyArticle:view")
	@RequestMapping(value = {"list", ""})
	public String list(ReplyArticle replyArticle, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ReplyArticle> page = replyArticleService.findPage(new Page<ReplyArticle>(request, response), replyArticle); 
		model.addAttribute("page", page);
		return "modules/wcp/ar/replyArticleList";
	}

	@RequiresPermissions("wcp:ar:replyArticle:view")
	@RequestMapping(value = "form")
	public String form(ReplyArticle replyArticle, Model model) {
		model.addAttribute("replyArticle", replyArticle);
		return "modules/wcp/ar/replyArticleForm";
	}

	@RequiresPermissions("wcp:ar:replyArticle:edit")
	@RequestMapping(value = "save")
	public String save(ReplyArticle replyArticle, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, replyArticle)){
			return form(replyArticle, model);
		}
		replyArticleService.save(replyArticle);
		addMessage(redirectAttributes, "保存回复图文关联表成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/replyArticle/?repage";
	}
	
	@RequiresPermissions("wcp:ar:replyArticle:edit")
	@RequestMapping(value = "delete")
	public String delete(ReplyArticle replyArticle, RedirectAttributes redirectAttributes) {
		if(replyArticle == null || StringUtils.isBlank(replyArticle.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的图文关联记录！");
			return "error/400";
		}
		
		replyArticleService.delete(replyArticle);
		addMessage(redirectAttributes, "删除回复图文关联表成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/replyArticle/?repage";
	}

	@RequiresPermissions("wcp:ar:replyArticle:view")
	@RequestMapping(value = "info")
	public String info(ReplyArticle replyArticle, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(replyArticle == null || StringUtils.isBlank(replyArticle.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的图文关联记录！");
			return "error/400";
		}
		
		model.addAttribute("replyArticle", replyArticle);
		return "modules/wcp/ar/replyArticleInfo";
	}
}