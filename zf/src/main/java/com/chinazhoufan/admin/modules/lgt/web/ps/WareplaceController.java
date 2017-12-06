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
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warearea;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warecounter;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareareaService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarecounterService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 货位列表Controller
 * @author 贾斌
 * @version 2015-10-13
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/wareplace")
public class WareplaceController extends BaseController {

	@Autowired
	private WarehouseService warehouseService;		// 仓库
	@Autowired
	private WareareaService wareareaService;		// 货架
	@Autowired
	private WarecounterService warecounterService;	// 货屉
	@Autowired
	private WareplaceService wareplaceService;		// 货位
	@Autowired
	private ProductService productService;
	
	@ModelAttribute
	public Wareplace get(@RequestParam(required=false) String id) {
		Wareplace entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wareplaceService.get(id);
		}
		if (entity == null){
			entity = new Wareplace();
		}
		return entity;
	}
	
	/**
	 * 货位列表（左侧导航）
	 * @param wareplace
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:wareplace:view")
	@RequestMapping(value = "index")
	public String index(Wareplace wareplace, Model model){
		return "modules/lgt/ps/wareplaceIndex";
	}
	
	/**
	 * 货位列表
	 * @param wareplace
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:wareplace:view")
	@RequestMapping(value = "wareplaceList")
	public String wareplaceList(Wareplace wareplace, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Wareplace> page = wareplaceService.findPage(new Page<Wareplace>(request, response), wareplace); 
		Warehouse wh = new Warehouse();
	    wh.setUsableFlag(Warehouse.TRUE_FLAG);
	    List<Warehouse> list = warehouseService.findList(wh);
		model.addAttribute("page", page);
		model.addAttribute("warehouseCode", list.get(0).getCode());
		model.addAttribute("warehouseId", list.get(0).getId());
		return "modules/lgt/ps/wareplaceList";
	}
	
	@RequiresPermissions("lgt:ps:wareplace:view")
	@RequestMapping(value = "form")
	public String form(Wareplace wareplace, Model model) {
		if (StringUtils.isBlank(wareplace.getId())) {
			wareplace.setLockFlag(Wareplace.FALSE_FLAG); 	// 新增时默认不锁定
			wareplace.setUsableFlag(Wareplace.TRUE_FLAG);	// 新增时默认可用
		}
		model.addAttribute("wareplace", wareplace);
		Warehouse wh = new Warehouse();
	    wh.setUsableFlag(Warehouse.TRUE_FLAG);
	    List<Warehouse> list = warehouseService.findList(wh);
	    model.addAttribute("warehouseCode", list.get(0).getCode());
		model.addAttribute("warehouseId", list.get(0).getId());
		return "modules/lgt/ps/wareplaceForm";
	}

	@RequiresPermissions("lgt:ps:wareplace:edit")
	@RequestMapping(value = "save")
	public String save(Wareplace wareplace, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wareplace)){
			return form(wareplace, model);
		}
		wareplaceService.save(wareplace);
		addMessage(redirectAttributes, "保存货位列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/wareplace/wareplaceList?repage";
	}
	
	@RequiresPermissions("lgt:ps:wareplace:edit")
	@RequestMapping(value = "delete")
	public String delete(Wareplace wareplace, RedirectAttributes redirectAttributes) {
		if(wareplace == null || StringUtils.isBlank(wareplace.getId())) {
			addMessage(redirectAttributes, "未能获取要删除的货位信息！");
			return "error/400";
		}
		
		wareplaceService.delete(wareplace);
		addMessage(redirectAttributes, "删除货位列表成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/wareplace/wareplaceList?repage";
	}
	
	/**
	 * 货位列表（锁定/解锁功能）
	 * @param wareplace
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "updateLockFlag")
	public String updateLockFlag(Wareplace wareplace, String lockFlag, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
		if (wareplace == null || StringUtils.isBlank(wareplace.getId())) {
			addMessage(redirectAttributes, "操作失败，未能获取到有效货位信息");
		}
		try {
			Wareplace wareplaceOld = wareplaceService.get(wareplace.getId());
			wareplaceOld.setLockFlag(lockFlag);
			wareplaceService.update(wareplaceOld);
			addMessage(redirectAttributes, "操作成功");
		} catch (Exception e) {
			addMessage(redirectAttributes, "操作失败");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/wareplace/wareplaceList?repage";
	}
	
	
	/**
	 * 货位列表（启用/禁用功能）
	 * @param wareplace
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "updateUsableFlag")
	public String updateUsableFlag(Wareplace wareplace, String usableFlag, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
		if (wareplace == null || StringUtils.isBlank(wareplace.getId())) {
			addMessage(redirectAttributes, "操作失败，未能获取到有效货位信息");
		}
		try {
			Wareplace wareplaceOld = wareplaceService.get(wareplace.getId());
			wareplaceOld.setUsableFlag(usableFlag);
			wareplaceService.update(wareplaceOld);
			addMessage(redirectAttributes, "操作成功");
		} catch (Exception e) {
			addMessage(redirectAttributes, "操作失败");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/wareplace/wareplaceList?repage";
	}
	
	
	// 查询仓库所属区域货架下的货位
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "wareplaceTreeData")
	public List<Map<String, Object>> TreeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Warehouse> houses = warehouseService.findList();//仓库
		List<Warearea> wareareas = wareareaService.findList();//仓库区域
		List<Warecounter> warecounters = warecounterService.findList();//仓库货架
		List<Wareplace> wareplaces = wareplaceService.findList();//货位
		Map<String,Object> map = null;
		for(Warehouse h : houses){
			map = Maps.newHashMap();//仓库
			map.put("id", h.getId());
			map.put("pId", "");
			map.put("name", h.getCode());
			map.put("isParent", true);
			mapList.add(map);
			for(Warearea w : wareareas){
				if(h.getId().equals(w.getWarehouse().getId())){
					map = Maps.newHashMap();//仓库区域
					map.put("id", w.getId());
					map.put("pId", h.getId());
					map.put("name", w.getCode());
					map.put("isParent", true);
					mapList.add(map);
					for (Warecounter wc : warecounters) {
						if(wc.getWarearea().getId().equals(w.getId())){
							map = Maps.newHashMap();//货架
							map.put("id", wc.getId());
							map.put("pId", w.getId());
							map.put("name", wc.getCode());
							map.put("isParent", true);
							mapList.add(map);
							for(Wareplace wr : wareplaces){
								if(wr.getWarecounter().getId().equals(wc.getId())){
									map = Maps.newHashMap();//货位
									map.put("id", wr.getId());
									map.put("pId", wc.getId());
									map.put("name", wr.getCode());
									mapList.add(map);
								}
							}
						}
					}
				}
			}
		}
		return mapList;
	}
	
	
	/**
	 * @param extId
	 * @param isShowHidden
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "wareplaceTree")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		Product product = productService.get(extId);
		Warehouse house = warehouseService.findWareHouseByWareplaceId(product.getWareplace().getId());
		
		List<Warehouse> houseLists = warehouseService.findWareHourseById(house.getId());
		
		List<Map<String, Object>> mapList = Lists.newArrayList();
		for(Warehouse wh: houseLists){
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", wh.getId());
			map.put("pId", "");
			map.put("name", wh.getCode());
			mapList.add(map);
			List<Warearea> was = wh.getWareareaList();
			for(Warearea wa : was){
				map = Maps.newHashMap();
				map.put("id", wa.getId());
				map.put("pId", wh.getId());
				map.put("name", wa.getCode());
				mapList.add(map);
				List<Warecounter>  wcs = wa.getWarecountersList();
				for(Warecounter wc : wcs){
					map = Maps.newHashMap();
					map.put("id", wc.getId());
					map.put("pId", wa.getId());
					map.put("name", wc.getCode());
					mapList.add(map);
					List<Wareplace> wps = wc.getWareplacesList();
					for(Wareplace wp : wps){
						map = Maps.newHashMap();
						map.put("id", wp.getId());
						map.put("pId", wc.getId());
						map.put("name", wp.getCode());
						mapList.add(map);
					}
				}
			}
		
		}
		return mapList;
	}
	
	
	
	/**
	 * 查询所有的仓库货位<树插件使用>
	 * @param warecounter
	 * @param extId
	 * @param isShowHide
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "wareplaceListData")
	public List<Map<String, Object>> wareplaceListData(Wareplace wareplace, @RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		//若货架ID为空，则直接返回空数据
		if (!StringUtils.isBlank(wareplace.getWarecounter().getId())) {
			List<Wareplace> wareplaces = wareplaceService.findList(wareplace);//货位
			Map<String, Object> map = null;
			for(Wareplace wp : wareplaces){
				map = Maps.newHashMap();
				map.put("id", wp.getId());
				map.put("pId", "");
				map.put("name", wp.getCode());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	/**Ajax:
	 * 获取仓库货位数据（产品、库存）
	 * @param wareplace.id 货位ID
	 * @param wareplace.produce.id 产品ID
	 * @param wareplace.warecounter.id 货柜ID
	 * @param wareplace.warecounter.warearea.id 仓库区域ID
	 * @param wareplace.warecounter.warearea.warehouse.id 仓库ID
	 * @param response
	 * @return
	 */
	@RequiresPermissions("lgt:ps:product:edit")
	@RequestMapping(value = "findWareplaceByProduceAndPosition")
	public String findWareplaceByProduceAndPosition(Wareplace wareplace, HttpServletResponse response) {
		if(wareplace == null){
			return renderString(response, "false:查询仓库货位信息参数不足");
		}
		List<Wareplace> wareplaceList = wareplaceService.findWareplaceListByProduceAndPosition(wareplace);
		
		return renderString(response, JsonMapper.toJsonString(wareplaceList));
	}
	
	/**
	 * 货位选择器
	 * @param wareplace
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "wareplaceSelect")
	public String wareplaceSelect(Wareplace wareplace, HttpServletRequest request, HttpServletResponse response, Model model) {
		wareplace.setProduceNullFlag(true);
		wareplace.setLockFlag(Wareplace.LOCKFLAG_UNLOCKED);
		Page<Wareplace> page = wareplaceService.findPage(new Page<Wareplace>(request, response), wareplace); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/wareplaceSelect";
	}
	
	
	/**
	 * 货位打印
	 * @param produce
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:wareplace:view")
	@RequestMapping(value = "printPreview")
	public String printPreview(Wareplace wareplace, Model model) {
		List<Wareplace> list = wareplaceService.findWareplaceListByProduceAndPosition(wareplace);
		model.addAttribute("list", list);
		return "modules/lgt/ps/wareplaceListPrint";
	}
	
	/**
	 * 查看货位存货详情
	 * @param produce
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:ps:wareplace:view")
	@RequestMapping(value = "stockView")
	public String stockView(Wareplace wareplace, Model model) {
		Product product = new Product();
		product.setWareplace(wareplace);
		List<Product> list = productService.printPreview(product);
		model.addAttribute("list", list);
		return "modules/lgt/ps/wareplaceStockView";
	}
	
}