/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.web.BaseController;

/**
 * web前端用户订单Controller
 * @author 刘晓东
 * @version 2016-01-22
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapOrderController extends BaseController {
	

	/**
	 * 跳转到我的订单页面
	 * @param orderMemStatus 订单状态
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/myOrderList")
	public String toMyOrderList(String orderMemStatus, Model model) {
		model.addAttribute("orderMemStatus", orderMemStatus);
		return "mobile/wechat/myCenter/myOrder/myOrderList";
	}
	
	
}