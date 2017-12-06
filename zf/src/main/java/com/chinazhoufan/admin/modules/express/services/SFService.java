package com.chinazhoufan.admin.modules.express.services;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.chinazhoufan.admin.common.mpsdk4j.util.HttpTool;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduce;
import com.chinazhoufan.admin.modules.express.config.SFConfig;
import com.chinazhoufan.admin.modules.express.entity.RouteResponse;
import com.chinazhoufan.admin.modules.express.utils.SFUtils;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.api.common.express.ExpressUtil;
import com.google.common.collect.Maps;

/**
 * 顺丰快递Service
 * @author liuxiaodong
 * @date 2017-11-04
 */
@Service
public class SFService {

    private final Logger logger = LoggerFactory.getLogger(SFService.class);


    /**
     * 顺丰下单
     * @param sendOrder 发货单
     * @return
     */
    public Map<String, Object> orderService( SendOrder sendOrder){
        logger.info("----------顺丰快递下单开始----------");
        String xml="<Request service='OrderService' lang='zh-CN'>\n" +
                "<Head>%apiCode</Head>\n" +
                "<Body>\n" +
                "<Order orderid ='%orderId'\n" +
                "custid= '%custid'\n"+
                /*"j_province=%sendProv j_city=%sendCity j_county=%sendCounty\n" +*/
                "j_company='周范科技' j_address='%expressReceiverAddress' \n" +
                "j_contact='%expressReceiverName' j_tel='%expressReceiverPhone' j_mobile='%expressReceiverPhone'\n" +
                // "d_province='%expressReceiverProv' d_city='%expressReceiverCity' d_county='%expressReceiverDistrict'\n" +
                "d_company='' \n" +
                "d_address='%sendAddress'\n" +
                "d_tel='%sendTel' d_mobile='%sendTel'\n" +
                "express_type ='1'\n" +
                "pay_method ='1'\n" +
                "sendstarttime ='%sendStartTime'\n" +
                "remark = '%remarks'>\n" +
                "%Cargos\n" +
                "</Order>\n" +
                "</Body></Request>";
        String Cargos = "";
        for(SendProduce sendProduce:sendOrder.getSendProduceList()){
            String itemXml="<Cargo name='%itemName' \n" +
                            "count='%itemNumber' unit='件' \n" +
                            "currency='CNY' source_area='中国'></Cargo>\n";
            itemXml=itemXml.replace("%itemName", sendProduce.getProduce().getName());
            itemXml=itemXml.replace("%itemNumber", sendProduce.getNum().toString());
            Cargos+=itemXml;
        }
        xml=xml.replace("%apiCode", SFConfig.API_CODE);
        xml=xml.replace("%orderId", sendOrder.getSendOrderNo());
        xml=xml.replace("%sendTel", sendOrder.getReceiveTel());
        xml=xml.replace("%sendAddress", sendOrder.getReceiveAreaStr()+sendOrder.getReceiveAreaDetail());
        xml=xml.replace("%expressReceiverName", ConfigUtils.getConfig("expressReceiverName").getConfigValue());
        xml=xml.replace("%expressReceiverPhone", ConfigUtils.getConfig("expressReceiverPhone").getConfigValue());
//        xml=xml.replace("%sendProv", ConfigUtils.getConfig("expressReceiverProv").getConfigValue());
//        xml=xml.replace("%sendCity", ConfigUtils.getConfig("expressReceiverCity").getConfigValue());
//        xml=xml.replace("%sendCounty", ConfigUtils.getConfig("expressReceiverDistrict").getConfigValue());
        xml=xml.replace("%expressReceiverAddress", ConfigUtils.getConfig("expressReceiverAddress").getConfigValue());
        
        Calendar cal=Calendar.getInstance();   
        cal.set(Calendar.HOUR_OF_DAY, cal.get(Calendar.HOUR_OF_DAY) + 1);

        xml=xml.replace("%sendStartTime", DateUtils.getTimeByHour(1));
        xml=xml.replace("%Cargos", Cargos);
        xml=xml.replace("%custid", SFConfig.CUSTID);
        xml=xml.replace("%remarks", sendOrder.getRemarks()==null?"无":sendOrder.getRemarks());

        Map<String , Object> map = Maps.newHashMap();
        try {
            map = SFUtils.resolveResponse(HttpTool.post(SFConfig.API_URL, "xml="+xml+"&verifyCode="+ ExpressUtil.generateData(xml, SFConfig.API_CHECKWORD)));
            logger.info("----------顺丰快递下单成功----------");
        } catch (Exception e){
            e.printStackTrace();
            map.put("result", "ERROR");
        }
        return map;
    }

    /**
     * 查询顺丰物流信息
     * @param expressNo
     * @return
     */
    public RouteResponse sfexpressService(String expressNo) {
        String xml = "<Request service='RouteService' lang='zh-CN'>\n" +
                "<Head>%apiCode</Head>\n" +
                "<Body>\n" +
                "<RouteRequest\n" +
                "tracking_number='%expressNo'/>\n" +
                "</Body>\n" +
                "</Request>";
        xml=xml.replace("%apiCode", SFConfig.API_CODE);
        xml=xml.replace("%expressNo", expressNo);
        RouteResponse routeResponse = null;
        try {
            routeResponse = SFUtils.resolveExpressResponse(HttpTool.post(SFConfig.API_URL, "xml="+xml+"&verifyCode="+ExpressUtil.generateData(xml, SFConfig.API_CHECKWORD)));
        } catch (Exception e){

        }
        return routeResponse;

    }
    


}
