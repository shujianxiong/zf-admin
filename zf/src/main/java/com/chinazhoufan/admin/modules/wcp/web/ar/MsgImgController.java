/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.wcp.entity.ar.MsgImg;
import com.chinazhoufan.admin.modules.wcp.service.ar.MsgImgService;

/**
 * 图文内置图片Controller
 * @author 舒剑雄
 * @version 2017-09-20
 */
@Controller
@RequestMapping(value = "${adminPath}/wcp/ar/msgImg")
public class MsgImgController extends BaseController {

	@Autowired
	private MsgImgService msgImgService;
	
	@ModelAttribute
	public MsgImg get(@RequestParam(required=false) String id) {
		MsgImg entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = msgImgService.get(id);
		}
		if (entity == null){
			entity = new MsgImg();
		}
		return entity;
	}
	
	@RequiresPermissions("wcp:ar:msgImg:view")
	@RequestMapping(value = {"list", ""})
	public String list(MsgImg msgImg, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MsgImg> page = msgImgService.findPage(new Page<MsgImg>(request, response), msgImg); 
		model.addAttribute("page", page);
		return "modules/wcp/ar/msgImgList";
	}

	@RequiresPermissions("wcp:ar:msgImg:view")
	@RequestMapping(value = "form")
	public String form(MsgImg msgImg, Model model) {
		model.addAttribute("msgImg", msgImg);
		return "modules/wcp/ar/msgImgForm";
	}

	@RequiresPermissions("wcp:ar:msgImg:edit")
	@RequestMapping(value = "save")
	public String save(MsgImg msgImg, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, msgImg)){
			return form(msgImg, model);
		}
		msgImgService.save(msgImg);
		addMessage(redirectAttributes, "保存图文内置图片成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/msgImg/?repage";
	}
	
	@RequiresPermissions("wcp:ar:msgImg:edit")
	@RequestMapping(value = "delete")
	public String delete(MsgImg msgImg, RedirectAttributes redirectAttributes) {
		msgImgService.delete(msgImg);
		addMessage(redirectAttributes, "删除图文内置图片成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/ar/msgImg/?repage";
	}

    @RequiresPermissions("wcp:ar:msgImg:view")
    @RequestMapping(value = "info")
    public String info(MsgImg msgImg, Model model) {
        model.addAttribute("msgImg", msgImg);
        return "modules/wcp/ar/msgImgInfo";
    }
}