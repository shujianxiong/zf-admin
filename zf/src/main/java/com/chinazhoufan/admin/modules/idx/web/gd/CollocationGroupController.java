/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.gd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.entity.Video;
import com.chinazhoufan.admin.modules.bas.service.VideoService;
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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.idx.entity.gd.CollocationGroup;
import com.chinazhoufan.admin.modules.idx.service.gd.CollocationGroupService;
import com.chinazhoufan.admin.modules.idx.service.gd.CollocationService;

/**
 * 搭配分组Controller
 * @author liut
 * @version 2017-03-15
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/gd/collocationGroup")
public class CollocationGroupController extends BaseController {

	@Autowired
	private CollocationGroupService collocationGroupService;
	@Autowired
	private CollocationService collocationService;
	@Autowired
	private VideoService videoService;
	
	@ModelAttribute
	public CollocationGroup get(@RequestParam(required=false) String id) {
		CollocationGroup entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = collocationGroupService.get(id);
		}
		if (entity == null){
			entity = new CollocationGroup();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:gd:collocationGroup:view")
	@RequestMapping(value = {"list", ""})
	public String list(CollocationGroup collocationGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CollocationGroup> page = collocationGroupService.findPage(new Page<CollocationGroup>(request, response), collocationGroup); 
		model.addAttribute("page", page);
		return "modules/idx/gd/collocationGroupList";
	}

	@RequiresPermissions("idx:gd:collocationGroup:view")
	@RequestMapping(value = "form")
	public String form(CollocationGroup collocationGroup, Model model) {
		if(StringUtils.isBlank(collocationGroup.getId())) {
			Collocation coll = collocationService.get(collocationGroup.getCollocation());
			collocationGroup.setCollocation(coll);
			model.addAttribute("collocationGroup", collocationGroup);
		} else {
			Video selVideo =null;
			if(collocationGroup.getVideo() != null){
				Video video = new Video();
				video.setFileUrl(collocationGroup.getVideo());
				selVideo =videoService.findList(video).get(0);
			}
			CollocationGroup collocationGroupWithDetail = collocationGroupService.getCollocationWithGroupGoods(collocationGroup);
			if(selVideo != null){
				collocationGroupWithDetail.setDeo(selVideo);
			}
			model.addAttribute("collocationGroup", collocationGroupWithDetail);
		}
		return "modules/idx/gd/collocationGroupForm";
	}

	@RequiresPermissions("idx:gd:collocationGroup:edit")
	@RequestMapping(value = "save")
	public String save(CollocationGroup collocationGroup, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, collocationGroup)){
			return form(collocationGroup, model);
		}
		try {
			if(collocationGroup.getDeo().getId().equals("0")){
				collocationGroup.setVideo(null);
			}
			if(collocationGroup != null && collocationGroup.getDeo() != null && !collocationGroup.getDeo().getId().equals("")&& !collocationGroup.getDeo().getId().equals("0")){
				Video selVideo =videoService.get(collocationGroup.getDeo().getId());
				if(selVideo != null){
					collocationGroup.setVideo(selVideo.getFileUrl());
				}
			}
			collocationGroupService.save(collocationGroup);
			addMessage(redirectAttributes, "保存搭配分组成功");
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/idx/gd/collocationGroup/list?collocation.id="+collocationGroup.getCollocation().getId();
	}
	
	@RequiresPermissions("idx:gd:collocationGroup:edit")
	@RequestMapping(value = "delete")
	public String delete(CollocationGroup collocationGroup, RedirectAttributes redirectAttributes) {
		collocationGroupService.delete(collocationGroup);
		addMessage(redirectAttributes, "删除搭配分组成功");
		return "redirect:"+Global.getAdminPath()+"/idx/gd/collocationGroup/list?collocation.id="+collocationGroup.getCollocation().getId();
	}

    @RequiresPermissions("idx:gd:collocationGroup:view")
    @RequestMapping(value = "info")
    public String info(CollocationGroup collocationGroup, Model model) {
        model.addAttribute("collocationGroup", collocationGroupService.getCollocationWithGroupGoods(collocationGroup));
        return "modules/idx/gd/collocationGroupInfo";
    }
    
    @RequiresPermissions("idx:gd:collocationGroup:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(CollocationGroup collocationGroup, RedirectAttributes redirectAttributes) {
		try {
    	collocationGroup.setUsableFlag(CollocationGroup.TRUE_FLAG.equals(collocationGroup.getUsableFlag()) ? CollocationGroup.FALSE_FLAG : CollocationGroup.TRUE_FLAG);
		addMessage(redirectAttributes, (CollocationGroup.TRUE_FLAG.equals(collocationGroup.getUsableFlag()) ? "启用" : "停用")+"搭配分组成功");
		collocationGroupService.updateUsable(collocationGroup);
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
    	return "redirect:"+Global.getAdminPath()+"/idx/gd/collocationGroup/list?collocation.id="+collocationGroup.getCollocation().getId();
    }
    
    
    
}