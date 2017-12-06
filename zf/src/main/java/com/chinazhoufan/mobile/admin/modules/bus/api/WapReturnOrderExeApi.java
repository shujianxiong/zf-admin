/**
 * WapPickOrderApi.java
 * com.chinazhoufan.mobile.admin.modules.bus.api
 *
 * Function： TODO 
 *
 *   ver     date      		author
 * ──────────────────────────────────
 *   		 2017年4月12日 		chenshi
 *
 * Copyright (c) 2017, TNT All Rights Reserved.
*/

package com.chinazhoufan.mobile.admin.modules.bus.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.bus.service.WapReturnOrderExeService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 回货订单执行 API
 * @author   zhangjinjun
 *
 */

@RestController
@RequestMapping(value = "${mobileAdminPath}/user/returnOrderExe")
public class WapReturnOrderExeApi extends BaseRestController {

	@Autowired
	private WapReturnOrderExeService wapReturnOrderExeService;
	
	
	/**
	 * 回货订单执行
	 * @param expressNo
	 * @return
	 */
	@RequestMapping(value = "/returnOrderExe", method = RequestMethod.GET)
	public Echos returnOrderExe(@RequestParam(name = "expressNo", defaultValue = "", required = true)String expressNo) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：returnOrderExe()	请求时间："+DateUtils.getDateTime());
		
		try {

			ReturnOrder returnOrder = new ReturnOrder();
			// 回货订单触发体验单结算
			wapReturnOrderExeService.exeReturnOrder(returnOrder);
			
			return new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
}

