package com.chinazhoufan.admin.modules.express.utils;


import java.io.ByteArrayInputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressInfoRecord;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.chinazhoufan.admin.modules.express.entity.Route;
import com.chinazhoufan.admin.modules.express.entity.RouteResponse;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 顺丰快递工具类
 * @author liuxiaodong
 * @date 2017-11-03
 */
public class SFUtils {

    private static final Logger logger = LoggerFactory.getLogger(SFUtils.class);

    /**
     * 解析下单顺丰返回的xml
     * @param xml
     * @return
     */
    public static Map<String , Object> resolveResponse(String xml){
        Map<String , Object> map = Maps.newHashMap();
        map.put("result", "ERROR");
        try {
            SAXReader reader = new SAXReader();
            Document document =  reader.read(new ByteArrayInputStream(xml.getBytes("UTF-8")));
            Element element = document.getRootElement();
            Element Head = element.element("Head");
            if("OK".equals(Head.getText())){
                map.put("result", "OK");
                Element OrderResponse = element.element("Body").element("OrderResponse");
                map.put("orderid", OrderResponse.attributeValue("orderid"));
                map.put("mailNo", OrderResponse.attributeValue("mailno"));
                map.put("destcode", OrderResponse.attributeValue("destcode"));
                map.put("origincode", OrderResponse.attributeValue("origincode"));
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("顺丰快递参数解析失败！");
        }
        return map;
    }


    /**
     * 解析查询物流信息顺丰返回的xml
     * @param xml
     * @return
     */
    public static RouteResponse resolveExpressResponse(String xml){
        RouteResponse routeResponse = null;
        try {
            SAXReader reader = new SAXReader();
            Document document =  reader.read(new ByteArrayInputStream(xml.getBytes("UTF-8")));
            Element rootElement = document.getRootElement();
            Element Head = rootElement.element("Head");
            if("OK".equals(Head.getText())){
                Element routeResponseElement = rootElement.element("Body").element("RouteResponse");
                routeResponse = new RouteResponse(routeResponseElement.attributeValue("mailno"));
                List<Route> list = Lists.newArrayList();
                Element routeElement;
                List routeList = routeResponseElement.elements("Route");
                if(routeList != null && !routeList.isEmpty()){
                    for (Object obj : routeList){
                        routeElement = (Element) obj;
                        list.add(new Route(routeElement.attributeValue("accept_time"),
                                routeElement.attributeValue("accept_address"),
                                routeElement.attributeValue("remark"),
                                rootElement.attributeValue("opcode")));
                    }
                    routeResponse.setRouteList(list);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("顺丰快递参数解析失败！");
        }
        return routeResponse;
    }

    /**
     * 解析路由推送顺丰返回的xml
     * @param xml
     * @return
     */
    public static List<ExpressInfoRecord> resolveRoute(String xml) throws Exception {
        List<ExpressInfoRecord> list = Lists.newArrayList();
        try {
            SAXReader reader = new SAXReader();
            Document document =  reader.read(new ByteArrayInputStream(xml.getBytes("UTF-8")));
            Element rootElement = document.getRootElement();
            if ("RoutePushService".equals(rootElement.attributeValue("service"))){
                Element routeElement;
                for (Object obj : rootElement.element("Body").elements("WaybillRoute")){
                    routeElement = (Element) obj;
                    list.add(new ExpressInfoRecord(routeElement.attributeValue("orderid"),
                            routeElement.attributeValue("opCode"),
                            routeElement.attributeValue("remark"),
                            DateUtils.parseDate(routeElement.attributeValue("acceptTime"), "yyyy-MM-dd HH:mm:ss")));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("顺丰快递参数解析失败！");
            throw new Exception("顺丰快递参数解析失败！");
        }
        return list;
    }


    /**
     * 解析逆向路由推送顺丰返回的xml
     * @param xml
     * @return
     */
    public static ExpressInfoRecord resolveReverseRoute(String xml) throws Exception {
        SAXReader reader = new SAXReader();
        Document document =  reader.read(new ByteArrayInputStream(xml.getBytes("UTF-8")));
        Element rootElement = document.getRootElement();
        if ("schStatusPushRequest".equals(rootElement.getName())){
            return new ExpressInfoRecord(rootElement.elementText("orderId"),
                        rootElement.elementText("alias"),
                        rootElement.elementText("remark"),
                        new Date());
        }
        throw new Exception("顺丰快递参数解析失败！");
    }
}
