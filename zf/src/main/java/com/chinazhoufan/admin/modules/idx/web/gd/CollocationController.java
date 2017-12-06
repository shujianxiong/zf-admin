/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.gd;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.idx.entity.gd.CollocationGroup;
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;
import com.chinazhoufan.admin.modules.idx.service.gd.CollocationGroupService;
import com.chinazhoufan.admin.modules.idx.service.gd.CollocationService;
import com.chinazhoufan.admin.modules.idx.service.gd.SceneService;

/**
 * 搭配Controller
 * @author liut
 * @version 2017-03-15
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/gd/collocation")
public class CollocationController extends BaseController {

	@Autowired
	private CollocationService collocationService;
	@Autowired
	private SceneService sceneService;
	@Autowired
	private CollocationGroupService ccgService;
	
	@ModelAttribute
	public Collocation get(@RequestParam(required=false) String id) {
		Collocation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = collocationService.get(id);
		}
		if (entity == null){
			entity = new Collocation();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:gd:collocation:view")
	@RequestMapping(value = {"list", ""})
	public String list(Collocation collocation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Collocation> page = collocationService.findPage(new Page<Collocation>(request, response), collocation); 
		model.addAttribute("page", page);
		return "modules/idx/gd/collocationList";
	}

	@RequiresPermissions("idx:gd:collocation:view")
	@RequestMapping(value = "form")
	public String form(Collocation collocation, Model model) {
		if(StringUtils.isNotBlank(collocation.getId())) {
			Scene scene = sceneService.get(collocation.getScene().getId());
			collocation.setScene(scene);
		}
		List<Scene> sceneParentList = sceneService.findParentList(new Scene());
		List<Scene> sceneSubList = sceneService.findSubList(new Scene());
		model.addAttribute("sceneParentList", sceneParentList);
		model.addAttribute("sceneSubList", sceneSubList);
		return "modules/idx/gd/collocationForm";
	}

	@RequiresPermissions("idx:gd:collocation:edit")
	@RequestMapping(value = "save")
	public String save(Collocation collocation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, collocation)){
			return form(collocation, model);
		}
		collocationService.save(collocation);
		addMessage(redirectAttributes, "保存搭配成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/collocation/?repage";
	}
	
	@RequiresPermissions("idx:gd:collocation:edit")
	@RequestMapping(value = "delete")
	public String delete(Collocation collocation, RedirectAttributes redirectAttributes) {
		collocationService.delete(collocation);
		addMessage(redirectAttributes, "删除搭配成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/collocation/?repage";
	}

    @RequiresPermissions("idx:gd:collocation:view")
    @RequestMapping(value = "info")
    public String info(Collocation collocation, Model model) {
        model.addAttribute("collocation", collocation);
        return "modules/idx/gd/collocationInfo";
    }
    
    
    @RequiresPermissions("idx:gd:collocation:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(Collocation collocation, RedirectAttributes redirectAttributes) {
    	collocation.setUsableFlag(Collocation.TRUE_FLAG.equals(collocation.getUsableFlag()) ? Collocation.FALSE_FLAG : Collocation.TRUE_FLAG);
		collocationService.save(collocation);
		addMessage(redirectAttributes, (Scene.TRUE_FLAG.equals(collocation.getUsableFlag()) ? "启用" : "停用")+"搭配成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/collocation/?repage";
    }
    
    @RequiresPermissions("idx:gd:collocation:edit")
    @RequestMapping(value = "updateRecommandFlag")
    public String updateRecommandFlag(Collocation collocation, RedirectAttributes redirectAttributes) {
    	collocation.setRecommendFlag(Collocation.TRUE_FLAG.equals(collocation.getRecommendFlag()) ? Collocation.FALSE_FLAG : Collocation.TRUE_FLAG);
		collocationService.save(collocation);
		addMessage(redirectAttributes, (Scene.TRUE_FLAG.equals(collocation.getRecommendFlag()) ? "搭配默认推荐" : "搭配取消默认推荐")+"成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/collocation/?repage";
    }
    
    
}