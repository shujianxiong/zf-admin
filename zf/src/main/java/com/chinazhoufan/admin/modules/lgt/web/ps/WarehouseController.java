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
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.service.AreaService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 仓库管理Controller
 * @author 贾斌
 * @version 2015-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/warehouse")
public class WarehouseController extends BaseController {

	@Autowired
	private AreaService areaService;
	@Autowired
	private WarehouseService warehouseService;
	
	@ModelAttribute
	public Warehouse get(@RequestParam(required=false) String id) {
		Warehouse entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = warehouseService.get(id);
		}
		if (entity == null){
			entity = new Warehouse();
		}
		return entity;
	}
	
	
	@RequiresPermissions("lgt:ps:warehouse:view")
	@RequestMapping(value = {"list", ""})
	public String list(Warehouse warehouse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Warehouse> page = warehouseService.findPage(new Page<Warehouse>(request, response), warehouse); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/warehouseList";
	}

	@RequiresPermissions("lgt:ps:warehouse:view")
	@RequestMapping(value = "form")
	public String form(Warehouse warehouse, Model model) {
		if(StringUtils.isBlank(warehouse.getId())) {
			warehouse.setUsableFlag(Warehouse.FALSE_FLAG);
		}
		

		//组装省市区列表
		Area a = new Area();
		a.setType(Area.TYPE_PROVINCE);
		List<Area> provinceList = areaService.listAreaByType(a);
		model.addAttribute("provinceList", provinceList);
		
		//省能直接取到集合，区对应的是机构存储的值，可以直接取集合，就只剩下市需要获取父级ID
		String provinceId = "";
		if (warehouse.getArea()==null || "1".equals(warehouse.getArea().getId())){//如果区域为空或者区域是中国的，都需要重新选择区域
			if(warehouse.getArea() != null && StringUtils.isNotBlank(warehouse.getArea().getParentIds())) {
				String parentIds = warehouse.getArea().getParentIds();
				if(parentIds.startsWith("0,1,")) {
					String[] idsArr = parentIds.substring(4, parentIds.length()-1).split(",");//去除开头的0,1,和最后一个,
					if(idsArr.length > 0) {
						provinceId = idsArr[0];
					}
					
					//市
					a.setType(Area.TYPE_CITY);
					Area p = new Area();//省级ID
					p.setId(provinceId);
					a.setParent(p);
					List<Area> cityList = areaService.listAreaByType(a);
					model.addAttribute("cityList", cityList);
					//区     赋予的当前值
					a.setType(Area.TYPE_DISTRICT);
					a.setParent(warehouse.getArea().getParent());//市级ID
					List<Area> districtList = areaService.listAreaByType(a);
					model.addAttribute("districtList", districtList);
				}
			}
			
		} else {
			String parentIds = warehouse.getArea().getParentIds();
			if(StringUtils.isNotBlank(parentIds) && parentIds.startsWith("0,1,")) {
				
				String[] idsArr = parentIds.substring(4, parentIds.length()-1).split(",");//去除开头的0,1,和最后一个,
				if(idsArr.length > 0) {
					provinceId = idsArr[0];
				}
				//市
				a.setType(Area.TYPE_CITY);
				Area p = new Area();//省级ID
				p.setId(provinceId);
				a.setParent(p);
				List<Area> cityList = areaService.listAreaByType(a);
				model.addAttribute("cityList", cityList);
				//区     赋予的当前值
				a.setType(Area.TYPE_DISTRICT);
				a.setParent(warehouse.getArea().getParent());//市级ID
				List<Area> districtList = areaService.listAreaByType(a);
				model.addAttribute("districtList", districtList);
			}
		}
		
		
		model.addAttribute("warehouse", warehouse);
		return "modules/lgt/ps/warehouseForm";
	}

	@RequiresPermissions("lgt:ps:warehouse:edit")
	@RequestMapping(value = "save")
	public String save(Warehouse warehouse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, warehouse)){
			return form(warehouse, model);
		}
		warehouseService.save(warehouse);
		addMessage(redirectAttributes, "保存仓库成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/warehouse/?repage";
	}
	
	@RequiresPermissions("lgt:ps:warehouse:edit")
	@RequestMapping(value = "delete")
	public String delete(Warehouse warehouse, RedirectAttributes redirectAttributes) {
		if(warehouse == null || StringUtils.isBlank(warehouse.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的仓库信息！");
			return "redirect:"+Global.getAdminPath()+"/lgt/ps/warehouse/?repage";
		}
		warehouseService.delete(warehouse);
		addMessage(redirectAttributes, "删除仓库成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/warehouse/?repage";
	}
	
	/**
	 * @param extId
	 * @param isShowHidden
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "warehouseListData")
	public List<Map<String, Object>> warehouseListData(@RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Warehouse wh = new Warehouse();
		wh.setUsableFlag(Warehouse.TRUE_FLAG);
		List<Warehouse> list = warehouseService.findList(wh);
		for (int i=0; i<list.size(); i++){
			Warehouse e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", "");
			map.put("name", e.getCode());
			mapList.add(map);
		}
		return mapList;
	}
	
	// 查询仓库所属区域树节点
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "warehouseTreeData")
	public List<Map<String, Object>> warehouseTreeData(@RequestParam(required = false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = areaService.findAll();
		List<Warehouse> houses = warehouseService.findList();
		Map<String, Object> map = null;
		
		for (Area e : list) {
			map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("name", e.getName());
			map.put("isParent", true);
			mapList.add(map);
			for (Warehouse h : houses) {
				if (h.getArea().getId().equals(e.getId())) {
					map = Maps.newHashMap();
					map.put("id", h.getId());
					map.put("pId", e.getId());
					map.put("name", h.getName());
					mapList.add(map);
				}
			}
		}
		return mapList;
	}
	
	/**
	 * 启用仓库
	 * @param warehouse
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:warehouse:edit")
	@RequestMapping("updateUsableFlag")
	public String updateUsableFlag(Warehouse warehouse, String usableFlag, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (warehouse == null || StringUtils.isBlank(warehouse.getId())) {
			addMessage(model, "操作失败，未能获取到有效仓库信息");
			return list(warehouse, request, response, model);
		}
		try {
			Warehouse warehouseOld = warehouseService.get(warehouse.getId());
			warehouseOld.setUsableFlag(usableFlag);
			warehouseService.update(warehouseOld);
			addMessage(model, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(model, "操作失败");
		}
		return list(warehouse, request, response, model);
	}
	
}