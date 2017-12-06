/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.pj;

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
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudgePhoto;
import com.chinazhoufan.admin.modules.bus.service.pj.ProduceJudgePhotoService;

/**
 * 产品评价图片Controller
 * @author liut
 * @version 2017-07-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/pj/produceJudgePhoto")
public class ProduceJudgePhotoController extends BaseController {

	@Autowired
	private ProduceJudgePhotoService produceJudgePhotoService;
	
	@ModelAttribute
	public ProduceJudgePhoto get(@RequestParam(required=false) String id) {
		ProduceJudgePhoto entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = produceJudgePhotoService.get(id);
		}
		if (entity == null){
			entity = new ProduceJudgePhoto();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:pj:produceJudgePhoto:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProduceJudgePhoto produceJudgePhoto, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProduceJudgePhoto> page = produceJudgePhotoService.findPage(new Page<ProduceJudgePhoto>(request, response), produceJudgePhoto); 
		model.addAttribute("page", page);
		return "modules/bus/pj/produceJudgePhotoList";
	}

	@RequiresPermissions("bus:pj:produceJudgePhoto:view")
	@RequestMapping(value = "form")
	public String form(ProduceJudgePhoto produceJudgePhoto, Model model) {
		model.addAttribute("produceJudgePhoto", produceJudgePhoto);
		return "modules/bus/pj/produceJudgePhotoForm";
	}

	@RequiresPermissions("bus:pj:produceJudgePhoto:edit")
	@RequestMapping(value = "save")
	public String save(ProduceJudgePhoto produceJudgePhoto, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, produceJudgePhoto)){
			return form(produceJudgePhoto, model);
		}
		produceJudgePhotoService.save(produceJudgePhoto);
		addMessage(redirectAttributes, "保存产品评价图片成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudgePhoto/?repage";
	}
	
	@RequiresPermissions("bus:pj:produceJudgePhoto:edit")
	@RequestMapping(value = "delete")
	public String delete(ProduceJudgePhoto produceJudgePhoto, RedirectAttributes redirectAttributes) {
		produceJudgePhotoService.delete(produceJudgePhoto);
		addMessage(redirectAttributes, "删除产品评价图片成功");
		return "redirect:"+Global.getAdminPath()+"/bus/pj/produceJudgePhoto/?repage";
	}

    @RequiresPermissions("bus:pj:produceJudgePhoto:view")
    @RequestMapping(value = "info")
    public String info(ProduceJudgePhoto produceJudgePhoto, Model model) {
        model.addAttribute("produceJudgePhoto", produceJudgePhoto);
        return "modules/bus/pj/produceJudgePhotoInfo";
    }
}