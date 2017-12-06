package com.chinazhoufan.mobile.index.modules.index.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.mobile.index.modules.index.utils.IndexCacheUtil;

/**
 * 首页Controller
 * @author 杨晓辉
 *
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}")
public class WapHomeController extends BaseController{
	/**
	 * web前端默认跳转首页
	 * @return
	 */
	@RequestMapping(value = "")
	public String toIndex(){
		return "redirect:"+Global.getMobileIndexPath()+"/index";
	}
	/**
	 * 首页一级页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "index")
	public String index(Model model){
		model.addAttribute("index", IndexCacheUtil.getIndex());
		return "mobile/wechat/index/index";
	}
	
}
