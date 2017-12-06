/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.security.shiro.session.SessionDAO;
import com.chinazhoufan.admin.common.utils.CookieUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.sys.dao.MenuDao;
import com.chinazhoufan.admin.modules.sys.entity.Menu;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.security.FormAuthenticationFilter;
import com.chinazhoufan.admin.modules.sys.service.SystemService;

/**
 * 登录Controller
 * @author 杨晓辉
 * @version 2016-3-31
 */
@Controller
@RequestMapping(value = "${supplierPath}")
public class SupplierLoginController extends BaseController{
	
	@Autowired
	private SessionDAO sessionDAO;
	@Autowired
	private SystemService systemService;
	@Autowired
	private MenuDao menuDao;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index(HttpServletRequest request, HttpServletResponse response, Model model){
		return "modules/sys/supplierLogin";
	}
	
	/**
	 * 供应商登录
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User u = new User();
		u.setUserCategory(User.SUPPLIER_CATAGORY);
		u.setLoginName(username);
		u.setPassword(password);
		User user = systemService.getByLoginNameForSupplier(u);
		String message = "";
		if(user == null) {
			message = "账号"+username+"不存在,请核查";
			model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
			return "modules/sys/supplierLogin";
		} else {
			boolean flag = SystemService.validatePassword(password, user.getPassword());
			if(!flag) {
				message = "密码错误,请核查";
				model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
				return "modules/sys/supplierLogin";
			}
		} 
		/*Role role = systemService.getRoleByUserIdAndRoleEnName(user.getId());
		if(role == null) {
			message = "此账号没有访问供应商模块的权限，请先核对下账号拥有的权限信息";
			model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
			return "modules/sys/supplierLogin";
		}*/
		
		if(!"S".equals(user.getUserCategory())) {
			message = "此账号没有访问供应商模块的权限，请先核对下账号拥有的权限信息";
			model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
			return "modules/sys/supplierLogin";
		}
		
		Menu m = new Menu();
		m.setUserId(user.getId());
		List<Menu> menuList = menuDao.findByUserId(m);
		String json = JsonMapper.toJsonString(menuList);
		model.addAttribute("supplierMenuListJson", json);
		model.addAttribute("user", user);
		return "modules/sys/supplierIndex";
	}
	
	
	@RequestMapping(value = "loginOut", method = RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response, Model model) {
		CookieUtils.setCookie(response, "LOGINED", "false");
		return "modules/sys/supplierLogin";
	}
	
}
