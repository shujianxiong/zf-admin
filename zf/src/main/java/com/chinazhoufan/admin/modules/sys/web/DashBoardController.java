package com.chinazhoufan.admin.modules.sys.web;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.data.service.goods.GoodsStatService;
import com.chinazhoufan.admin.modules.data.service.member.MemberStatService;
import com.chinazhoufan.admin.modules.data.service.order.OrderStatService;
import com.chinazhoufan.admin.modules.data.vo.goods.GoodsStat;
import com.chinazhoufan.admin.modules.data.vo.member.MemberRegStat;
import com.chinazhoufan.admin.modules.data.vo.order.OrderStat;
import com.google.common.collect.Lists;

@Controller
@RequestMapping(value = "${adminPath}/sys/dashboard")
public class DashBoardController extends BaseController {

	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private BuyOrderService buyOrderService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SendOrderService sendOrderService;
	//---------------订单，会员，分类统计
	@Autowired
	private MemberStatService memberStatService;
	@Autowired
	private GoodsStatService goodsStatService;
	@Autowired
	private OrderStatService orderStatService;
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Calendar cal = Calendar.getInstance();
		Date to = cal.getTime();
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Date from = cal.getTime();
		
		//1.当前待发货订单量
		SendOrder sendOrder = new SendOrder();
		sendOrder.setBeginCreateTime(from);
		sendOrder.setEndCreateTime(to);
		sendOrder.setStatus(SendOrder.STATUS_TOPICK);
		List<SendOrder> waitSendOrderList = sendOrderService.findList(sendOrder);
		model.addAttribute("waitSendOrderCount", waitSendOrderList.size());
		
		//2.订单支付比(已支付订单/日订单总量)
		ExperienceOrder experienceOrder = new ExperienceOrder();
		experienceOrder.setBeginCreateDate(from);
		experienceOrder.setEndCreateDate(to);
		int ec = experienceOrderService.statExperienceOrderDayTradingVolume(experienceOrder);
		int eAll = experienceOrderService.findList(experienceOrder).size();
		
		BuyOrder buyOrder = new BuyOrder();
		buyOrder.setBeginCreateDate(from);
		buyOrder.setEndCreateDate(to);
		int bc = buyOrderService.statBuyOrderDayTradingVolume(buyOrder);
		int bAll = buyOrderService.findList(buyOrder).size();
		
		BigDecimal payC = new BigDecimal(ec+bc);
		BigDecimal allC = new BigDecimal(eAll+bAll);
		double rate = 0.0d;
		if(!BigDecimal.ZERO.equals(allC)) {
			BigDecimal result = payC.divide(allC, 4, BigDecimal.ROUND_HALF_UP);
			model.addAttribute("payRate", result);
		}else{
            model.addAttribute("payRate", BigDecimal.ZERO);
        }

		//3.日注册会员量
		Member member = new Member();
		member.setBeginRegisterTime(from);
		member.setEndRegisterTime(to);
		List<Member> mList = memberService.findList(member);
		model.addAttribute("registerMemberCount", mList.size());
		
		//4.当前已发货订单量。
		sendOrder = new SendOrder();
		sendOrder.setBeginUpdateTime(from);
		sendOrder.setEndUpdateTime(to);
		sendOrder.setStatus(SendOrder.STATUS_FINISH);
		List<SendOrder> sendingList = sendOrderService.findList(sendOrder);
		model.addAttribute("sendingOrderCount", sendingList.size());
		
		
		//货品分类库存占比
		List<GoodsStat> categoryStockList = goodsStatService.statGoodsCategoryStockPie();
		model.addAttribute("categoryStockData", categoryStockList);
		
		//组装X轴刻度点
		Calendar c = Calendar.getInstance();
		Map<String, String> msMaps = new LinkedHashMap<String, String>(6);
		Map<String, String> oeMaps = new LinkedHashMap<String, String>(6);
		Map<String, String> obMaps = new LinkedHashMap<String, String>(6);
		
		c.add(Calendar.MONTH, -5);
		int year = 0;
		int month = 0;
		for(int i = 0; i<6;i++) {
			year = c.get(Calendar.YEAR);
			month = c.get(Calendar.MONTH)+1;
			msMaps.put(year+"-"+(month > 9 ? month : "0"+month), "0");
			oeMaps.put(year+"-"+(month > 9 ? month : "0"+month), "0");
			obMaps.put(year+"-"+(month > 9 ? month : "0"+month), "0");
			c.add(Calendar.MONTH, 1);
		}
		
		//会员注册量环比
		List<MemberRegStat> memberRegisterList = memberStatService.statMemberRegisterBar();
		for(String key : msMaps.keySet()) {
			for(MemberRegStat ms: memberRegisterList) {
				if(key.equals(ms.getLabel())) {
					msMaps.put(key, ms.getNum());
				} 
			}
		}
		List<MemberRegStat> returnList = Lists.newArrayList();
		MemberRegStat ms = null;
		for(String key : msMaps.keySet()) {
			ms = new MemberRegStat();
			ms.setLabel(key);
			ms.setNum(msMaps.get(key));
			returnList.add(ms);
		}
		model.addAttribute("memberRegisterData", returnList);
		
		
		//体验订单成交量环比(不包括预约体验)
		List<OrderStat> expTradingVolumeList = orderStatService.statExperienceOrder();
		for(String key : oeMaps.keySet()) {
			for(OrderStat os : expTradingVolumeList) {
				if(key.equals(os.getLabel())) {
					oeMaps.put(key, os.getNum());
				} 
			}
		}
		model.addAttribute("eLabelArr", oeMaps.keySet());
		model.addAttribute("eDataArr",  oeMaps.values());
		
		//销售订单成交量环比(不包括预购)
		List<OrderStat> buyTradingVolumeList = orderStatService.statBuyOrder();
		for(String key : obMaps.keySet()) {
			for(OrderStat os : buyTradingVolumeList) {
				if(key.equals(os.getLabel())) {
					obMaps.put(key, os.getNum());
				} 
			}
		}
		model.addAttribute("bLabelArr", obMaps.keySet());
		model.addAttribute("bDataArr", obMaps.values());
		
		return "modules/sys/dashboard";
	}
	
	public static void main(String[] args) {
		
		Calendar c = Calendar.getInstance();
		
		List<String> keys = Lists.newArrayList();
		
		c.add(Calendar.MONTH, -5);
		for(int i = 0; i<6;i++) {
			int year = c.get(Calendar.YEAR);
			int month = c.get(Calendar.MONTH)+1;
			keys.add(year+"-"+(month > 9 ? month : "0"+month));
			c.add(Calendar.MONTH, 1);
		}
		
		for(String k : keys) {
			System.out.println(k);
		}
	}
	
}
