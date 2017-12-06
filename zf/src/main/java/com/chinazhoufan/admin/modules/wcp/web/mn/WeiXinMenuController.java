/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.web.mn;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mpsdk4j.api.WechatAPIImpl;
import com.chinazhoufan.admin.common.mpsdk4j.exception.WechatApiException;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.Menu;
import com.chinazhoufan.admin.common.utils.CacheUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;
import com.chinazhoufan.admin.modules.wcp.service.mn.MenuService;
import com.chinazhoufan.admin.modules.wcp.vo.mn.MenuVo;
import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;

/**
 * 微信菜单表Controller
 * @author 张金俊
 * @version 2016-05-25
 */
@Controller
@RequestMapping(value = "${adminPath}/wcp/mn/menu")
public class WeiXinMenuController extends BaseController {
	public static final String WECHAT_ONE_MENU = "D_A";//周范儿菜单

	public static final String WECHAT_TWO_MENU = "D_S";//周范珠宝菜单
	@Autowired
	private MenuService menuService;
	
	@ModelAttribute
	public ArticleMsg get(@RequestParam(required=false) String id) {
		ArticleMsg entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = menuService.get(id);
		}
		if (entity == null){
			entity = new ArticleMsg();
		}
		return entity;
	}
	
	/**
     * 展示微信表单（取缓存，缓存为空则查询微信后台）
     */
	@RequiresPermissions("wcp:mn:menu:view")
	@RequestMapping(value = {"list", ""})
	public String list(Menu menu,@RequestParam(required=false)String mpType, HttpServletRequest request, HttpServletResponse response, Model model) {
		MenuVo menuVo = (MenuVo)CacheUtils.get(mpType);
		// 本地缓存没有菜单数据，则从微信后台获取菜单数据
		if(menuVo == null){
			String accountType = null;
			if(WECHAT_TWO_MENU.equals(mpType)){
				accountType = WeiXinConfig.ACCOUNT_D_S;
			}else{
				if(mpType == null){
					mpType = WECHAT_ONE_MENU;
				}
				accountType = WeiXinConfig.ACCOUNT_D_A;
			}
			WechatAPIImpl wechatAPIImpl = WechatAPIImpl.create(WeiXinConfig.getAccountConfig(accountType));
			try{
				List<Menu> menuList = wechatAPIImpl.getMenu();
				menuVo=new MenuVo();
				menuVo.setMenus(menuList);
				CacheUtils.put(mpType, menuVo);
			}
			catch(WechatApiException e){
				addMessage(model,e.getMessage());
			}catch(Exception e){
				e.printStackTrace();
				addMessage(model,"菜单获取失败：请稍后再尝试");
			}
		}
		model.addAttribute("menuVo", menuVo);
		model.addAttribute("mpType", mpType);
		return "modules/wcp/mn/menuList";
	}

	@RequiresPermissions("wcp:mn:menu:view")
	@RequestMapping(value = "form")
	public String form(Model model,@RequestParam(required=false)String mpType) {
		MenuVo menuVo = (MenuVo)CacheUtils.get(mpType);
		if(menuVo==null)
			menuVo=new MenuVo();
		if(menuVo.getMenus()==null||menuVo.getMenus().size()<=0)
			menuVo.setMenus(new ArrayList<Menu>());
		model.addAttribute("menuList", menuVo.getMenus());
		model.addAttribute("mpType", mpType);
		return "modules/wcp/mn/menuForm";
	}

	@RequiresPermissions("wcp:mn:menu:edit")
	@RequestMapping(value = "save")
	public String save(MenuVo menuVo,@RequestParam(required=false)String mpType, Model model, RedirectAttributes redirectAttributes) {
		for(Menu menu:menuVo.getMenus()){
			if(StringUtils.isBlank(menu.getName())||StringUtils.isBlank(menu.getType())){
				addMessage(redirectAttributes, "菜单保存失败：菜名和菜单响应类型不能为空");
				return form(model,mpType);
			}
		}
		WechatAPIImpl wechatAPIImpl = WechatAPIImpl.create(WeiXinConfig.getAccountConfig(mpType));
		try{
			if(wechatAPIImpl.createMenu(menuVo.getMenus())){
				CacheUtils.put(mpType, menuVo);
				addMessage(redirectAttributes, "菜单提交成功：公众号菜单已提交到微信服务器");
			}else{
				addMessage(redirectAttributes, "菜单已成功失败：与微信服务器通讯异常");
			}
		}
		catch(WechatApiException e){
			addMessage(redirectAttributes,e.getMessage());
		}catch(Exception e){
			e.printStackTrace();
			addMessage(redirectAttributes,"菜单获取失败：请稍后再尝试");
		}
		model.addAttribute("mpType", mpType);
		return "redirect:"+Global.getAdminPath()+"/wcp/mn/menu/?repage";
	}
	
	@RequiresPermissions("wcp:mn:menu:edit")
	@RequestMapping(value = "delete")
	public String delete(Menu menu, RedirectAttributes redirectAttributes) {
		if(menu == null || StringUtils.isBlank(menu.getKey())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的微信菜单信息！");
			return "error/400";
		}
		addMessage(redirectAttributes, "删除微信菜单成功");
		return "redirect:"+Global.getAdminPath()+"/wcp/mn/menu/?repage";
	}

}