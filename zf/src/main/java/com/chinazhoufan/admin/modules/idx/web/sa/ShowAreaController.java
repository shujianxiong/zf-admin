/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.sa;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.entity.Video;
import com.chinazhoufan.admin.modules.bas.service.VideoService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
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
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.idx.entity.sa.ShowArea;
import com.chinazhoufan.admin.modules.idx.service.sa.ShowAreaService;

import java.util.List;

/**
 * 周范秀场Controller
 * @author 张金俊
 * @version 2017-08-07
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/sa/showArea")
public class ShowAreaController extends BaseController {

	@Autowired
	private ShowAreaService showAreaService;

	@Autowired
	private VideoService videoService;
	
	@ModelAttribute
	public ShowArea get(@RequestParam(required=false) String id) {
		ShowArea entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = showAreaService.get(id);
		}
		if (entity == null){
			entity = new ShowArea();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:sa:showArea:view")
	@RequestMapping(value = {"list", ""})
	public String list(ShowArea showArea, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ShowArea> page = showAreaService.findPage(new Page<ShowArea>(request, response), showArea); 
		model.addAttribute("page", page);
		return "modules/idx/sa/showAreaList";
	}

	@RequiresPermissions("idx:sa:showArea:view")
	@RequestMapping(value = "form")
	public String form(ShowArea showArea, Model model) {
		if(showArea != null && showArea.getVideo() != null){
			Video video = new Video();
			video.setFileUrl(showArea.getVideo());
			List<Video> selVideoList =videoService.findList(video);
			if(selVideoList != null && selVideoList.size()>0){
				showArea.setDeo(selVideoList.get(0));
			}
		}
		//设置启用默认值
		if(StringUtils.isBlank(showArea.getUsableFlag())){
			showArea.setUsableFlag(showArea.FALSE_FLAG);
		}
		model.addAttribute("showArea", showArea);
		return "modules/idx/sa/showAreaForm";
	}

	@RequiresPermissions("idx:sa:showArea:edit")
	@RequestMapping(value = "save")
	public String save(ShowArea showArea, Model model, RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, showArea)){
			return form(showArea, model);
		}*/
		try {
			if(showArea != null && showArea.getDeo() != null){
				Video selVideo =videoService.get(showArea.getDeo().getId());
				if(selVideo != null){
					showArea.setVideo(selVideo.getFileUrl());
				}
			}
			showAreaService.save(showArea);
			addMessage(redirectAttributes, "保存周范秀场成功");
		}catch(ServiceException e){
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "失败：保存周范秀场异常");
		}
		return "redirect:"+Global.getAdminPath()+"/idx/sa/showArea/?repage";
	}
	
	@RequiresPermissions("idx:sa:showArea:edit")
	@RequestMapping(value = "delete")
	public String delete(ShowArea showArea, RedirectAttributes redirectAttributes) {
		showAreaService.delete(showArea);
		addMessage(redirectAttributes, "删除周范秀场成功");
		return "redirect:"+Global.getAdminPath()+"/idx/sa/showArea/?repage";
	}

    @RequiresPermissions("idx:sa:showArea:view")
    @RequestMapping(value = "info")
    public String info(ShowArea showArea, Model model) {
        model.addAttribute("showArea", showArea);
        return "modules/idx/sa/showAreaInfo";
    }
	/**
	 * 更新周范秀场启用状态
	 * @param id
	 * @param usableFlag  操作类型，（启用=1， 停用=0）
	 * @param model
	 * @return
	 */
	@RequiresPermissions("idx:sa:showArea:edit")
	@RequestMapping(value = "updateUsable")
	public String updateStatus(String id, String usableFlag, RedirectAttributes redirectAttributes, Model model) {

		Echos echo = null;
		//获取操作类型（启用=1， 停用=0）
		String returnUrl = Global.getAdminPath()+"/idx/sa/showArea/?repage";
		if(StringUtils.isBlank(id)){
			addMessage(redirectAttributes, "周范秀场启用状态变更失败：未获取到周范秀场状态信息");
			return returnUrl;

		}

		//获取原有的周范秀场状态参数信息
		ShowArea showAreaOld = showAreaService.get(id);
		//获取周范秀场对应的状态信息
		if("0".equals(usableFlag)){
			showAreaOld.setUsableFlag(showAreaOld.FALSE_FLAG);
		}else if("1".equals(usableFlag)){
			showAreaOld.setUsableFlag(showAreaOld.TRUE_FLAG);
		}
		showAreaService.save(showAreaOld);
		addMessage(redirectAttributes, "周范秀场状态操作成功");
		return "redirect:"+returnUrl;
	}
}