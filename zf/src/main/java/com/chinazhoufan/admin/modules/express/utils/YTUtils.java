package com.chinazhoufan.admin.modules.express.utils;

import com.google.common.collect.Maps;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.misc.BASE64Decoder;

import java.io.ByteArrayInputStream;
import java.security.MessageDigest;
import java.util.Map;

/**
 * 圆通工具类
 * @author liuxiaodong
 * @date 2017-11-22
 */
public class YTUtils {

    private static final Logger logger = LoggerFactory.getLogger(YTUtils.class);

    /**
     * 圆通下单返回参数解析
     * @param xml
     * @return
     */
    public static Map<String, Object> resolveResponse(String xml){
        Map<String , Object> map = Maps.newHashMap();
        map.put("result", "ERROR");
        try {
            SAXReader reader = new SAXReader();
            Document document =  reader.read(new ByteArrayInputStream(xml.getBytes("UTF-8")));
            Element element = document.getRootElement();
            Element code = element.element("code");
            logger.info("圆通下单返回code"+code);
            if("200".equals(code.getText())){
                map.put("result", "OK");
                Element shortAddress = element.element("distributeInfo").element("shortAddress");
                map.put("shortAddress", shortAddress.getText());
                map.put("mailNo", element.element("mailNo").getText());
                map.put("orderid", element.element("txLogisticID").getText());
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("圆通快递参数解析失败！");
        }
        return map;
    }

    /**
     * 圆通物流推送返回参数解析
     * @param xml
     * @return
     */
    public static Map<String, Object> resolveRouteResponse(String xml){
        Map<String , Object> map = Maps.newHashMap();
        try {
            SAXReader reader = new SAXReader();
            Document document =  reader.read(new ByteArrayInputStream(xml.getBytes("UTF-8")));
            Element element = document.getRootElement();
            map.put("acceptTime", element.element("acceptTime").getText());
            map.put("infoContent", element.element("infoContent").getText());
            map.put("remark", element.element("remark").getText());
            map.put("orderid", element.element("txLogisticID").getText());
        }catch (Exception e){
            e.printStackTrace();
            logger.error("圆通快递参数解析失败！");
        }
        return map;
    }

}
