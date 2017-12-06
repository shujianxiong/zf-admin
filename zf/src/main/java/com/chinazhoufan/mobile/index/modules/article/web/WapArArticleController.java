/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.article.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.spm.entity.ar.ArArticle;
import com.chinazhoufan.admin.modules.spm.entity.ar.ArticleRecord;
import com.chinazhoufan.admin.modules.spm.service.ar.ArArticleService;
import com.chinazhoufan.admin.modules.spm.service.ar.ArticleRecordService;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 阅读文章记录controller
 * @version  2016-06-07
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/ar/arArticle/")
public class WapArArticleController extends BaseController {

	@Autowired
	private ArticleRecordService articleRecordService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ArArticleService arArticleService;
	
	@RequestMapping(value = "info")
	public String info(String openid, String articleId, HttpServletRequest request, HttpServletResponse response, Model model) {
        //-----业务处理
        ArArticle article = arArticleService.get(articleId);
    	if(ArArticle.FALSE_FLAG.equals(article.getActiveFlag())) {
    		addMessage(model, "该文章链接已失效！");
    	} else {
    		ArticleRecord articleRecord = new ArticleRecord();
    		
    		//ip地址需要从请求的消息头里面获取
    		String ip = getIpAddr(request);
    		articleRecord.setIp(ip);
    		String wechatOpenid;
    		//---从微信进入openId赋值
    		if(StringUtils.isBlank(openid)) {
    			wechatOpenid = request.getSession().getAttribute("openid")+"";				// 获取session中的wechatOpenid
    		}else {
    			wechatOpenid = openid;
    		}
    		articleRecord.setWechatOpenid(wechatOpenid);
    		
    		//---------会员ID赋值
    		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");	// 获取session中会员数据
    		Member member;
            if(memberDTO == null) {
            	member = memberService.getByOpenid(openid);
            	articleRecord.setMember(member);
            }else {
            	articleRecord.setMember(new Member(memberDTO.getId()));
            }
            
            //----文章ID赋值
            ArArticle arArticle = new ArArticle();
            arArticle.setId(articleId);
            articleRecord.setArticle(arArticle);
            
	        articleRecord = articleRecordService.saveReadCount(articleRecord);
	        if(articleRecord == null) {
	        	addMessage(model, "此内容，您已阅！");
	        } else {
        		addMessage(model, "恭喜，您有查看该文章的权限！");
        		model.addAttribute("arArticle", article);
        		model.addAttribute("arId", articleId);
	        }
		}
		return "mobile/wechat/article/arArticle/arArticleInfo";
	};
	
	/**
	 * 在JSP里，获取客户端的IP地址的方法是：request.getRemoteAddr()，这种方法在大部分情况下都是有效的。
	 * 但是在通过了 Apache，Nagix等反向代理软件就不能获取到客户端的真实IP地址了。如果使用了反向代理软件，
	 * 用 request.getRemoteAddr()方法获取的IP地址是：127.0.0.1或 192.168.1.110，而并不是客户端的真实IP。
	 * 经过代理以后，由于在客户端和服务之间增加了中间层，因此服务器无法直接拿到客户端的 IP，服务器端应用也
	 * 无法直接通过转发请求的地址返回给客户端。但是在转发请求的HTTP头信息中，增加了X-FORWARDED-FOR信息。
	 * 用以跟踪原有的客户端 IP地址和原来客户端请求的服务器地址
	 * @param request
	 * @return
	 */
	private String getIpAddr(HttpServletRequest request) {
		 String ip = request.getHeader("x-forwarded-for");
		 if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			 ip = request.getHeader("Proxy-Client-IP");
		 }
		 if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			 ip = request.getHeader("WL-Proxy-Client-IP");
		 }
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
             ip = request.getHeader("HTTP_CLIENT_IP");  
         }  
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
             ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
         }
		 if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			 ip = request.getRemoteAddr();
		 }
		 return ip;
	}
	
	
}