/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web;

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

import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.FileDir;
import com.chinazhoufan.admin.modules.bas.service.FileDirService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 文件目录Controller
 * @Date 2016年10月26日 下午3:00:25
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/fileDir")
public class FileDirController extends BaseController {

	@Autowired
	private FileDirService fileDirService;
	
	@ModelAttribute("fileDir")
	public FileDir get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return fileDirService.get(id);
		}else{
			return new FileDir();
		}
	}

	@RequiresPermissions("bas:fileDir:view")
	@RequestMapping(value = {"list", ""})
	public String list(FileDir fileDir, Model model) {
		List<FileDir> list = Lists.newArrayList();
		List<FileDir> sourcelist = fileDirService.findAll();
		FileDir.sortList(list, sourcelist, "0");
		model.addAttribute("list", list);
		return "modules/bas/fileDirList";
	}

	@RequiresPermissions("bas:fileDir:view")
	@RequestMapping(value = "form")
	public String form(FileDir fileDir, Model model) {
		if(fileDir.getParent() != null) {
			fileDir.setParent(fileDirService.get(fileDir.getParent().getId()));
		}
		//默认目录类型是公开类型
		if(StringUtils.isBlank(fileDir.getId())) {
			fileDir.setType(FileDir.TYPE_PUBLIC);
		}
		model.addAttribute("fileDir", fileDir);
		return "modules/bas/fileDirForm";
	}
	
	@RequiresPermissions("bas:fileDir:edit")
	@RequestMapping(value = "save")
	public String save(FileDir fileDir, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, fileDir)){
			return form(fileDir, model);
		}
		fileDirService.save(fileDir);
		addMessage(redirectAttributes, "保存文件目录'" + fileDir.getName() + "'成功");
		return "redirect:" + adminPath + "/bas/fileDir/?repage";
	}
	
	@RequiresPermissions("bas:fileDir:edit")
	@RequestMapping(value = "delete")
	public String delete(FileDir fileDir, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(fileDir.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的文件目录信息！");
			return "error/400";
		}
		fileDirService.delete(fileDir);
		addMessage(redirectAttributes, "删除文件目录成功");
		return "redirect:" + adminPath + "/bas/fileDir/?repage";
	}

	@RequiresPermissions("bas:fileDir:view")
	@RequestMapping(value = "info")
	public String info(FileDir fileDir, Model model) {
		if(StringUtils.isBlank(fileDir.getId())) {
			addMessage(model, "友情提示：未能获取到文件目录详情!");
			return "error/400";
		}
		fileDir.setParent(get(fileDir.getParentId()));
		model.addAttribute("fileDir", fileDir);
		return "modules/bas/fileDirInfo";
	}
	
	/**
	 * 获取所有的文件目录
	 * @param extId
	 * @param response
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<FileDir> list = fileDirService.findAll();
		for (int i=0; i<list.size(); i++){
			FileDir e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
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
	 * 获取所有公开的文件目录集合
	 * @param extId
	 * @param response
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData/public")
	public List<Map<String, Object>> treePublicData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<FileDir> list = fileDirService.findPublicList();
		for (int i=0; i<list.size(); i++){
			FileDir e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
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
	 * 变更文件目录类型
	 * @param fileDir
	 * @param model
	 * @param redirectAttributes
	 * @throws
	 */
	@RequiresPermissions("bas:fileDir:edit")
	@RequestMapping(value = "updateType")
	public String updateType(FileDir fileDir, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, fileDir)){
			return form(fileDir, model);
		}
		fileDirService.updateType(fileDir);
		addMessage(redirectAttributes, "文件目录'" + fileDir.getName() + "'类型变更成功");
		return "redirect:" + adminPath + "/bas/fileDir/?repage";
	}
	

	/**
	 * 检测录入的文件编码是否全局唯一
	 * @param code
	 * @throws
	 */
	@ResponseBody
	@RequiresPermissions("bas:fileDir:view")
	@RequestMapping(value = "uniqueCheck")
	public String uniqueCheck(String code) {
		if (StringUtils.isNotBlank(code) && fileDirService.getUniqueByCode(code)) {
			return "true";
		}
		return "false";
	}
}
