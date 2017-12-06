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
import com.chinazhoufan.admin.modules.spm.entity.ar.ArticleRecord;
import com.chinazhoufan.admin.modules.spm.service.ar.ArticleRecordService;

/**
 * 宣传文章阅读记录Controller
 * @author 刘晓东
 * @version 2016-05-27
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/ar/articleRecord")
public class ArticleRecordController extends BaseController {

	@Autowired
	private ArticleRecordService articleRecordService;
	
	@ModelAttribute
	public ArticleRecord get(@RequestParam(required=false) String id) {
		ArticleRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = articleRecordService.get(id);
		}
		if (entity == null){
			entity = new ArticleRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:ar:articleRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(ArticleRecord articleRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ArticleRecord> page = articleRecordService.findPage(new Page<ArticleRecord>(request, response), articleRecord); 
		model.addAttribute("page", page);
		return "modules/spm/ar/articleRecordList";
	}

	@RequiresPermissions("spm:ar:articleRecord:view")
	@RequestMapping(value = "info")
	public String info(ArticleRecord articleRecord, HttpServletRequest request, HttpServletResponse response,  Model model) {
		if(articleRecord == null || StringUtils.isBlank(articleRecord.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的宣传文章阅读记录信息！");
			return "error/400";
		}
		
		model.addAttribute("articleRecord", articleRecord);
		return "modules/spm/ar/articleRecordInfo";
	}
	
	@RequiresPermissions("spm:ar:articleRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(ArticleRecord articleRecord, RedirectAttributes redirectAttributes) {
		if(articleRecord == null || StringUtils.isBlank(articleRecord.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的宣传文章阅读记录！");
			return "error/400";
		}
		
		articleRecordService.delete(articleRecord);
		addMessage(redirectAttributes, "删除宣传文章阅读记录成功");
		return "redirect:"+Global.getAdminPath()+"/spm/ar/articleRecord/?repage";
	}

}