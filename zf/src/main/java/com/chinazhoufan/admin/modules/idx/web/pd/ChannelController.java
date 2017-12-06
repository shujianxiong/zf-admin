/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.web.pd;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;
import com.chinazhoufan.admin.modules.idx.entity.pd.Channel;
import com.chinazhoufan.admin.modules.idx.service.gd.SceneService;
import com.chinazhoufan.admin.modules.idx.service.pd.ChannelService;

/**
 * 频道Controller
 * @author 张金俊
 * @version 2016-08-12
 */
@Controller
@RequestMapping(value = "${adminPath}/idx/pd/channel")
public class ChannelController extends BaseController {

	@Autowired
	private ChannelService channelService;
	@Autowired
	private SceneService sceneService;
	
	@ModelAttribute
	public Channel get(@RequestParam(required=false) String id) {
		Channel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = channelService.get(id);
		}
		if (entity == null){
			entity = new Channel();
		}
		return entity;
	}
	
	@RequiresPermissions("idx:pd:channel:view")
	@RequestMapping(value = {"list", ""})
	public String list(Channel channel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Channel> page = channelService.findPage(new Page<Channel>(request, response), channel); 
		model.addAttribute("page", page);
		return "modules/idx/pd/channelList";
	}

	@RequiresPermissions("idx:pd:channel:view")
	@RequestMapping(value = "form")
	public String form(Channel channel, Model model) {
		if(StringUtils.isBlank(channel.getId())) {
			channel.setUsableFlag(Channel.TRUE_FLAG);
		}else {
			channel = channelService.getDetail(channel.getId());
		}
		model.addAttribute("channel", channel);
//		List<Scene> sceneList = sceneService.findUsableSubList();
//		model.addAttribute("sceneList", sceneList);
		return "modules/idx/pd/channelForm";
	}

	@RequiresPermissions("idx:pd:channel:edit")
	@RequestMapping(value = "save")
	public String save(Channel channel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, channel)){
			return form(channel, model);
		}
		channelService.save(channel);
		addMessage(redirectAttributes, "保存频道成功");
		return "redirect:"+Global.getAdminPath()+"/idx/pd/channel/?repage";
	}
	
	@RequiresPermissions("idx:pd:channel:edit")
	@RequestMapping(value = "delete")
	public String delete(Channel channel, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(channel.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的频道信息！");
			return "error/400";
		}
		channelService.delete(channel);
		addMessage(redirectAttributes, "删除频道成功");
		return "redirect:"+Global.getAdminPath()+"/idx/pd/channel/?repage";
	}

	@RequiresPermissions("idx:pd:channel:view")
	@RequestMapping(value = "info")
	public String info(Channel channel, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(channel.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的频道信息！");
			return "error/400";
		}
		channel = channelService.getDetail(channel.getId());
		model.addAttribute("channel", channel);
		return "modules/idx/pd/channelInfo";
	}
	
	
	@RequiresPermissions("idx:pd:channel:edit")
    @RequestMapping(value = "updateFlag")
    public String updateFlag(Channel channel, RedirectAttributes redirectAttributes) {
		channel.setUsableFlag(Channel.TRUE_FLAG.equals(channel.getUsableFlag()) ? Channel.FALSE_FLAG : Channel.TRUE_FLAG);
		channelService.save(channel);
		addMessage(redirectAttributes, (Channel.TRUE_FLAG.equals(channel.getUsableFlag()) ? "启用" : "停用")+"场景成功");
		return "redirect:"+Global.getAdminPath()+"/idx/pd/channel/?repage";
    }
    
	
	
	
}