/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.se;

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
import com.chinazhoufan.admin.modules.idx.entity.se.SeHotWord;
import com.chinazhoufan.admin.modules.idx.service.se.SeHotWordService;

/**
 * 搜索热词Controller
 * @author liut
 * @version 2016-11-09
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/se/seHotWord")
public class SeHotWordController extends BaseController {

	@Autowired
	private SeHotWordService seHotWordService;
	
	@ModelAttribute
	public SeHotWord get(@RequestParam(required=false) String id) {
		SeHotWord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = seHotWordService.get(id);
		}
		if (entity == null){
			entity = new SeHotWord();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:se:seHotWord:view")
	@RequestMapping(value = {"list", ""})
	public String list(SeHotWord seHotWord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SeHotWord> page = seHotWordService.findPage(new Page<SeHotWord>(request, response), seHotWord); 
		model.addAttribute("page", page);
		return "modules/idx/se/seHotWordList";
	}

	@RequiresPermissions("idx:se:seHotWord:view")
	@RequestMapping(value = "form")
	public String form(SeHotWord seHotWord, Model model) {
		if(StringUtils.isBlank(seHotWord.getId())) {
			seHotWord.setUsableFlag(SeHotWord.TRUE_FLAG);
		}
		model.addAttribute("seHotWord", seHotWord);
		return "modules/idx/se/seHotWordForm";
	}

	@RequiresPermissions("idx:se:seHotWord:edit")
	@RequestMapping(value = "save")
	public String save(SeHotWord seHotWord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, seHotWord)){
			return form(seHotWord, model);
		}
		seHotWordService.save(seHotWord);
		addMessage(redirectAttributes, "保存搜索热词成功");
		return "redirect:"+Global.getAdminPath()+"/idx/se/seHotWord/?repage";
	}
	
	@RequiresPermissions("idx:se:seHotWord:edit")
	@RequestMapping(value = "delete")
	public String delete(SeHotWord seHotWord, RedirectAttributes redirectAttributes) {
		seHotWordService.delete(seHotWord);
		addMessage(redirectAttributes, "删除搜索热词成功");
		return "redirect:"+Global.getAdminPath()+"/idx/se/seHotWord/?repage";
	}

    @RequiresPermissions("idx:se:seHotWord:view")
    @RequestMapping(value = "info")
    public String info(SeHotWord seHotWord, Model model) {
        model.addAttribute("seHotWord", seHotWord);
        return "modules/idx/se/seHotWordInfo";
    }
}