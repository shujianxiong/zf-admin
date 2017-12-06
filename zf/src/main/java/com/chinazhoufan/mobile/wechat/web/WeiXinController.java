package com.chinazhoufan.mobile.wechat.web;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mpsdk4j.mvc.WechatWebSupport;
import com.chinazhoufan.mobile.wechat.service.WeiXinService;

@Controller
@RequestMapping(value = "${mobileIndexPath}/mp")
public class WeiXinController extends WechatWebSupport{
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private WeiXinService _wxser;
	
	@Autowired
	private WeiXinResponse weiXinResponse;
	
	/**
	 * 周范编号 D_A的微信消息接口初始化
	 */
	@Override 
	public void init() {
        // 可实现自己的WxHandler
        WechatWebSupport._wk.setMpAct(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_A));
        WechatWebSupport._wk.setWechatHandler(weiXinResponse);
    }
 
	/**
	 * 周范编号 D_A的微信消息接口
	 * 用户请求微信，微信转发请求到后台，后台处理用户请求
	 */
    @RequestMapping(value = "/call",produces = {"text/plain;charset=UTF-8"})
    @ResponseBody 
    public String wxCore(HttpServletRequest req) {
        String reply = "";
        try {
            reply = interact(req);
            System.out.println("--------------微信回复内容 BEGIN--------------");
            System.out.println(reply);
            System.out.println("--------------微信回复内容 END--------------");
        } catch (IOException e) {
        	
        	logger.error(e.getLocalizedMessage(), e);
        }
        return reply;
    }
    
    
}
