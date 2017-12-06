package com.chinazhoufan.admin.modules.bus.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.modules.bus.service.op.OrderPayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.op.PayOrder;
import com.chinazhoufan.admin.modules.bus.service.op.PayOrderService;
import com.chinazhoufan.admin.modules.bus.vo.RefundInfo;
import com.chinazhoufan.api.common.pay.CMBCPayCryptUtil;
import com.google.gson.Gson;

/**
 * 退款Service
 * @author liuxiaodong
 * @date 2017-08-18
 */
@Service
public class RefundService {
	
	@Autowired
	PayOrderService payOrderService;
	@Autowired
	OrderPayService orderPayService;
	
	/**
	 * 申请退款金额
	 * @param orderMoney 退款金额
	 * @param payOrderNo 付款单编号
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String createRefundInfo(BigDecimal orderMoney, String payOrderNo) {
		RefundInfo refundInfo = new RefundInfo();
		refundInfo.setMerchantSeq(payOrderNo);
		refundInfo.setOrderAmount((orderMoney.multiply(new BigDecimal(100))).intValue());
		Gson gson = new Gson();
		String context = CMBCPayCryptUtil.cancelTrans(gson.toJson(refundInfo, RefundInfo.class));
		Map<String, Object> map = gson.fromJson(context, Map.class);
		return map.get("gateReturnType").toString();
	}
	
	
	/**
	 * 根据订单ID申请退款（民生银行支付记录，暂时舍弃）
	 * @param orderMoney 退款金额
	 * @param orderId 退款订单ID
	 * @return
	 */
	public String refundByOrder(BigDecimal orderMoney, String orderId) {
		List<PayOrder> payOrderList = payOrderService.findNotRefundListByOrder(orderId);
		String refundStatus = "E";
		for (PayOrder payOrder : payOrderList) {
			if (payOrder.getMoney().doubleValue() < orderMoney.doubleValue()) {
				if ("S".equals(refundStatus)) {
					payOrder.setRefundFlag(PayOrder.FALSE_FLAG);
					payOrder.setRefundAutoMoney(payOrder.getMoney());
					payOrder.setRefundAutoTime(new Date());
					payOrderService.save(payOrder);
				}else {
					throw new ServiceException("自动请求退款失败！");
				}
			}else {
				refundStatus = createRefundInfo(payOrder.getMoney(), payOrder.getNo());
				if ("S".equals(refundStatus)) {
					payOrder.setRefundFlag(PayOrder.FALSE_FLAG);
					payOrder.setRefundAutoMoney(orderMoney);
					payOrder.setRefundAutoTime(new Date());
					payOrderService.save(payOrder);
					break;
				}else {
					throw new ServiceException("自动请求退款失败！");
				}
			}
			orderMoney = orderMoney.subtract(payOrder.getMoney());
		}
		return refundStatus;
	}
}
