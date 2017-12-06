/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.api;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Address;
import com.chinazhoufan.admin.modules.crm.service.mi.AddressService;
import com.chinazhoufan.admin.modules.sys.service.AreaService;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 会员物流地址管理Controller
 * @author 刘晓东
 * @version 2015-12-23
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapAddressApi extends BaseController {

	@Autowired
	private AddressService addressService;
	@Autowired
	private AreaService areaService;
	
	/**
	 * 前台收货地址列表查询接口
	 * @param memberId
	 * @param goPage
	 * @return
	 */
	@RequestMapping(value = "/address", method = RequestMethod.POST)
	public @ResponseBody 
	String list(HttpServletRequest request){
		Echos echos = null;
		try {
			String memberId = MemberUtils.getMember(request).getId();
			List<Address> list = addressService.findByMember(memberId);
			echos = new Echos(Constants.SUCCESS, list);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 前台收货地址删除接口
	 * @param addressId
	 * @return
	 */
	@RequestMapping(value = "/address/{addressId}", method = RequestMethod.DELETE)
	public @ResponseBody
	String delete(@PathVariable("addressId")String addressId) {
		Echos echos = null;
		try {
			addressService.delete(addressId);
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 前台收货地址设置默认地址接口
	 * @param addressId
	 * @return
	 */
	@RequestMapping(value = "/address/{addressId}", method = RequestMethod.POST)
	public @ResponseBody
	String updateDefaultFlag(@PathVariable("addressId")String addressId) {
		Echos echos = null;
		try {
			addressService.updateDefaultFlag(addressId);
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
}