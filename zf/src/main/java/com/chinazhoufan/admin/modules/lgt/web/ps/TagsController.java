/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.util.Map;

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
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Tags;
import com.chinazhoufan.admin.modules.lgt.service.ps.TagsService;
import com.google.common.collect.Maps;

/**
 * 商品标签Controller
 * @author 贾斌
 * @version 2016-01-05
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/tags")
public class TagsController extends BaseController {

	@Autowired
	private TagsService tagsService;
	
	@ModelAttribute
	public Tags get(@RequestParam(required=false) String id) {
		Tags entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = tagsService.get(id);
		}
		if (entity == null){
			entity = new Tags();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:tags:view")
	@RequestMapping(value = {"list", ""})
	public String list(Tags tags, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Tags> page = tagsService.findPage(new Page<Tags>(request, response), tags); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/tagsList";
	}
	
	@RequiresPermissions("lgt:ps:tags:view")
	@RequestMapping(value = "form")
	public String form(Tags tags, Model model) {
		model.addAttribute("tags", tags);
		return "modules/lgt/ps/tagsForm";
	}

	@RequiresPermissions("lgt:ps:tags:edit")
	@RequestMapping(value = "save")
	public String save(Tags tags, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, tags)){
			return form(tags, model);
		}
		tagsService.save(tags);
		addMessage(redirectAttributes, "保存商品标签成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/tags/list?repage";
	}
	
	@RequiresPermissions("lgt:ps:tags:edit")
	@RequestMapping(value = "delete")
	public String delete(Tags tags,String id, Model model, RedirectAttributes redirectAttributes) {
		if(tags == null || StringUtils.isBlank(tags.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的商品标签信息！");
			return "error/400";
		}
		
		tagsService.delete(tags);
		addMessage(model, "删除商品标签成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/tags/list?repage";
	}
	
	/**保存商品标签**/
	@RequestMapping(value = "saveGoodsTags")
	public String saveGoodsTags(String goodsId,@RequestParam(value = "tagIds[]" ,required=false)String[] tagIds, HttpServletResponse response) {
		if(StringUtils.isBlank(goodsId)){
			return renderString(response, "未获取到商品信息");
		}
		try {
			tagsService.saveGoodsTags(goodsId, tagIds);
			return renderString(response, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return renderString(response, "操作失败！");
		}
	}
	
	
	
	/**移除商品标签分类管理**/
	@RequestMapping(value = "goodsTagsDelete")
	public void goodsTagsDelete(Goods goods, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		try {
			tagsService.remove(goods.getId(), goods.getTagss().get(0).getId());
			map.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("flag", false);
		}
		renderString(response, JsonMapper.toJsonString(map));
	}
	
	/**
	 * 商品标签选择器
	 * @param brand
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:tags:view")
	@RequestMapping(value = "tagsSelect")
	public String select(Tags tags, HttpServletRequest request, HttpServletResponse response, Model model,String goodsId) {
		Page<Tags> page = tagsService.findPage(new Page<Tags>(request, response), tags); 
		Goods goods = new Goods(page.getList(), goodsId);

		Goods goodsTags = tagsService.findNavGoodsTags(goods);
		
		model.addAttribute("goodsId",goodsId);
		model.addAttribute("page", page);//品牌
		model.addAttribute("goodsTags", goodsTags);//回选已经关联的商品标签
		return "modules/lgt/ps/tagsSelect";
	}
	
	@RequiresPermissions("lgt:ps:tags:view")
	@RequestMapping(value = "info")
	public String info(Tags tags, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(tags == null || StringUtils.isBlank(tags.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的标签信息！");
			return "error/400";
		}
		model.addAttribute("tags", tags);
		return "modules/lgt/ps/tagsInfo";
	}

}