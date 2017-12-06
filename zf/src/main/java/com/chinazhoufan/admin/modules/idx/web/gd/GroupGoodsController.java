/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.gd;

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
import com.chinazhoufan.admin.modules.idx.entity.gd.GroupGoods;
import com.chinazhoufan.admin.modules.idx.service.gd.GroupGoodsService;

/**
 * 搭配分组商品Controller
 * @author liut
 * @version 2017-03-15
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/gd/groupGoods")
public class GroupGoodsController extends BaseController {

	@Autowired
	private GroupGoodsService groupGoodsService;
	
	@ModelAttribute
	public GroupGoods get(@RequestParam(required=false) String id) {
		GroupGoods entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = groupGoodsService.get(id);
		}
		if (entity == null){
			entity = new GroupGoods();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:gd:groupGoods:view")
	@RequestMapping(value = {"list", ""})
	public String list(GroupGoods groupGoods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GroupGoods> page = groupGoodsService.findPage(new Page<GroupGoods>(request, response), groupGoods); 
		model.addAttribute("page", page);
		return "modules/idx/gd/groupGoodsList";
	}

	@RequiresPermissions("idx:gd:groupGoods:view")
	@RequestMapping(value = "form")
	public String form(GroupGoods groupGoods, Model model) {
		model.addAttribute("groupGoods", groupGoods);
		return "modules/idx/gd/groupGoodsForm";
	}

	@RequiresPermissions("idx:gd:groupGoods:edit")
	@RequestMapping(value = "save")
	public String save(GroupGoods groupGoods, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, groupGoods)){
			return form(groupGoods, model);
		}
		groupGoodsService.save(groupGoods);
		addMessage(redirectAttributes, "保存搭配分组商品成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/groupGoods/?repage";
	}
	
	@RequiresPermissions("idx:gd:groupGoods:edit")
	@RequestMapping(value = "delete")
	public String delete(GroupGoods groupGoods, RedirectAttributes redirectAttributes) {
		groupGoodsService.delete(groupGoods);
		addMessage(redirectAttributes, "删除搭配分组商品成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/groupGoods/?repage";
	}

    @RequiresPermissions("idx:gd:groupGoods:view")
    @RequestMapping(value = "info")
    public String info(GroupGoods groupGoods, Model model) {
        model.addAttribute("groupGoods", groupGoods);
        return "modules/idx/gd/groupGoodsInfo";
    }
}