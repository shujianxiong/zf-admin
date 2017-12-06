/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.bs;

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
import com.chinazhoufan.admin.modules.lgt.entity.bs.Designer;
import com.chinazhoufan.admin.modules.lgt.service.bs.DesignerService;

/**
 * 设计师Controller
 * @author 张金俊
 * @version 2016-08-17
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/bs/designer")
public class DesignerController extends BaseController {

	@Autowired
	private DesignerService designerService;
	
	@ModelAttribute
	public Designer get(@RequestParam(required=false) String id) {
		Designer entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = designerService.get(id);
		}
		if (entity == null){
			entity = new Designer();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:bs:designer:view")
	@RequestMapping(value = {"list", ""})
	public String list(Designer designer, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Designer> page = designerService.findPage(new Page<Designer>(request, response), designer); 
		model.addAttribute("page", page);
		return "modules/lgt/bs/designerList";
	}
	
	@RequiresPermissions("lgt:bs:designer:view")
	@RequestMapping(value = "info")
	public String info(Designer designer, Model model) {
		model.addAttribute("designer", designer);
		return "modules/lgt/bs/designerInfo";
	}

	@RequiresPermissions("lgt:bs:designer:view")
	@RequestMapping(value = "form")
	public String form(Designer designer, Model model) {
		if(designer != null && StringUtils.isBlank(designer.getId())) {
			designer.setUsableFlag(Designer.TRUE_FLAG);
			designer.setRecommendFlag(Designer.TRUE_FLAG);
		}
		model.addAttribute("designer", designer);
		return "modules/lgt/bs/designerForm";
	}

	@RequiresPermissions("lgt:bs:designer:edit")
	@RequestMapping(value = "save")
	public String save(Designer designer, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, designer)){
			return form(designer, model);
		}
		designerService.save(designer);
		addMessage(redirectAttributes, "保存设计师成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/designer/?repage";
	}
	
	@RequiresPermissions("lgt:bs:designer:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(Designer designer, Model model, RedirectAttributes redirectAttributes){
		designer = designerService.get(designer.getId());
		if(designer.getUsableFlag().equals(Designer.TRUE_FLAG)){
			designer.setUsableFlag(Designer.FALSE_FLAG);;
		}else {
			designer.setUsableFlag(Designer.TRUE_FLAG);
		}
		designerService.save(designer);
		addMessage(redirectAttributes, "设计师状态修改成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/designer/list?repage";
	}
	
	@RequiresPermissions("lgt:bs:designer:edit")
	@RequestMapping(value = "delete")
	public String delete(Designer designer, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(designer.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的设计师信息！");
			return "error/400";
		}
		designerService.delete(designer);
		addMessage(redirectAttributes, "删除设计师成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/bs/designer/?repage";
	}

	/**
	 * 设计师选择器
	 * @param brand
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:bs:designer:view")
	@RequestMapping(value = "select")
	public String select(Designer designer, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Designer> page = designerService.findPage(new Page<Designer>(request, response), designer); 
		model.addAttribute("page", page);
		return "modules/lgt/bs/designerSelect";
	}
	
}