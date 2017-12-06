/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.web.ar;

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
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.wcp.entity.ar.AutoReply;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ReplyArticle;
import com.chinazhoufan.admin.modules.wcp.service.ar.AutoReplyService;
import com.chinazhoufan.admin.modules.wcp.service.ar.ReplyArticleService;

/**
 * 自动回复表Controller
 * @author liut
 * @version 2016-05-25
 */
@Controller
@RequestMapping(value = "${adminPath}/wcp/ar/autoReply")
public class AutoReplyController extends BaseController {

	@Autowired
	private AutoReplyService autoReplyService;
	@Autowired
	private ReplyArticleService replyArticleService;
	
	@ModelAttribute
	public AutoReply get(@RequestParam(required=false) String id) {
		AutoReply entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = autoReplyService.get(id);
		}
		if (entity == null){
			entity = new AutoReply();
		}
		return entity;
	}
	
	@RequiresPermissions("wcp:ar:autoReply:view")
	@RequestMapping(value = {"list", ""})
	public String list(AutoReply autoReply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AutoReply> page = autoReplyService.findPage(new Page<AutoReply>(request, response), autoReply); 
		List<AutoReply> list = page.getList();
		if(list != null && list.size() > 0) {
			ReplyArticle replyArticle = null;
			List<ReplyArticle> raList = null;
			for(AutoReply ar : list) {
				if(AutoReply.CONTENT_TYPE_NEWS.equals(ar.getContentType())) {
					replyArticle = new ReplyArticle();
					replyArticle.setAutoReply(ar);
					raList = replyArticleService.listByReply(replyArticle);
					ar.setReplyArticleList(raList);
				}
			}
		}
		model.addAttribute("page", page);
		return "modules/wcp/ar/autoReplyList";
	}

	@RequiresPermissions("wcp:ar:autoReply:view")
	@RequestMapping(value = "form")
	public String form(AutoReply autoReply, Model model) {
		if(StringUtils.isBlank(autoReply.getId())) {
			autoReply.setActiveFlag(AutoReply.TRUE_FLAG);
		}
		ReplyArticle ra = new ReplyArticle();
		ra.setAutoReply(autoReply);
		List<ReplyArticle> raList = replyArticleService.listByReply(ra);
		StringBuilder ids = new StringBuilder();
		StringBuilder names = new StringBuilder();
		for(ReplyArticle ar : raList) {
			ids.append(ar.getArticleMsg().getId()).append(",");
			names.append(ar.getArticleMsg().getName()).append(",");
		}
		autoReply.setArticleMsgIdList(ids.toString());
		autoReply.setArticleMsgNameList(names.toString());
		model.addAttribute("autoReply", autoReply);
		return "modules/wcp/ar/autoReplyForm";
	}

	@RequiresPermissions("wcp:ar:autoReply:edit")
	@RequestMapping(value = "save")
	public String save(AutoReply autoReply, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, autoReply)){
			return form(autoReply, model);
		}
		if(!StringUtils.isBlank(autoReply.getKeywords())) {
			autoReply.setKeywords(autoReply.getKeywords().replace("，", ","));
		}
		autoReplyService.save(autoReply);
		addMessage(redirectAttributes, "保存自动回复表成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/autoReply/?repage";
	}
	
	@RequiresPermissions("wcp:ar:autoReply:edit")
	@RequestMapping(value = "delete")
	public String delete(AutoReply autoReply, RedirectAttributes redirectAttributes) {
		if(autoReply == null || StringUtils.isBlank(autoReply.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的自动回复记录！");
			return "error/400";
		}
		autoReplyService.delete(autoReply);
		addMessage(redirectAttributes, "删除自动回复表成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/autoReply/?repage";
	}

	@RequiresPermissions("wcp:ar:autoReply:view")
	@RequestMapping(value = "info")
	public String info(AutoReply  autoReply,HttpServletRequest request, HttpServletResponse response,   Model model) {
		
		if(autoReply == null || StringUtils.isBlank(autoReply.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的自动回复记录！");
			return "error/400";
		}
		
		ReplyArticle ra = new ReplyArticle();
		ra.setAutoReply(autoReply);
		List<ReplyArticle> raList = replyArticleService.listByReply(ra);
		autoReply.setReplyArticleList(raList);
		model.addAttribute("autoReply", autoReply);
		return "modules/wcp/ar/autoReplyInfo";
	}
	
	@RequiresPermissions("wcp:ar:autoReply:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(AutoReply  autoReply, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(autoReply == null || StringUtils.isBlank(autoReply.getId())) {
			addMessage(model, "友情提示：未能获取到有效的自动回复记录！");
			return "error/400";
		}
		autoReplyService.updateStatus(autoReply);
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/autoReply/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value = "checkUniqueKeyworkdsOrCode")
	public String checkUniqueKeyworkdsOrCode(String keywords, String code) {
		if(!StringUtils.isBlank(keywords)) {
			keywords.replace("，", ",");
			AutoReply ar = new AutoReply(keywords, "");
			if(autoReplyService.getActivityByKeywords(ar).size() == 0) {
				return "{\"status\":\"1\"}";
			} else {
				return "{\"status\":\"0\"}";
			}
		} else if(!StringUtils.isBlank(code)) {
			AutoReply ar = new AutoReply("", code);
			if(autoReplyService.getActivityByCode(ar) == null) {
				return "{\"status\":\"1\"}";
			} else {
				return "{\"status\":\"0\"}";
			}
		} else {
			return "{\"status\":\"0\"}";
		}
	}
	
}