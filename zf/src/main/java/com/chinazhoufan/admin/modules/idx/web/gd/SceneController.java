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
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;
import com.chinazhoufan.admin.modules.idx.service.gd.SceneService;

/**
 * 场景Controller
 * @author liut
 * @version 2017-03-15
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/gd/scene")
public class SceneController extends BaseController {

	@Autowired
	private SceneService sceneService;
	
	@ModelAttribute
	public Scene get(@RequestParam(required=false) String id) {
		Scene entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sceneService.get(id);
		}
		if (entity == null){
			entity = new Scene();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:gd:scene:view")
	@RequestMapping(value = {"list", ""})
	public String list(Scene scene, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Scene> page = sceneService.findPage(new Page<Scene>(request, response), scene); 
		model.addAttribute("page", page);
		return "modules/idx/gd/sceneList";
	}
	
	
	/**
	 * 列出父场景集合
	 * @param scene
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("idx:gd:scene:view")
	@RequestMapping(value = "findParentList")
	public String findParentList(Scene scene, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Scene> page = sceneService.findParentPage(new Page<Scene>(request, response), scene); 
		model.addAttribute("page", page);
		return "modules/idx/gd/sceneParentList";
	}
	
	
	@RequiresPermissions("idx:gd:scene:view")
	@RequestMapping(value = "findSubList")
	public String findSubList(Scene scene, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Scene> list = sceneService.findSubList(scene);
		model.addAttribute("list", list);
		model.addAttribute("scene", scene);
		return "modules/idx/gd/sceneSubList";
	}
	
	/**
	 * 选择场景列表
	 * @param scene
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "selectSceneList")
	public String selectSceneList(Scene scene, HttpServletRequest request, HttpServletResponse response, Model model) {
		scene.setUsableFlag(Scene.TRUE_FLAG);
		Page<Scene> page = sceneService.findParentPage(new Page<Scene>(request, response), scene); 
		model.addAttribute("page", page);
		return "modules/idx/gd/selectSceneList";
	}

	@RequiresPermissions("idx:gd:scene:view")
	@RequestMapping(value = "form")
	public String form(Scene scene, Model model) {
		if(scene.getScene() != null) {
			Scene parent = sceneService.get(scene.getScene().getId());
			scene.setScene(parent);
		}
		/*List<Scene> sceneList = sceneService.findList(new Scene());
		model.addAttribute("sceneList", sceneList);*/
		model.addAttribute("scene", scene);
		return "modules/idx/gd/sceneForm";
	}

	@RequiresPermissions("idx:gd:scene:edit")
	@RequestMapping(value = "save")
	public String save(Scene scene, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, scene)){
			return form(scene, model);
		}
		sceneService.save(scene);
		if(scene.getSubType() == 1) {
			addMessage(redirectAttributes, "保存子场景成功");
			return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findSubList?scene.id="+scene.getScene().getId();
		} else {
			addMessage(redirectAttributes, "保存场景成功");
			return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findParentList";
		}
	}
	
	@RequiresPermissions("idx:gd:scene:edit")
	@RequestMapping(value = "delete")
	public String delete(Scene scene, RedirectAttributes redirectAttributes) {
		Integer flag = sceneService.deleteByScene(scene);
		if(flag > 0) {
			if(scene.getSubType() == 1) {
				addMessage(redirectAttributes, "删除失败：该子场景已被搭配使用，请先解除与搭配的绑定关系");
				return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findSubList?scene.id="+scene.getScene().getId();
			} else {
				addMessage(redirectAttributes, "删除失败：当前场景存在子场景，不能删除，请先删除关联的子场景");
				return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findParentList";
			}
		} else {
			if(scene.getSubType() == 1) {
				addMessage(redirectAttributes, "删除子场景成功");
				return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findSubList?scene.id="+scene.getScene().getId();
			} else {
				addMessage(redirectAttributes, "删除场景成功");
				return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findParentList";
			}
		}
	}

    @RequiresPermissions("idx:gd:scene:view")
    @RequestMapping(value = "info")
    public String info(Scene scene, Model model) {
        model.addAttribute("scene", scene);
        return "modules/idx/gd/sceneInfo";
    }
    
    @RequiresPermissions("idx:gd:scene:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(Scene scene, String type, RedirectAttributes redirectAttributes) {
    	if(StringUtils.isBlank(type)) {
    		addMessage(redirectAttributes, "友情提示：参数不完整，请核查");
    		return "error/404";
    	}
    	if("I".equals(type)) {
    		scene.setIndexFlag(Scene.TRUE_FLAG.equals(scene.getIndexFlag()) ? Scene.FALSE_FLAG : Scene.TRUE_FLAG);
    	} else if("U".equals(type)) {
    		scene.setUsableFlag(Scene.TRUE_FLAG.equals(scene.getUsableFlag()) ? Scene.FALSE_FLAG : Scene.TRUE_FLAG);
    	}
    	sceneService.save(scene);
    	if(scene.getSubType() == 1) {
    		if("I".equals(type)) {
    			addMessage(redirectAttributes, (Scene.TRUE_FLAG.equals(scene.getIndexFlag()) ? "推荐" : "取消推荐")+"子场景成功");
    		} else if("U".equals(type)) {
    			addMessage(redirectAttributes, (Scene.TRUE_FLAG.equals(scene.getUsableFlag()) ? "启用" : "停用")+"子场景成功");
    		}
			return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findSubList?scene.id="+scene.getScene().getId();
		} else {
			if("I".equals(type)) {
				addMessage(redirectAttributes, (Scene.TRUE_FLAG.equals(scene.getIndexFlag()) ? "推荐" : "取消推荐")+"场景成功");
			} else if("U".equals(type)) {
				addMessage(redirectAttributes, (Scene.TRUE_FLAG.equals(scene.getUsableFlag()) ? "启用" : "停用")+"场景成功");
			}
			return "redirect:"+Global.getAdminPath()+"/idx/gd/scene/findParentList";
		}
    }
    
}