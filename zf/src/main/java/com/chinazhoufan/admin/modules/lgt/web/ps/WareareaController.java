/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.util.List;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warearea;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareareaService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarecounterService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 仓库区域管理Controller
 * @author 贾斌
 * @version 2015-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/warearea")
public class WareareaController extends BaseController {
	
	@Autowired
	private WareareaService wareareaService;	//仓库区域管理
	@Autowired
	private WarehouseService warehouseService;
	@Autowired
	private WarecounterService warecounterService;
	
	@ModelAttribute
	public Warearea get(@RequestParam(required=false) String id) {
		Warearea entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wareareaService.get(id);
		}
		if (entity == null){
			entity = new Warearea();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:warearea:view")
	@RequestMapping(value = {"list", ""})
	public String list(Warearea warearea, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Warearea> page = wareareaService.findPage(new Page<Warearea>(request, response), warearea); 
		List<Warehouse> warehouses = warehouseService.findList();
		model.addAttribute("warehouses", warehouses);
		model.addAttribute("page", page);
		return "modules/lgt/ps/wareareaList";
	}

	@RequiresPermissions("lgt:ps:warearea:view")
	@RequestMapping(value = "form")
	public String form(Warearea warearea, Model model) {
		if(StringUtils.isBlank(warearea.getId())) {
			warearea.setUsableFlag(Warearea.TRUE_FLAG);
		}
		model.addAttribute("warearea", warearea);
		Warehouse wh = new Warehouse();
	    wh.setUsableFlag(Warehouse.TRUE_FLAG);
	    List<Warehouse> list = warehouseService.findList(wh);
	    model.addAttribute("warehouseCode", list.get(0).getCode());
		model.addAttribute("warehouseId", list.get(0).getId());
		return "modules/lgt/ps/wareareaForm";
	}

	@RequiresPermissions("lgt:ps:warearea:edit")
	@RequestMapping(value = "save")
	public String save(Warearea warearea, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, warearea)){
			return form(warearea, model);
		}
		if(Warearea.TYPE_BROKEN.equals(warearea.getType())){
			warearea.setCategories(new Categories(""));
		}
		wareareaService.save(warearea);
		addMessage(redirectAttributes, "保存仓库区域管理成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/warearea/?repage";
	}
	
	@RequiresPermissions("lgt:ps:warearea:edit")
	@RequestMapping(value = "delete")
	public String delete(Warearea warearea, RedirectAttributes redirectAttributes) {
		if(warearea == null || StringUtils.isBlank(warearea.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的仓库区域管理信息！");
			return "error/400";
		}
		wareareaService.delete(warearea);
		addMessage(redirectAttributes, "删除仓库区域管理成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/warearea/?repage";
	}
	
	/**
	 * 查询仓库区域级联
	 * @param extId
	 * @param isShowHidden
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "wareareaTreeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Warehouse> houses = warehouseService.findList();//仓库
		List<Warearea> wareareas = wareareaService.findList();//仓库区域
		Map<String,Object> map = null;
		for(Warehouse h : houses){
			map = Maps.newHashMap();
			map.put("id", h.getId());
			map.put("pId", h.getId());
			map.put("name", h.getCode());
			map.put("isParent", true);
			mapList.add(map);
			for(Warearea w : wareareas){
				if(h.getId().equals(w.getWarehouse().getId())){
					map = Maps.newHashMap();
					map.put("id", w.getId());
					map.put("pId", h.getId());
					map.put("name", w.getCode());
					mapList.add(map);
				}
			}
		}
		return mapList;
	}

	/**
	 * 查询所有的货架<树插件级联查询使用>
	 * @param warehouse
	 * @param extId
	 * @param isShowHide
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "wareareaListData")
	public List<Map<String, Object>> wareareaListData(Warearea warearea, @RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		//如果仓库ID为空，则返回空数据
		if (!StringUtils.isBlank(warearea.getWarehouse().getId())) {
			List<Warearea> wareareas = wareareaService.findList(warearea);	// 货架
			Map<String,Object> map = null;
			for(Warearea w : wareareas){
				map = Maps.newHashMap();
				map.put("id", w.getId());
				map.put("pId", "");
				map.put("name", w.getCode());
				map.put("type", w.getType());
				mapList.add(map);
			}
		}
		return mapList;
	}

	/**
	 * 查询所有的货架<单独树插件使用>
	 * @param warehouse
	 * @param extId
	 * @param isShowHide
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "listData")
	public List<Map<String, Object>> listData(Warearea warearea, @RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Warearea> wareareas = wareareaService.findList(warearea);//仓库区域
		Map<String,Object> map = null;
		for(Warearea w : wareareas){
			map = Maps.newHashMap();
			map.put("id", w.getId());
			map.put("pId", "");
			map.put("name", w.getCode());
			mapList.add(map);
		}
		return mapList;
	}
	

	@RequiresPermissions("lgt:ps:warearea:batchSet")
	@RequestMapping(value="batchSet")
	@ResponseBody
	public String batchSet(String wareareaId, int horizontalNum, int verticalNum, int wareplaceNum){
		String message = "";
		int status = 0;
		if (horizontalNum>9||horizontalNum<1) {
			message = "横向操作数只能为一位正整数";
		}else if (verticalNum>99||verticalNum<1) {
			message = "横向操作数只能为二位正整数";
		}else if (wareplaceNum>9||wareplaceNum<1) {
			message = "屉内货位数只能为一位正整数";
		}else if (StringUtils.isBlank(wareareaId)) {
			message = "参数错误";
		}else {
			Warearea warearea = wareareaService.get(wareareaId);
			if (warearea!=null&&StringUtils.isNotBlank(warearea.getId())) {
				if (warecounterService.countByWarearea(wareareaId) > 0) {
					message = "操作失败，当前货架存在未删除的货屉！";
				}else {
					try {
						wareareaService.batchSetWarecounterAndWareplace(warearea,horizontalNum,verticalNum,wareplaceNum);
						message = "操作成功！";
						status = 1;
					} catch (Exception e) {
						e.printStackTrace();
						message = "生成失败,"+e.getMessage();
					}
				}
			}else {
				message = "参数错误";
			}
		}
		return "{\"message\":\""+message+"\",\"status\":\""+status+"\"}";
	}
}