package com.chinazhoufan.admin.common.emay;

import java.io.IOException;
import java.io.StringReader;
import java.util.Map;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import com.chinazhoufan.admin.common.utils.AES;
import com.chinazhoufan.admin.common.utils.JsonUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.google.common.collect.Maps;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * 发送短信util
 * @author liuxiaodong
 * @version 2016-11-25
 */
public class SendMsgUtil {

	private static final String SN = "8SDK-EMY-6699-SBUSM";// 软件序列号,请通过亿美销售人员获取
	private static final String PASSWORD = "668280";// 密码,请通过亿美销售人员获取
	private static final String BASEURL = "http://hprpt2.eucp.b2m.cn:8080/sdkproxy/";
	private static final String SIGN = "【杭州周范科技有限公司】";
	
	
	private static final String SALES_SN = "EUCP-EMY-SMS1-3AVAC";// 软件序列号,请通过亿美销售人员获取
	private static final String SALES_PASSWORD = "DCF56A3D34BFB8A2";// 密码,请通过亿美销售人员获取
	private static final String SALES_BASEURL = "http://shmtn.b2m.cn";
	private static final String TD = " 回复TD退订";
	
	
	private static final Map<String, Object> map = Maps.newHashMap();
	
	private volatile static OkHttpClient client=null;
	
	public static OkHttpClient getInstance() { 
	    if (client == null) { 
	      synchronized (OkHttpClient.class) { 
	        if(client == null) { 
	        	client = new OkHttpClient(); 
	        } 
	      } 
	    } 
	    return client; 
	  } 
	
	
	/**
	 * 发送营销类短信
	 * @param phone 手机号码
	 * @param message 消息内容
	 * @param timerTime 定时时间 格式为yyyy-MM-dd HH:mm:ss
	 * @return "0"成功 "-1"失败
	 */
	public synchronized static String sendSales(String phone, String message, String timerTime)  {
		String result = "-1";
		try {

			String url = SALES_BASEURL + "/inter/sendSingleSMS";
			message+=TD;
			//封装参数
			String param = encapsuleParam(phone, message, timerTime);
			//AES加密
			byte[] parambytes = AES.encrypt(param.getBytes("UTF-8"), SALES_PASSWORD.getBytes());
			
			RequestBody requestBody = RequestBody.create(null, parambytes);
			
		    Request request = new Request.Builder()
		      .addHeader("appId", SALES_SN)
		      .url(url)
		      .post(requestBody)
		      .build();
		    
		    Response response = SendMsgUtil.getInstance().newCall(request).execute();
		    if (response.isSuccessful()) {
		    	String temp=response.header("result").trim();
		    	if ("SUCCESS".equals(temp)) {
		    		result = "0";
				}
		    } else {
		        throw new IOException("Unexpected code " + response);
		    }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	
	}
	
	
	/**
	 * 封装请求参数
	 * @param phone 手机号码
	 * @param message 消息内容
	 * @param timerTime 定时时间 格式为yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	private static String encapsuleParam(String phone, String message, String timerTime ) {
		map.put("mobile", phone);
		map.put("content", message);
		if (StringUtils.isNotBlank(timerTime)) {
			map.put("timerTime", timerTime);
		}
		map.put("requestTime", System.currentTimeMillis());
		map.put("requestValidPeriod", 60);
		return JsonUtils.toJson(map, Map.class);
	}
	/**
	 * 发送即时短信
	 * @param phone 手机号
	 * @param message 内容
	 * @return
	 * @throws IOException
	 */
	public synchronized static String send(String phone, String message) throws IOException {
		String url = BASEURL + "sendsms.action";
		
//		message = URLEncoder.encode(message, "UTF-8"); //转成utf-8
		RequestBody requestBody = new FormBody.Builder().add("cdkey", SN).add("password", PASSWORD).add("phone", phone).add("message", SIGN+message).build();
		
	    Request request = new Request.Builder()
	      .url(url)
	      .post(requestBody)
	      .build();
	    
	    Response response = SendMsgUtil.getInstance().newCall(request).execute();
	    if (response.isSuccessful()) {
	    	String result = "-1";
	    	String temp=response.body().string().trim();
	    	if (null != temp && !"".equals(temp)) {
	    		result = SendMsgUtil.parse(temp);
			}
	        return result;
	    } else {
	        throw new IOException("Unexpected code " + response);
	    }
	}
	
	
	
	public static void main(String[] args) {
		SendMsgUtil.sendSales("18268194892", "发一条营销的短信", "");
	}
	
    /**
    * 生成随机六位验证码
    * @return
    */
    public static String createRandomVcode(){
        //验证码
        String vcode = "";
        vcode = vcode + (int)(Math.random() * 999999);
        return vcode;
    }
 
    /**
     * 解析返回的xml
     * @param protocolXML
     * @return
     */
    public static String parse(String protocolXML) {   
    	String result = null;
        try {   
             DocumentBuilderFactory factory = DocumentBuilderFactory   
                     .newInstance();   
             DocumentBuilder builder = factory.newDocumentBuilder();   
             Document doc = builder   
                     .parse(new InputSource(new StringReader(protocolXML)));   
             Element root = doc.getDocumentElement();   
             NodeList books = root.getElementsByTagName("error");
             if (books != null) {   
            	 result = books.item(0).getNodeValue();
            	 result = books.item(0).getFirstChild().getNodeValue();
             }   
         } catch (Exception e) {   
             e.printStackTrace();   
         }   
        if (null == result||"".equals(result)) {
			result = "-1";
		}
        return result;
    }
    
}
