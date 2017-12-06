package com.chinazhoufan.admin.modules.data.web.order;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.data.service.order.OrderStatService;
import com.chinazhoufan.admin.modules.data.vo.order.OrderStat;

public class OrderStatController extends BaseController  {

	@Autowired
	private OrderStatService orderStatService;
	
	/**
	 * 销量曲线图名称修改为：体验订单销量环比
	 * 查询历史六个月内订单成交量，最大值为6个月，根据月份分组形成集合数据，绘制曲线图
	 * AREA CHART
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "statExperienceOrder")
	public String statExperienceOrder(HttpServletRequest request, HttpServletResponse response) {
		List<OrderStat> list = orderStatService.statExperienceOrder();
		return JsonMapper.toJsonString(list);
	}
	
	/**
	 * 购货量曲线图名称修改为：销售订单成单量环比
	 * 查询历史六个月内订单成交量，最大值为6个月，根据月份分组形成集合数据，绘制曲线图
	 * LINE CHART
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "statBuyOrder")
	public String statBuyOrder(HttpServletRequest request, HttpServletResponse response) {
		List<OrderStat> list = orderStatService.statBuyOrder();
		return JsonMapper.toJsonString(list);
	}
	
	
	
}
