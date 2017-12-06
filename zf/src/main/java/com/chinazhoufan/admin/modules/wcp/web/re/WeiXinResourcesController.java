/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.web.re;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.Media;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.MediaTemp;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.Menu;
import com.chinazhoufan.admin.common.utils.CacheUtils;
import com.chinazhoufan.admin.common.utils.SystemPath;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;
import com.chinazhoufan.admin.modules.wcp.service.ar.ArticleMsgService;
import com.chinazhoufan.admin.modules.wcp.service.ar.MsgImgService;
import com.chinazhoufan.admin.modules.wcp.vo.mn.MenuVo;
import org.apache.http.client.ClientProtocolException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.chinazhoufan.admin.common.mpsdk4j.api.WechatAPIImpl;
import com.chinazhoufan.admin.common.mpsdk4j.exception.WechatApiException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.HtmlUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * 公众号订阅记录Controller
 * @author 杨晓辉
 * @version 2016-06-02
 */
@Controller
@RequestMapping(value = "${adminPath}/re/mp/resources")
public class WeiXinResourcesController extends BaseController {

	public static final String TEMP_FILE_PATH="uploadTemp";//上传文件临时目录

	@Autowired
	private MsgImgService msgImgService;

	@Autowired
	private ArticleMsgService articleMsgService;
	/**
	 * 周范编号 D_A的素材管理
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = {"list", ""})
	public String list(String mediaType,String pageNo,String pageSize,HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(mediaType))
			mediaType="image";
		if(StringUtils.isBlank(pageNo))
			pageNo="0";
		if(StringUtils.isBlank(pageSize))
			pageSize="20";
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
		String json=null;
		try{
			json = wechatAPIImpl.findMedias(mediaType, pageNo, pageSize);
			//json = json.replace("&quot;","");
		}catch(WechatApiException e){
			e.printStackTrace();
			addMessage(model, "微信资源列表获取失败：请稍后再尝试");
		}
		model.addAttribute("mediaType", mediaType);
		model.addAttribute("jsonData", json);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		
		return "modules/wcp/re/resourcesList";
	}

	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "form")
	public String form( Model model) {
		Media media = new Media();
		model.addAttribute("media", media);
		return "modules/wcp/re/resourcesUpLoad";
	}
	/**
	 * 周范编号 D_A的上传文件管理
	 * @param model
	 * @return
	 */
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "upload", method= RequestMethod.POST)
	public String upload(String type, @RequestParam("file")MultipartFile file , Model model,RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(type))
			type="image";
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
		try {
			Media media = wechatAPIImpl.upLoad(type,file);
			if(media != null){
				addMessage(redirectAttributes,"文件上传成功！");
			}else{
				addMessage(redirectAttributes,"文件上传失败！");
			}

		}catch (Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,e.getMessage());
		}
		model.addAttribute("type", type);
		return "redirect:"+ Global.getAdminPath()+"/re/mp/resources/?repage";
	}

	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "toAddMedia")
	public String toAddMedia( Model model) {
		Media media = new Media();
		model.addAttribute("media", media);
		return "modules/wcp/re/resourcesForm";
	}
	/**
	 * 周范编号 D_A的新增永久素材（图文）
	 * @param model
	 * @return
	 */
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "addMedia", method= RequestMethod.POST)
	public String addMedia(Media media, Model model,RedirectAttributes redirectAttributes) {
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
		try{
			List<MediaTemp> mediaTempParams = media.getMediaTempList();
			List<MediaTemp> mediaTemps = new ArrayList<>();
			for(MediaTemp mediaTemp:mediaTempParams){
				if(mediaTemp.getThumb_media_id() != null){
					mediaTemp.setContent(HtmlUtils.htmlUnescape(mediaTemp.getContent()));
					mediaTemps.add(mediaTemp);
				}

			}
			if(mediaTemps != null && mediaTemps.size() > 0){
				String  mediaId = wechatAPIImpl.addMedia(mediaTemps);
				articleMsgService.articleMsgSave(mediaId,mediaTemps);
				addMessage(redirectAttributes,"新增图文素材成功！");
			}else{
				addMessage(redirectAttributes,"图文素材列表为空！");
			}

		}
		catch(WechatApiException e){
			addMessage(redirectAttributes,e.getMessage());
		}catch(Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,"新增获取失败：请稍后再尝试");
		}

		return "redirect:"+ Global.getAdminPath()+"/re/mp/resources/?repage";
	}
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "toMesUp")
	public String toMesUp( Model model) {
		Media media = new Media();
		model.addAttribute("media", media);
		return "modules/wcp/re/resourcesMesImgUpLoad";
	}
	/**
	 * 周范编号 D_A的上传文件管理
	 * @param model
	 * @return
	 */
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "mesUp", method= RequestMethod.POST)
	public String mesUp( @RequestParam("file")MultipartFile file , Model model,RedirectAttributes redirectAttributes) {
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
		try {
			Media media = wechatAPIImpl.upLoad(null,file);
			if(media != null){
				msgImgService.msgImgSave(file.getOriginalFilename(),media.getPhoto());
				addMessage(redirectAttributes,"文件上传成功！");
			}else{
				addMessage(redirectAttributes,"文件上传失败！");
			}
		}catch (Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,e.getMessage());
		}
		return "redirect:"+ Global.getAdminPath()+"/re/mp/resources/?repage";
	}

	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "toUpdateArticle")
	public String toUpdateArticle( String mediaId,Model model) {
		MediaTemp mediaTemp = new MediaTemp();
		mediaTemp.setMediaId(mediaId);
		model.addAttribute("mediaTemp", mediaTemp);
		return "modules/wcp/re/resourcesUpdate";
	}
	/**
	 * 修改图文
	 * @param model
	 * @return
	 */
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "updateArticle", method= RequestMethod.POST)
	public String updateArticle(MediaTemp mediaTemp, Model model,RedirectAttributes redirectAttributes) {
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
		try {
			mediaTemp.setContent(HtmlUtils.htmlUnescape(mediaTemp.getContent()));
			Boolean result = wechatAPIImpl.updateArticle(mediaTemp);
			if (!result) {
				addMessage(redirectAttributes, "修改素材参数格式不正确，请重新新增！");
			} else {
				articleMsgService.articleMsgUpdate(mediaTemp);
				addMessage(redirectAttributes, "修改素材成功！");
			}
		}
		catch(WechatApiException e){
			addMessage(redirectAttributes,e.getMessage());
		}catch(Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,"修改获取失败：请稍后再尝试");
		}

		return "redirect:"+ Global.getAdminPath()+"/re/mp/resources/?repage";
	}
	/**
	 * 删除图文
	 * @param model
	 * @return
	 */
	@RequiresPermissions("re:mp:resources:view")
	@RequestMapping(value = "delArticle", method= RequestMethod.POST)
	public String delArticle(String mediaId, Model model,RedirectAttributes redirectAttributes) {
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
		try {
			Boolean result = wechatAPIImpl.delMedia(mediaId);
			if (!result) {
				addMessage(redirectAttributes, "删除素材参数格式不正确！");
			} else {
				articleMsgService.deleteByMediaId(mediaId);
				addMessage(redirectAttributes, "删除素材成功！");
			}
		}
		catch(WechatApiException e){
			addMessage(redirectAttributes,e.getMessage());
		}catch(Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,"删除获取失败：请稍后再尝试");
		}
		return "redirect:"+ Global.getAdminPath()+"/re/mp/resources/?repage";
	}
}