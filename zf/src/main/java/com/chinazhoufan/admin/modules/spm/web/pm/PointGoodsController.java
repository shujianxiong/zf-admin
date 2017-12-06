/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.web.pm;

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
import com.chinazhoufan.admin.modules.spm.entity.pm.PointGoods;
import com.chinazhoufan.admin.modules.spm.service.pm.PointGoodsService;

/**
 * 积分商品Controller
 * @author 张金俊
 * @version 2016-12-02
 */
@Controller
@RequestMapping(value = "${adminPath}/spm/pm/pointGoods")
public class PointGoodsController extends BaseController {

	@Autowired
	private PointGoodsService pointGoodsService;
	
	@ModelAttribute
	public PointGoods get(@RequestParam(required=false) String id) {
		PointGoods entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = pointGoodsService.get(id);
		}
		if (entity == null){
			entity = new PointGoods();
		}
		return entity;
	}
	
	@RequiresPermissions("spm:pm:pointGoods:view")
	@RequestMapping(value = {"list", ""})
	public String list(PointGoods pointGoods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<PointGoods> page = pointGoodsService.findPage(new Page<PointGoods>(request, response), pointGoods); 
		model.addAttribute("page", page);
		return "modules/spm/pm/pointGoodsList";
	}

	@RequiresPermissions("spm:pm:pointGoods:view")
	@RequestMapping(value = "form")
	public String form(PointGoods pointGoods, Model model) {
		if(StringUtils.isBlank(pointGoods.getId())) {
			pointGoods.setGainType(PointGoods.GAINTYPE_UNLIMITED);
			pointGoods.setSrcType(PointGoods.SRCTYPE_COUPON);
			pointGoods.setUpFlag(PointGoods.FALSE_FLAG);//默认是下架
		}
		model.addAttribute("pointGoods", pointGoods);
		return "modules/spm/pm/pointGoodsForm";
	}

	@RequiresPermissions("spm:pm:pointGoods:edit")
	@RequestMapping(value = "save")
	public String save(PointGoods pointGoods, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, pointGoods)){
			return form(pointGoods, model);
		}
		pointGoodsService.save(pointGoods);
		addMessage(redirectAttributes, "保存积分商品成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pm/pointGoods/?repage";
	}
	
	@RequiresPermissions("spm:pm:pointGoods:edit")
	@RequestMapping(value = "delete")
	public String delete(PointGoods pointGoods, RedirectAttributes redirectAttributes) {
		pointGoodsService.delete(pointGoods);
		addMessage(redirectAttributes, "删除积分商品成功");
		return "redirect:"+Global.getAdminPath()+"/spm/pm/pointGoods/?repage";
	}

    @RequiresPermissions("spm:pm:pointGoods:view")
    @RequestMapping(value = "info")
    public String info(PointGoods pointGoods, Model model) {
        model.addAttribute("pointGoods", pointGoods);
        return "modules/spm/pm/pointGoodsInfo";
    }
    
    @RequiresPermissions("spm:pm:pointGoods:edit")
	@RequestMapping(value = "updateUpFlag")
    public String updateUpFlag(PointGoods pointGoods, RedirectAttributes redirectAttributes) {
    	String msg = "";
    	if(PointGoods.TRUE_FLAG.equals(pointGoods.getUpFlag())) {
    		pointGoods.setUpFlag(PointGoods.FALSE_FLAG);
    		msg = "下架";
    		
    	} else {
    		pointGoods.setUpFlag(PointGoods.TRUE_FLAG);
    		msg = "上架";
    	}
    	pointGoodsService.updateUpFlag(pointGoods);
    	addMessage(redirectAttributes, "该积分商品"+msg+"成功!");
    	return "redirect:"+Global.getAdminPath()+"/spm/pm/pointGoods/?repage";
    };
}