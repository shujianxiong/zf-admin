package com.chinazhoufan.mobile.admin.modules.bus.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.PickOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.bus.service.WapSendOrderService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * WAP发货单API
 * @author liut
 * @author   liut
 * @Date	 2017年4月12日		下午1:49:52
 */
@RestController
@RequestMapping(value = "${mobileAdminPath}/user/sendOrder")
public class WapSendOrderApi extends BaseRestController {

	@Autowired
	private WapSendOrderService wapSendOrderService;
	@Autowired
	private SendOrderService sendOrderService; 
	@Autowired
	private ConfigService configService;
	@Autowired
	private PickOrderService pickOrderService;
	
	/**
	 * 列出刚生产还未拣单的发货单，顺序排
	 * @param pageNo
	 * @param pageSize
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/newList")
	public Echos listNewSendOrder(
			@RequestParam(value="pageNo",required=true, defaultValue="1") Integer pageNo,
			@RequestParam(value="pageSize",required=true, defaultValue="15") Integer pageSize, 
			HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Page<SendOrder> page = new Page<SendOrder>(request, response);
			SendOrder so = new SendOrder();
			Echos echos = new Echos(Constants.SUCCESS, wapSendOrderService.listAll(page, so));
			
			//获取单人单次最大接单数量
			Config con = new Config();
			con.setCode("maxReceiveSendOrderNum");
			Config config = configService.getConfigByCode(con);
			echos.setMessage(config.getConfigValue());

			return echos;
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
		
	}
	
	
	
	/**
	 * 发货单接单
	 * @param ids
	 * @param plateNo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/receiveSendOrder", method = RequestMethod.POST)
	public Echos receiveSendOrder(
			@RequestParam(name = "ids", defaultValue = "", required = true)String ids,
			@RequestParam(name = "plateNo", defaultValue = "", required = true)String plateNo,
			HttpServletRequest request) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：saveRepairRegister()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		if(currentUser == null) {
			return new Echos(Constants.NOT_LOGIN, "请先登录");
		}
		try {
			if(StringUtils.isBlank(ids) || StringUtils.isBlank(plateNo)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			//TODO coco  接单之前需要判断当前拣货员拣货单是否已经全部完成，如果没有，不允许接新单。
			PickOrder po = new PickOrder();
			po.setPickBy(currentUser);
			Integer i = pickOrderService.countUnCompletePickWithPickBy(po);
			if(i != 0)
				return new Echos(Constants.PICK_ORDER_ONE_PERSON_ONE_PICK, "请先完成当前的拣货单!");
//			sendOrderService.receiveSendOrder(ids,null, plateNo, currentUser);
			
			return new Echos(Constants.SUCCESS, "出库单接单成功");
		} catch (ServiceException se) {
			return new Echos(Constants.ERROR);
		}
	}
	
	
	
	
	
	
}
