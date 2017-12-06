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
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warearea;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warecounter;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareareaService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarecounterService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 货架列表Controller
 * @author 贾斌
 * @version 2015-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/warecounter")
public class WarecounterController extends BaseController {

	@Autowired
	private WarehouseService warehouseService;//仓库表
	@Autowired
	private WarecounterService warecounterService;
	@Autowired
	private WareareaService wareareaService;
	
	
	@ModelAttribute
	public Warecounter get(@RequestParam(required=false) String id) {
		Warecounter entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = warecounterService.get(id);
		}
		if (entity == null){
			entity = new Warecounter();
		}
		return entity;
	}
	
	/**
	 * 货屉列表（左侧导航）
	 * @param wareplace
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:warecounter:view")
	@RequestMapping(value = "index")
	public String index(Wareplace wareplace, Model model){
		return "modules/lgt/ps/warecounterIndex";
	}
	
	@RequiresPermissions("lgt:ps:warecounter:view")
	@RequestMapping(value = "list")
	public String list(Warecounter warecounter, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Warecounter> page = warecounterService.findPage(new Page<Warecounter>(request, response), warecounter);
		Warehouse wh = new Warehouse();
        warecounter.setUsableFlag(Warehouse.TRUE_FLAG);
		List<Warehouse> list = warehouseService.findList(wh);
        model.addAttribute("page", page);
        model.addAttribute("warehouseCode", list.get(0).getCode());
		model.addAttribute("warehouseId", list.get(0).getId());
		return "modules/lgt/ps/warecounterList";
	}
	
//	@RequiresPermissions("lgt:ps:warecounter:view")
//	@RequestMapping(value = {"list", ""})
//	public String list(Warecounter warecounter, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<Warecounter> warecounterlist = warecounterService.findPage(new Page<Warecounter>(request, response), warecounter); 
//		List<Warearea> warears = wareareaService.findList();
//		List<Warehouse> warehouses = warehouseService.findList();
//		model.addAttribute("warehouses", warehouses);
//		model.addAttribute("warears", warears);
//        model.addAttribute("page", warecounterlist);
//		return "modules/lgt/ps/warecounterList3";
//	}


	@RequiresPermissions("lgt:ps:warecounter:view")
	@RequestMapping(value = "form")
	public String form(Warecounter warecounter, Model model) {
		if(StringUtils.isBlank(warecounter.getId())) {
			warecounter.setUsableFlag(Warecounter.TRUE_FLAG);
		}
		model.addAttribute("warecounter", warecounter);
		Warehouse wh = new Warehouse();
	    wh.setUsableFlag(Warehouse.TRUE_FLAG);
	    List<Warehouse> list = warehouseService.findList(wh);
	    model.addAttribute("warehouseCode", list.get(0).getCode());
		model.addAttribute("warehouseId", list.get(0).getId());
		return "modules/lgt/ps/warecounterForm";
	}

	@RequiresPermissions("lgt:ps:warecounter:edit")
	@RequestMapping(value = "save")
	public String save(Warecounter warecounter, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, warecounter)){
			return form(warecounter, model);
		}
		warecounterService.save(warecounter);
		addMessage(redirectAttributes, "保存货架列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/warecounter/list?repage";
	}
	
	@RequiresPermissions("lgt:ps:warecounter:edit")
	@RequestMapping(value = "delete")
	public String delete(Warecounter warecounter, RedirectAttributes redirectAttributes) {
		if(warecounter == null || StringUtils.isBlank(warecounter.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的货架信息！");
			return "error/400";
		}
		
		warecounterService.delete(warecounter);
		addMessage(redirectAttributes, "删除货架列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/warecounter/list?repage";
	}
	
	
	// 查询仓库货架下的货屉
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "warecounterTreeData")
	public List<Map<String, Object>> TreeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Warehouse> houses = warehouseService.findList();			// 仓库
		List<Warearea> wareareas = wareareaService.findList();			// 货架
		List<Warecounter> warecounters = warecounterService.findList();	// 货屉
		Map<String,Object> map = null;
		for(Warehouse h : houses){
			// 仓库
			map = Maps.newHashMap();
			map.put("id", h.getId());
			map.put("pId", "");
			map.put("name", h.getCode());
			map.put("isParent", true);
			mapList.add(map);
			for(Warearea w : wareareas){
				if(h.getId().equals(w.getWarehouse().getId())){
					// 货架
					map = Maps.newHashMap();
					map.put("id", w.getId());
					map.put("pId", h.getId());
					map.put("name", w.getCode());
					map.put("isParent", true);
					mapList.add(map);
					for (Warecounter wc : warecounters) {
						if(wc.getWarearea().getId().equals(w.getId())){
							// 货屉
							map = Maps.newHashMap();
							map.put("id", wc.getId());
							map.put("pId", w.getId());
							map.put("name", wc.getCode());
							mapList.add(map);
						}
					}
				}
			}
		}
		return mapList;
	}

	
	/**
	 * 查询所有的仓库货架<树插件级联查询使用>
	 * @param warearea
	 * @param extId
	 * @param isShowHide
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "warecounterListData")
	public List<Map<String, Object>> warecounterListData(Warecounter warecounter , @RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		//若区域为空，则返回空数据
		if (!StringUtils.isBlank(warecounter.getWarearea().getId())) {
			List<Warecounter> warecounters = warecounterService.findList(warecounter);//仓库货架
			Map<String,Object> map = null;
			for (Warecounter wc : warecounters) {
				map = Maps.newHashMap();//货架
				map.put("id", wc.getId());
				map.put("pId", "");
				map.put("name", wc.getCode());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	/**
	 * 查询所有的仓库货架<树插件单独查询使用>
	 * @param warearea
	 * @param extId
	 * @param isShowHide
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "listData")
	public List<Map<String, Object>> listData(Warecounter warecounter , @RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Warecounter> warecounters = warecounterService.findList(warecounter);//仓库货架
		Map<String,Object> map = null;
		for (Warecounter wc : warecounters) {
			map = Maps.newHashMap();//货架
			map.put("id", wc.getId());
			map.put("pId", "");
			map.put("name", wc.getCode());
			mapList.add(map);
		}
		return mapList;
	}
}