package com.chinazhoufan.admin.modules.bas.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.modules.lgt.entity.ps.Warearea;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.Video;
import com.chinazhoufan.admin.modules.bas.service.VideoService;

import java.util.List;
import java.util.Map;

/**
 * 视频控制器
 * @author liuxiaodong
 *
 */
@Controller
@RequestMapping(value="${adminPath}/bas/video")
public class VideoController extends BaseController {
	
	@Autowired
	private VideoService videoService;

	
	@ModelAttribute
	public Video get(@RequestParam(required=false) String id) {
		Video entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = videoService.get(id);
		}
		if (entity == null){
			entity = new Video();
		}
		return entity;
	}
	
	@RequiresPermissions("bas:video:view")
	@RequestMapping(value = {"list", ""})
	public String list(Video video, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Video> page = videoService.findPage(new Page<Video>(request, response), video); 
		model.addAttribute("page", page);
		return "modules/bas/videoList";
	}

	@RequiresPermissions("bas:video:view")
	@RequestMapping(value = "form")
	public String form(Video video, Model model) {
		model.addAttribute("video", video);
		return "modules/bas/videoForm";
	}

	@RequiresPermissions("bas:video:edit")
	@RequestMapping(value = "save")
	public String save(Video video,@RequestParam("file")MultipartFile file, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, video)){
			return form(video, model);
		}
		videoService.uploadVideo(file, video);
		addMessage(redirectAttributes, "视频已在后台上传，请稍后在列表中查看");
		return "redirect:"+Global.getAdminPath()+"/bas/video/?repage";
	}
	
	@RequiresPermissions("bas:video:edit")
	@RequestMapping(value = "delete")
	public String delete(Video video, RedirectAttributes redirectAttributes) {
		videoService.delete(video);
		addMessage(redirectAttributes, "删除视频成功");
		return "redirect:"+Global.getAdminPath()+"/bas/video/?repage";
	}

    @RequiresPermissions("bas:video:view")
    @RequestMapping(value = "info")
    public String info(Video video, Model model) {
        model.addAttribute("video", video);
        return "modules/bas/videoInfo";
    }
	/**
	 * 查询视频<树插件级联查询使用>
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "videoTreeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String type, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Video video =new Video();
		video.setType(type);
		List<Video> videos = videoService.findList(video);//视频列表
		Map<String,Object> map = null;
		map = Maps.newHashMap();
		map.put("id","0");
		map.put("code", "0");
		map.put("name", "请选择视频");
		map.put("pId", "");
		map.put("fileUrl", "");
		map.put("type", "0");
		mapList.add(map);
		for(Video deo:videos){
			map = Maps.newHashMap();
			map.put("id", deo.getId());
			map.put("code", deo.getCode());
			map.put("name", deo.getCode());
			map.put("pId", "");
			map.put("fileUrl", deo.getFileUrl());
			map.put("type", deo.getType());
			mapList.add(map);
		}
		return mapList;
	}
	
}
