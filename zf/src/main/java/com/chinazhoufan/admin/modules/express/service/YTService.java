package com.chinazhoufan.admin.modules.express.service;


import com.chinazhoufan.admin.common.utils.HttpTool;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduce;
import com.chinazhoufan.admin.modules.express.config.SFConfig;
import com.chinazhoufan.admin.modules.express.config.YTConfig;
import com.chinazhoufan.admin.modules.express.utils.YTUtils;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.api.common.express.ExpressUtil;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import java.net.URLEncoder;
import java.util.Map;

/**
 * 圆通Service
 * @author liuxiaodong
 * @date 2017-11-13
 */
@Service
public class YTService {

    private static final Logger logger = LoggerFactory.getLogger(YTService.class);


    /**
     * 圆通下单
     * @param sendOrder 发货单
     * @return
     */
    public Map<String, Object> orderService(SendOrder sendOrder, String receiveProv, String receiveCity){
        logger.info("----------圆通快递下单开始----------");

        String xml = "<RequestOrder>\n" +
                "<clientID>%clientId</clientID>\n" +
                "<logisticProviderID>YTO</logisticProviderID>\n" +
                "<customerId>%clientId</customerId>\n" +
                "<txLogisticID>%orderId</txLogisticID>\n" +
                "<totalServiceFee>1</totalServiceFee>\n" +
                "<codSplitFee>1</codSplitFee>\n" +
                "<orderType>1</orderType>\n" +
                "<serviceType>1</serviceType>\n" +
                "<sender>\n" +
                "   <name>周范科技</name>\n" +
                "   <phone>%sendPhone</phone>\n" +
                "   <prov>%sendProv</prov>\n" +
                "   <city>%sendCity,%sendDistrict</city>\n" +
                "   <address>%sendAddress</address>\n" +
                "</sender>\n" +
                "<receiver>\n" +
                "   <name>%receiveName</name>\n" +
                "   <mobile>%receiveTel</mobile>\n" +
                "   <prov>%receiveProv</prov>\n" +
                "   <city>%receiveCity</city>\n" +
                "   <address>%receiveAddress</address>\n" +
                "</receiver>\n" +
                "<items>%items\n"+
                "</items>\n" +
                "<remark>%remark</remark>\n" +
                "</RequestOrder>";
        String items = null;
        for(SendProduce sendProduce:sendOrder.getSendProduceList()){
            String itemXml="<item>" +
                    "<itemName>%itemName</itemName>\n" +
                    "<number>%itemNumber</number>\n" +
                    "</item>\n";
            itemXml=itemXml.replace("%itemName", sendProduce.getProduce().getName());
            itemXml=itemXml.replace("%itemNumber", sendProduce.getNum().toString());
            items+=itemXml;
        }
        xml=xml.replace("%clientId", YTConfig.CLIENT_ID);
        xml=xml.replace("%orderId", sendOrder.getSendOrderNo());
        xml=xml.replace("%sendPhone", ConfigUtils.getConfig("expressReceiverPhone").getConfigValue());
        xml=xml.replace("%sendProv", ConfigUtils.getConfig("expressReceiverProv").getConfigValue());
        xml=xml.replace("%sendCity", ConfigUtils.getConfig("expressReceiverCity").getConfigValue());
        xml=xml.replace("%sendDistrict", ConfigUtils.getConfig("expressReceiverDistrict").getConfigValue());
        xml=xml.replace("%sendAddress", ConfigUtils.getConfig("expressReceiverAddress").getConfigValue());
        xml=xml.replace("%receiveName", ConfigUtils.getConfig("expressReceiverName").getConfigValue());
        xml=xml.replace("%receiveTel", sendOrder.getReceiveTel());
        xml=xml.replace("%receiveProv", receiveProv);
        xml=xml.replace("%receiveCity", receiveCity);
        xml=xml.replace("%receiveAddress", sendOrder.getReceiveAreaDetail());
        xml=xml.replace("%items", items);
        xml=xml.replace("%remark", sendOrder.getRemarks()==null?"无":sendOrder.getRemarks());

        Map<String , Object> map = Maps.newHashMap();
        try {
            map = YTUtils.resolveResponse(HttpTool.post(YTConfig.ORDER_URL, "logistics_interface="+URLEncoder.encode(xml,"UTF-8")+"&data_digest="
                                            +URLEncoder.encode(ExpressUtil.generateData(xml, YTConfig.PARTNER_ID), "UTF-8")
                                            +"&clientId="+YTConfig.CLIENT_ID+"&type="+YTConfig.TYPE));
            logger.info("----------圆通快递下单成功----------");
        } catch (Exception e){
            e.printStackTrace();
            map.put("result", "ERROR");
        }
        return map;
    }

}
