/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.web;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.service.AreaService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 区域Controller
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/area")
public class AreaController extends BaseController {

	@Autowired
	private AreaService areaService;
	
	@ModelAttribute("area")
	public Area get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return areaService.get(id);
		}else{
			return new Area();
		}
	}

	
	/**
	 * 区域列表（左侧导航）
	 * @param area
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = "index")
	public String index(Area area, Model model){
		return "modules/sys/areaIndex";
	}
	
	
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = {"list", ""})
	public String list(Area area, Model model) {
		List<Area> list = Lists.newArrayList();
		List<Area> sourcelist = areaService.findAll();
		Area.sortList(list, sourcelist, "1");
		model.addAttribute("list", list);
		return "modules/sys/areaList";
	}

	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = "listByType")
	public String listByType(Area area, int isDistrict, HttpServletRequest request, HttpServletResponse response,  Model model) {
		if(isDistrict == 1) {
			area.setType(Area.TYPE_DISTRICT);
		}
		Page<Area> page = areaService.findPageByType(new Page<Area>(request, response), area);
		model.addAttribute("page", page);
		model.addAttribute("area", area);
		return "modules/sys/areaListByType";
	}
	
	
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = "form")
	public String form(Area area, Model model) {
		if (area.getParent()==null||area.getParent().getId()==null){
			area.setParent(UserUtils.getUser().getOffice().getArea());
		}
		if(area != null && StringUtils.isBlank(area.getId())) {
			area.setType(Area.TYPE_PROVINCE);
		}
		if(area.getParent() != null){
			area.setParent(areaService.get(area.getParent().getId()));			
		}
		
//		// 自动获取排序号
//		if (StringUtils.isBlank(area.getId())){
//			int size = 0;
//			List<Area> list = areaService.findAll();
//			for (int i=0; i<list.size(); i++){
//				Area e = list.get(i);
//				if (e.getParent()!=null && e.getParent().getId()!=null
//						&& e.getParent().getId().equals(area.getParent().getId())){
//					size++;
//				}
//			}
//			area.setCode(area.getParent().getCode() + StringUtils.leftPad(String.valueOf(size > 0 ? size : 1), 4, "0"));
//		}
		model.addAttribute("area", area);
		return "modules/sys/areaForm";
	}
	
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = "importForm")
	public String importForm(Area area, Model model) {
		model.addAttribute("area", area);
		return "modules/sys/areaImportForm";
	}
	
	
	@RequiresPermissions("sys:area:edit")
	@RequestMapping(value = "save")
	public String save(Area area, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/area";
		}
		if (!beanValidator(model, area)){
			return form(area, model);
		}
		areaService.save(area);
		addMessage(redirectAttributes, "保存区域'" + area.getName() + "'成功");
		return "redirect:" + adminPath + "/sys/area/listByType?isDistrict=1";
	}
	
	@RequiresPermissions("sys:area:edit")
	@RequestMapping(value = "delete")
	public String delete(Area area, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/area";
		}
		if(area == null || StringUtils.isBlank(area.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的区域信息！");
			return "error/400";
		}
//		if (Area.isRoot(id)){
//			addMessage(redirectAttributes, "删除区域失败, 不允许删除顶级区域或编号为空");
//		}else{
			areaService.delete(area);
			addMessage(redirectAttributes, "删除区域成功");
//		}
		return "redirect:" + adminPath + "/sys/area/listByType?isDistrict=1";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = areaService.findAll();
		for (int i=0; i<list.size(); i++){
			Area e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", "1".equals(e.getParentId())?"":e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	/**
	 * 
	 * @param type	tree数据显示的层级（1：显示到国家	2：显示国家、省	3：显示到市	4：显示到区）
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeDataByType")
	public List<Map<String, Object>> treeDataByType(@RequestParam(required=false) String type, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = areaService.findAll();
		for (int i=0; i<list.size(); i++){
			Area e = list.get(i);
			if (StringUtils.isBlank(type) || (new Integer(type) >= new Integer(e.getType()))){
				
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", "0".equals(e.getParentId())?"":e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	
	/**
	 * 
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeDataIndex")
	public List<Map<String, Object>> treeDataByType(HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Area> list = areaService.findWithOutDistrict();
		for (int i=0; i<list.size(); i++){
			Area e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", "0".equals(e.getParentId())?"":e.getParentId());
			map.put("name", e.getName());
			mapList.add(map);
		}
		return mapList;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "listAreaByParentId")
	public String listAreaByParentId(Area area, HttpServletResponse response) {
		List<Area> list = areaService.listAreaByParentId(area);
		return JsonMapper.toJsonString(list);
	}
	
	
	
	
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = "info")
	public String info(Area area, Model model) {
		if(area == null || StringUtils.isBlank(area.getId())) {
			addMessage(model, "未获取到要查看的区域信息！");
			return list(area, model);
		}
		area.getParent().setName(areaService.getAreaFullName(area.getParent().getId()));;
		model.addAttribute("area", area);
		return "modules/sys/areaInfo";
	}
	
	
	
	/**
	 * 导入区域数据
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:area:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/area/";
		}
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			areaService.importArea(ei);
			addMessage(redirectAttributes, "已成功导入"+ei.getLastDataRowNum()+"条区域数据");
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入区域数据失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/sys/area/listByType?isDistrict=1";
    }
	
	
	
	
}
