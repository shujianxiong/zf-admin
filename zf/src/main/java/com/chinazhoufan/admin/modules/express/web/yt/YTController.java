package com.chinazhoufan.admin.modules.express.web.yt;


import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.express.config.YTConfig;
import com.chinazhoufan.admin.modules.express.utils.YTUtils;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressInfoRecord;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressInfoRecordService;
import com.chinazhoufan.api.common.express.ExpressUtil;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;


@Controller
@RequestMapping("yt")
public class YTController extends BaseController {

    @Autowired
    SendOrderService sendOrderService;
    @Autowired
    ExperienceOrderService experienceOrderService;
    @Autowired
    ExpressInfoRecordService expressInfoRecordService;

    @RequestMapping("/routePushCall")
    @ResponseBody
    public String routePushCall(@RequestParam("logistics_interface") String logistics_interface, @RequestParam("data_digest")String data_digest,
                                @RequestParam("clientId")String clientId, @RequestParam("type")String type){
        logger.info("----圆通物流状态推送----");
        String orderid = "";
        try {
            logistics_interface = URLDecoder.decode(logistics_interface, "UTF-8");
            logistics_interface = StringEscapeUtils.unescapeXml(logistics_interface);
            data_digest = URLDecoder.decode(data_digest, "UTF-8");
            data_digest = StringEscapeUtils.unescapeXml(data_digest);
            logger.info(logistics_interface);
            logger.info(data_digest);
            if (data_digest.equals(ExpressUtil.generateData(logistics_interface, YTConfig.PARTNER_ID))&&YTConfig.CLIENT_ID.equals(clientId)){
                Map<String, Object> map = YTUtils.resolveRouteResponse(logistics_interface);
                orderid = map.get("orderid").toString();
                String infoContent = map.get("infoContent").toString();
                SendOrder sendOrder = sendOrderService.getBySendOrderNo(orderid);
                ExperienceOrder experienceOrder	 = experienceOrderService.get(sendOrder.getOrderId());
                /*签收时更新订单状态为已签收*/
                if ("SIGNED".equals(infoContent)){
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
                }else if("FAILED".equals(infoContent)){
                    experienceOrderService.updateOrderStatusByExpress(null,sendOrder.getOrderNo(), ExperienceOrder.EXPRESS_FAILED);
                }
                //保存物流状态记录
                ExpressInfoRecord expressInfoRecord = new ExpressInfoRecord(orderid, infoContent, map.get("remark").toString(), DateUtils.parseDate(map.get("acceptTime")));
                expressInfoRecord.setMember(experienceOrder.getMember());
                expressInfoRecord.setOrderType(sendOrder.getOrderType());
                expressInfoRecord.setOrderId(experienceOrder.getId());
                expressInfoRecord.setStatus(expressInfoRecord.getStatus());
                expressInfoRecord.setSendOrderType(sendOrder.getType());
                expressInfoRecord.setStatusDescription(expressInfoRecord.getStatusDescription());
                expressInfoRecord.setTime(new Date());
                expressInfoRecordService.save(expressInfoRecord);
                return returnXML(orderid, null);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnXML(orderid, "操作失败!");

    }

    private String returnXML(String mailNo, String reason) {
        if (StringUtils.isNotBlank(reason)) {
            return "<Response>\n" +
                    "<logisticProviderID>YTO</logisticProviderID>\n" +
                    "<txLogisticID>"+mailNo+"</txLogisticID>\n" +
                    "<success>false</success>\n" +
                    "<reason>"+reason+"</reason> \n" +
                    "</Response>";
        }else {
            return "<Response>\n" +
                    "<logisticProviderID>YTO</logisticProviderID> \n" +
                    "<txLogisticID>"+mailNo+"</txLogisticID>\n" +
                    "<success>true</success>\n" +
                    "</Response>";
        }
    }
}
