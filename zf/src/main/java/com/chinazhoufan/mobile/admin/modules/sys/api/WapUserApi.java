/**
 * WapUserApi.java
 * com.chinazhoufan.mobile.admin.modules.sys.api
 *
 * Function： TODO 
 *
 *   ver     date      		author
 * ──────────────────────────────────
 *   		 2017年4月6日         liut
 *
 * Copyright (c) 2017, TNT All Rights Reserved.
*/

package com.chinazhoufan.mobile.admin.modules.sys.api;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.sys.entity.Menu;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.sys.dto.MenuDTO;
import com.chinazhoufan.mobile.admin.modules.sys.service.WapUserService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * ClassName:WapUserApi
 * 说明：企业通讯录接口
 * @author   liut
 * @Date	 2017年4月6日		上午10:53:09
 *
 */
@RestController
@RequestMapping(value = "${mobileAdminPath}/user")
public class WapUserApi extends BaseRestController {

	@Autowired
	private WapUserService wapUserService;
	@Autowired
	private SystemService systemService;
	
	
	/**
	 * 企业通讯录接口
	 * @param sysUserId
	 * @param category
	 * @param type
	 * @param status
	 * @param goPage
	 * @param response
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public Echos listUser() {
		Echos echos = null;
		try {
			List<User> userList = wapUserService.listAllUser();
			if (userList == null || userList.isEmpty()) {
				echos = new Echos(Constants.NO_RESULT);
			}else {
				echos = new Echos(Constants.SUCCESS, userList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**
	 * 获取角色为拣货员的用户列表
	 * @return
	 */
	@RequestMapping(value = "/listUserWithJHY",method = RequestMethod.GET)
	public Echos listUserWithRole() {
		Echos echos = null;
		try {
			Role role = new Role();
			role.setEnname("jhy");//拣货员角色的英文名称
			List<User> userList = wapUserService.listUserByRole(role);
			if (userList == null || userList.isEmpty()) {
				echos = new Echos(Constants.NO_RESULT);
			}else {
				echos = new Echos(Constants.SUCCESS, userList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	/**
	 * 根据一级菜单的权限获取下面的二级菜单列表
	 * @return
	 */
	@RequestMapping(value = "/listMenuByPermission",method = RequestMethod.GET)
	public Echos listMenuByPermission(@RequestParam(name = "permission", defaultValue="", required=true)String permission) {
		Echos echos = null;
		try {
			List<Menu> menuList = systemService.findMenuByPermission(permission);
			if(menuList != null && menuList.size() > 0) {
				Menu m = menuList.get(0);
				if(m != null) {
					List<Menu> mList = systemService.findMenuByParentId(m);
					
					if(mList != null && mList.size() > 0) {
						List<MenuDTO> menuDTOList = new ArrayList<MenuDTO>();
						for(Menu menu : mList){
							MenuDTO menuDTO = null;
							if(StringUtils.isNotEmpty(menu.getPermission())){
								menuDTO = new MenuDTO(menu.getPermission());
								if(Menu.TRUE_FLAG.equals(menu.getIsShow())){
									// menu显示状态为“不显示”，则该menu为菜单
									menuDTO.setPermissionType(MenuDTO.PERMISSIONTYPE_MENU);
									// 设置菜单的未完成任务数量
									switch (menu.getPermission()) {
									default:
										menuDTO.setTodoNum(0);
										break;
									}
									//菜单或功能加入menuDTO传输给移动端
									menuDTOList.add(menuDTO);
								}
							}
						}
						if (menuList == null || menuList.isEmpty()) {
							echos = new Echos(Constants.NO_RESULT);
						}else {
							echos = new Echos(Constants.SUCCESS, menuDTOList);
						}
					} else {
						echos = new Echos(Constants.ERROR, "该菜单项下无子菜单");
					}
				}
			} else {
				echos = new Echos(Constants.ERROR, "没找到权限名称为"+permission+"的菜单项");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
}

