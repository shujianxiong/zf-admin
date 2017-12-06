/**
 * @author senhui.li
 */
package com.chinazhoufan.admin.modules.wcp.vo.mn;

import java.io.Serializable;
import java.util.List;

import com.chinazhoufan.admin.common.mpsdk4j.vo.api.Menu;
import com.google.common.collect.Lists;

/**
 * 自定义菜单
 * 
 * @author 凡梦星尘(elkan1788@gmail.com)
 * @since 2.0
 */
public class MenuVo implements Serializable {
	private List<Menu> menus;

	public MenuVo() {
		menus=Lists.newArrayList();
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

}
