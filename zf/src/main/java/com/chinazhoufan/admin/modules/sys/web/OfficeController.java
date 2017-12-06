/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.web;

import java.util.List;
import java.util.Map;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.entity.Office;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.AreaService;
import com.chinazhoufan.admin.modules.sys.service.OfficeService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 机构Controller
 * @author ThinkGem
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class OfficeController extends BaseController {

	@Autowired
	private OfficeService officeService;
	@Autowired
	private AreaService areaService;
	
	@ModelAttribute("office")
	public Office get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return officeService.get(id);
		}else{
			return new Office();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {"index"})
	public String index(Office office, Model model) {
//        model.addAttribute("list", officeService.findAll());
		return "modules/sys/officeIndex";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {"list"})
	public String list(Office office, Model model) {
		List<Office> list = Lists.newArrayList();
		List<Office> sourcelist = officeService.findList(office);
		Office.sortList(list, sourcelist, "1");
        model.addAttribute("list", list);
		return "modules/sys/officeList";
	}
	
	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "form")
	public String form(Office office, Model model) {
		User user = UserUtils.getUser();
		if (office.getParent()==null || office.getParent().getId()==null){
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		
		//组装省市区列表
		Area a = new Area();
		a.setType(Area.TYPE_PROVINCE);
		List<Area> provinceList = areaService.listAreaByType(a);
		model.addAttribute("provinceList", provinceList);
		
		//省能直接取到集合，区对应的是机构存储的值，可以直接取集合，就只剩下市需要获取父级ID
		String provinceId = "";
		if (office.getArea()==null || "1".equals(office.getArea().getId())){//如果区域为空或者区域是中国的，都需要重新选择区域
			office.setArea(user.getOffice().getArea());
			if(office.getArea() != null && StringUtils.isNotBlank(office.getArea().getParentIds())) {
				String parentIds = user.getOffice().getArea().getParentIds();
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
				a.setParent(office.getArea().getParent());//市级ID
				List<Area> districtList = areaService.listAreaByType(a);
				model.addAttribute("districtList", districtList);
			}
			
		} else {
			String parentIds = office.getArea().getParentIds();
			if(StringUtils.isNotBlank(parentIds)) {
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
				a.setParent(office.getArea().getParent());//市级ID
				List<Area> districtList = areaService.listAreaByType(a);
				model.addAttribute("districtList", districtList);
			}
		}
		// 自动获取排序号
		if (StringUtils.isBlank(office.getId())&&office.getParent()!=null){
			int size = 0;
			List<Office> list = officeService.findAll();
			for (int i=0; i<list.size(); i++){
				Office e = list.get(i);
				if (e.getParent()!=null && e.getParent().getId()!=null
						&& e.getParent().getId().equals(office.getParent().getId())){
					size++;
				}
			}
			office.setCode(office.getParent().getCode() + StringUtils.leftPad(String.valueOf(size > 0 ? size+1 : 1), 3, "0"));
		}
		if(StringUtils.isBlank(office.getId())) {
			office.setUseable(Office.USEABLEOK);//是否启用，默认启用
		}
		
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save")
	public String save(Office office, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/";
		}
		if (!beanValidator(model, office)){
			return form(office, model);
		}
		officeService.save(office);
		
		if(office.getChildDeptList()!=null){
			Office childOffice = null;
			for(String id : office.getChildDeptList()){
				childOffice = new Office();
				childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
				childOffice.setParent(office);
				childOffice.setArea(office.getArea());
				childOffice.setType("2");
				childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade())+1));
				childOffice.setUseable(Global.YES);
				officeService.save(childOffice);
			}
		}
		
		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
//		String id = "0".equals(office.getParentId()) ? "" : office.getParentId();
		return "redirect:" + adminPath + "/sys/office/list?repage";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(Office office, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/list";
		}
		if(office == null || StringUtils.isBlank(office.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的机构信息！");
			return "error/400";
		}
//		if (Office.isRoot(id)){
//			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
//		}else{
			officeService.delete(office);
			addMessage(redirectAttributes, "删除机构成功");
//		}
		return "redirect:" + adminPath + "/sys/office/list?repage";
	}

	/**
	 * 获取机构JSON数据。
	 * @param extId 排除的ID
	 * @param type	类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade 显示级别
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, @RequestParam(required=false) String type,
			@RequestParam(required=false) Long grade, @RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> list = officeService.findList(true);
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			/*if ((StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& Global.YES.equals(e.getUseable())){*/
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type)){
					map.put("isParent", true);
				}
				mapList.add(map);
			/*}*/
		}
		return mapList;
	}
	
	/**
	 * 根据机构获取用户数据
	 * @param officeId 
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "userTreeData")
	public List<Map<String, Object>> userTreeData(@RequestParam(required=false) String officeId,@RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> list = officeService.findList(true);
		List<User> users=UserUtils.getUserList();
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("pIds", e.getParentIds());
			map.put("name", e.getName());
			switch(e.getType()) {
				case "1":map.put("dataType", "Company");break;
				case "2":map.put("dataType", "Office");break;
				case "3":map.put("dataType", "Group");break;
				default:map.put("dataType", null);break;
			}
			map.put("users", getUsersByOfficeId(e.getId(),users));
			mapList.add(map);
		}
		return mapList;
	}
	
	private List<User> getUsersByOfficeId(String officeId,List<User> users){
		List<User> list=Lists.newArrayList();
		for (User user : users) {
			if(officeId.equals(user.getOffice().getId()))
				list.add(user);
		}
		return list;
	}
	
	/**
	 * 获取机构JSON数据。
	 * @param extId 排除的ID
	 * @param type	类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade 显示级别
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeDataEmployee")
	public List<Map<String, Object>> treeDataEmployee(@RequestParam(required=false) String extId, @RequestParam(required=false) String type,
			@RequestParam(required=false) Long grade, @RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> list = officeService.findList(isAll);
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			if ((StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& Global.YES.equals(e.getUseable())){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type)){
					map.put("isParent", true);
				}
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "changeFlag")
	public String changeFlag(Office office, Model model) {
		if(office == null || StringUtils.isBlank(office.getId())) {
			addMessage(model, "友情提示：未能获取到有效的机构信息！");
			return "error/400";
		}
		Office off = officeService.get(office.getId());
		if(!StringUtils.isBlank(off.getUseable())) {
			off.setUseable(office.getUseable());
		} 
		officeService.changeFlag(off);
		return list(off, model);
	};
	
	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "info")
	public String info(Office office, Model model) {
		if(office == null || StringUtils.isBlank(office.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的机构信息！");
			return "error/400";
		}
		model.addAttribute("office", office);
		return "modules/sys/officeInfo";
	}
}
