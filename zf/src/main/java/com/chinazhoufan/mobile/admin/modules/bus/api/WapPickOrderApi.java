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

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.bus.service.WapPickOrderService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * WAP拣货单API
 * @author   liut
 * @Date	 2017年4月12日		下午1:49:52
 *
 */

@RestController
@RequestMapping(value = "${mobileAdminPath}/user/pickOrder")
public class WapPickOrderApi extends BaseRestController {

	@Autowired
	private WapPickOrderService wapPickOrderService;
	

	/**
	 * 我的拣货列表，按照货位排序显示
	 * @return
	 */
	@RequestMapping(value = "/listMyPickMission", method = RequestMethod.GET)
	public Echos listMyPickMission(HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：listMyPickMission()	请求时间："+DateUtils.getDateTime());
		
		currentUser = getUser(request);
		
		try {
			List<Produce> list = wapPickOrderService.listMyPickMission(currentUser.getId());
			if(list == null || list.size() == 0) 
				return new Echos(Constants.NO_RESULT);
			
			return new Echos(Constants.SUCCESS, list);
		} catch (ServiceException se) {
			return new Echos(Constants.ERROR);
		}
	}
	
	
	
	/**
	 * 按照日期要求，根据拣货人为登录者统计他的发货单数量
	 * @return
	 */
	@RequestMapping(value = "/statSendOrderByPickBy", method = RequestMethod.GET)
	public Echos statSendOrderByPickBy(HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：statSendOrderByPickBy()	请求时间："+DateUtils.getDateTime());
		
		currentUser = getUser(request);
		
		try {
			PickOrder po = new PickOrder();
			po.setPickBy(currentUser);
			
			String result = wapPickOrderService.countSendOrderByPickBy(po);
			if(StringUtils.isBlank(result)) 
				return new Echos(Constants.NO_RESULT);
			
			return new Echos(Constants.SUCCESS, result);
		} catch (ServiceException se) {
			return new Echos(Constants.ERROR);
		}
	}
	
	
	
	
}

