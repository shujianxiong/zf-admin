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
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;
import com.chinazhoufan.admin.modules.wcp.service.ar.ArticleMsgService;

/**
 * 图文消息表Controller
 * @author liut
 * @version 2016-05-25
 */
@Controller
@RequestMapping(value = "${adminPath}/wcp/ar/articleMsg")
public class ArticleMsgController extends BaseController {

	@Autowired
	private ArticleMsgService articleMsgService;
	
	@ModelAttribute
	public ArticleMsg get(@RequestParam(required=false) String id) {
		ArticleMsg entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = articleMsgService.get(id);
		}
		if (entity == null){
			entity = new ArticleMsg();
		}
		return entity;
	}
	
	@RequiresPermissions("wcp:ar:articleMsg:view")
	@RequestMapping(value = {"list", ""})
	public String list(ArticleMsg articleMsg, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ArticleMsg> page = articleMsgService.findPage(new Page<ArticleMsg>(request, response), articleMsg); 
		model.addAttribute("page", page);
		return "modules/wcp/ar/articleMsgList";
	}

	@RequiresPermissions("wcp:ar:articleMsg:view")
	@RequestMapping(value = "form")
	public String form(ArticleMsg articleMsg, Model model) {
		model.addAttribute("articleMsg", articleMsg);
		return "modules/wcp/ar/articleMsgForm";
	}

	@RequiresPermissions("wcp:ar:articleMsg:edit")
	@RequestMapping(value = "save")
	public String save(ArticleMsg articleMsg, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, articleMsg)){
			return form(articleMsg, model);
		}
		articleMsgService.save(articleMsg);
		addMessage(redirectAttributes, "保存图文消息表成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/articleMsg/?repage";
	}
	
	@RequiresPermissions("wcp:ar:articleMsg:edit")
	@RequestMapping(value = "delete")
	public String delete(ArticleMsg articleMsg, RedirectAttributes redirectAttributes) {
		if(articleMsg == null || StringUtils.isBlank(articleMsg.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的图片消息信息！");
			return "error/400";
		}
		
		articleMsgService.delete(articleMsg);
		addMessage(redirectAttributes, "删除图文消息表成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/articleMsg/?repage";
	}

	@RequiresPermissions("wcp:ar:articleMsg:view")
	@RequestMapping(value = "info")
	public String info(ArticleMsg  articleMsg, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(articleMsg == null || StringUtils.isBlank(articleMsg.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的图片消息信息！");
			return "error/400";
		}
		model.addAttribute("articleMsg", articleMsg);
		return "modules/wcp/ar/articleMsgInfo";
	}
	
	@RequestMapping(value = "select")
	public String select(ArticleMsg articleMsg, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ArticleMsg> page = articleMsgService.findPage(new Page<ArticleMsg>(request, response), articleMsg); 
		model.addAttribute("page", page);
		return "modules/wcp/ar/articleMsgSelect";
	}
}