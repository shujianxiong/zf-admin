/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.web;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Address;
import com.chinazhoufan.admin.modules.crm.service.mi.AddressService;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;

/**
 * 会员物流地址前端跳转页面管理Controller
 * @author 贾斌
 * @version 2015-12-25
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member/addressWeb")
public class WapAddressController extends BaseController {

	@Autowired
	private AddressService addressService;
	
	/**
	 * 跳转到用户个人收货地址列表页面
	 * @return
	 */
	@RequestMapping(value = "/toAddressList")
	public String toAddressList(){
		return "mobile/wechat/address/addressList";
	}
	
	/**
	 * 跳转到用户个人收货地址添加页面和修改收货地址
	 * @return
	 */
	@RequestMapping(value = "/toAddressSave")
	public String toAddressSave(String addressId,Model model){
		//addressId不为空表示是修改否者为添加
		if(StringUtils.isNotBlank(addressId)){
			Address address = addressService.get(addressId);
			model.addAttribute("address", address);
			model.addAttribute("addressId", addressId);
		}
		return "mobile/wechat/address/address";
	}
	
	/**
	 * 前台收货地址添加接口
	 * @param memberId
	 * @param receiveName
	 * @param receiveTel
	 * @param zipCode
	 * @param areaId
	 * @param addressDetail
	 * @return 保存成功之后跳转到列表页面
	 */
	@RequestMapping(value = "/address", method = RequestMethod.POST)
	public String addAddress(Address address, HttpServletRequest request) {
		try {
			address.setMember(MemberUtils.getMember(request));//设置为当前会员
			addressService.save(address);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:"+Global.getMobileIndexPath()+"/member/addressWeb/toAddressList";
	}
}