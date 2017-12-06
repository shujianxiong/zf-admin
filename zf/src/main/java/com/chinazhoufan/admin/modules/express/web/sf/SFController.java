package com.chinazhoufan.admin.modules.express.web.sf;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.express.utils.SFUtils;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressAppointRecord;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressInfoRecord;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressAppointRecordService;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressInfoRecordService;

/**
 * 顺丰通知接口
 * @author liuxiaodong
 * @date 2017-11-15
 */
@Controller
@RequestMapping("/sf")
public class SFController extends BaseController {

	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	private ExperienceOrderService experienceOrderService;
	@Autowired
	private ExpressAppointRecordService expressAppointRecordService;
	@Autowired
	private ExpressInfoRecordService expressInfoRecordService;
    @Autowired
    private ReturnOrderService returnOrderService;


    @RequestMapping(value = "/routePushCall")
    @ResponseBody
    public String routePushCall(@RequestParam("content")String content, HttpServletRequest request){

        logger.info("-------------------顺丰参数获取-------------------");

        content = StringEscapeUtils.unescapeXml(content);
        logger.info(content);
        try {
            List<ExpressInfoRecord> list = SFUtils.resolveRoute(content);
            if (list==null||list.isEmpty()){
                return returnXML("参数为空！");
            }else {
                logger.info(list.toString());
                for (ExpressInfoRecord expressInfoRecord : list) {
                    String  sendOrderNo  = expressInfoRecord.getExpressOrderId();
                    SendOrder sendOrder = sendOrderService.getBySendOrderNo(sendOrderNo);
                    if (sendOrder !=null ) {
                    	ExperienceOrder experienceOrder	 = experienceOrderService.get(sendOrder.getOrderId());
                        if (experienceOrder == null) {
                            return returnXML("未找到对应订单");
                        } else {
                        /*签收时更新订单状态为已签收*/
                            if ("80".equals(expressInfoRecord.getStatus())){
                                //只有体验单才做确认送达
                                if(SendOrder.ORDERTYPE_EXPERIENCE.equals(sendOrder.getOrderType())){
                                    //设置体验时间,次日的零点
                                    Calendar cal = Calendar.getInstance();
                                    cal.setTime(new Date());
                                    cal.set(Calendar.HOUR_OF_DAY, 0);
                                    cal.set(Calendar.MINUTE, 0);
                                    cal.set(Calendar.SECOND, 0);
                                    cal.set(Calendar.MILLISECOND, 0);
                                    cal.add(Calendar.DAY_OF_MONTH, 1);
                                    Date realExpDate = cal.getTime();
                                    experienceOrderService.updateOrderStatusByExpress(realExpDate,sendOrder.getOrderNo(), ExperienceOrder.EXPRESS_SIGNED);
                                }
                                //对应发货单状态更新成签收
                                sendOrder.setStatus(SendOrder.STATUS_SIGNED);
                                sendOrderService.save(sendOrder);
                            }else if("33".equals(expressInfoRecord.getStatus())){
                                experienceOrderService.updateOrderStatusByExpress(null,sendOrder.getOrderNo(), ExperienceOrder.EXPRESS_FAILED);
                            }
                            expressInfoRecord.setMember(experienceOrder.getMember());
                            expressInfoRecord.setOrderType(sendOrder.getOrderType());
                            expressInfoRecord.setOrderId(experienceOrder.getId());
                            expressInfoRecord.setStatus(expressInfoRecord.getStatus());
                            expressInfoRecord.setSendOrderType(sendOrder.getType());
                            expressInfoRecord.setStatusDescription(expressInfoRecord.getStatusDescription());
                            expressInfoRecord.setTime(new Date());
                            expressInfoRecordService.save(expressInfoRecord);
                            return returnXML(null);
                        }
					}else {
						ExpressAppointRecord expressAppointRecord = expressAppointRecordService.getByExpressOrderId(expressInfoRecord.getExpressOrderId());
			            ExperienceOrder experienceOrder	 = experienceOrderService.get(expressAppointRecord.getOrderId());
			            ReturnOrder returnOrder = returnOrderService.getByOrder("", expressAppointRecord.getOrderId());
			            if (experienceOrder == null) {
			                return reverseReturnXML("未找到对应订单");
			            } else {
			                /*已收件更新订单状态为退货中*/
			                if ("50".equals(expressInfoRecord.getStatus())){
			                    experienceOrder.setStatusMember(ExperienceOrder.STATUSMEMBER_RETURNING);
			                    experienceOrder.setStatusSystem(ExperienceOrder.STATUSSYSTEM_RETURNING);
			                    experienceOrderService.save(experienceOrder);
			                    returnOrder.setStatus(ReturnOrder.STATUS_RETURNING);
			                    returnOrderService.save(returnOrder);
			                }
			                expressInfoRecord.setMember(experienceOrder.getMember());
			                expressInfoRecord.setOrderType(expressAppointRecord.getOrderType());
			                expressInfoRecord.setOrderId(experienceOrder.getId());
			                expressInfoRecord.setStatus(expressInfoRecord.getStatus());
			                expressInfoRecord.setSendOrderType(ExpressInfoRecord.ORDER_EXPERIENCE);
			                expressInfoRecord.setStatusDescription(expressInfoRecord.getStatusDescription());
			                expressInfoRecord.setTime(new Date());
			                expressInfoRecordService.save(expressInfoRecord);
			                return returnXML(null);
			            }
					}
                }
            }
        }catch (Exception e){
            return returnXML(e.getMessage());
        }
        return returnXML("参数错误！");
    }


    private String returnXML(String message) {
        if (StringUtils.isNotBlank(message)) {
            return "<Response service=\"RoutePushService\" lang=\"zh-CN\"><Head>ERR</Head><ERROR code=\"4001\">"+message+"</ERROR></Response>";
        }else {
            return "<Response service=\"RoutePushService\" lang=\"zh-CN\"><Head>OK</Head></Response>";
        }
    }

    private String reverseReturnXML(String message) {
        if (StringUtils.isNotBlank(message)) {
            return "<Response><Head>ERR</Head><ERROR code=\"4001\">"+message+"</ERROR></Response>";
        }else {
            return "<Response><Head>OK</Head></Response>";
        }
    }

    @RequestMapping(value = "/reverseRoutePushCall")
    @ResponseBody
    public String reverseRoutePushCall(@RequestParam("content")String content, HttpServletRequest request){
        logger.info("-------------------顺丰逆向参数获取-------------------");
        content = StringEscapeUtils.unescapeXml(content);
        logger.info(content);
        try {
            ExpressInfoRecord expressInfoRecord = SFUtils.resolveReverseRoute(content);
            ExpressAppointRecord expressAppointRecord = expressAppointRecordService.getByExpressOrderId(expressInfoRecord.getExpressOrderId());
            ExperienceOrder experienceOrder	 = experienceOrderService.get(expressAppointRecord.getOrderId());
            ReturnOrder returnOrder = returnOrderService.getByOrder("", expressAppointRecord.getOrderId());
            if (experienceOrder == null) {
                return reverseReturnXML("未找到对应订单");
            } else {
                /*已收件更新订单状态为退货中*/
                if ("60".equals(expressInfoRecord.getStatus())){
                    experienceOrder.setStatusMember(ExperienceOrder.STATUSMEMBER_RETURNING);
                    experienceOrder.setStatusSystem(ExperienceOrder.STATUSSYSTEM_RETURNING);
                    experienceOrderService.save(experienceOrder);
                    returnOrder.setStatus(ReturnOrder.STATUS_RETURNING);
                    returnOrderService.save(returnOrder);
                }else if ("50".equals(expressInfoRecord.getStatus())) {
                	expressAppointRecord.setStatus(ExpressAppointRecord.SYSTEM_STATUS_CANCEL);
                	expressAppointRecordService.save(expressAppointRecord);
				}
                expressInfoRecord.setMember(experienceOrder.getMember());
                expressInfoRecord.setOrderType(expressAppointRecord.getOrderType());
                expressInfoRecord.setOrderId(experienceOrder.getId());
                expressInfoRecord.setStatus(expressInfoRecord.getStatus());
                expressInfoRecord.setSendOrderType(ExpressInfoRecord.ORDER_EXPERIENCE);
                expressInfoRecord.setStatusDescription(expressInfoRecord.getStatusDescription());
                expressInfoRecord.setTime(new Date());
                expressInfoRecordService.save(expressInfoRecord);
                return reverseReturnXML(null);
            }
        }catch (Exception e){
            return reverseReturnXML(e.getMessage());
        }
    }

}
