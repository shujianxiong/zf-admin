/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.api;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.PointDetail;
import com.chinazhoufan.admin.modules.crm.service.mi.PointDetailService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 会员积分账户流水详情Controller
 * @author 刘晓东
 * @version 2015-12-15
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/pointDetail")
public class WapPointDetailController extends BaseController {

	@Autowired
	private PointDetailService pointDetailService;
	
	/**
	 * 前台积分兑换记录接口
	 * @param memberId
	 * @param goPage
	 */
	@RequestMapping(value= "/member/{memberId}/{goPage}" ,method = RequestMethod.POST)
	public @ResponseBody
	String doList(@PathVariable("memberId")String memberId, @PathVariable("goPage")Integer goPage){
		Echos echos = null;
		Page<PointDetail> page = new Page<PointDetail>();
		try {
			page.setPageNo(goPage);
			page = pointDetailService.findPageByMember(page, memberId);
			if(page.getList().isEmpty()){
				echos = new Echos(Constants.NO_MESSAGE);
			}else{
				echos = new Echos(Constants.SUCCESS,page);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}

}