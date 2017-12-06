/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.interceptor;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.entity.cl.GoodsView;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsViewService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 微信前端拦截器
 * @author 杨晓辉
 * @version 2015-12-29
 */
public class MobileIndexInterceptor implements HandlerInterceptor {
	
	private static final ThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("ThreadLocal StartTime");

	protected Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private GoodsViewService goodsViewService;//会员浏览商品记录
	
	/** 
     * preHandle方法是进行处理器拦截用的，顾名思义，该方法将在Controller处理之前进行调用，SpringMVC中的Interceptor拦截器是链式的，可以同时存在 
     * 多个Interceptor，然后SpringMVC会根据声明的前后顺序一个接一个的执行，而且所有的Interceptor中的preHandle方法都会在 
     * Controller方法调用之前调用。SpringMVC的这种Interceptor链式结构也是可以进行中断的，这种中断方式是令preHandle的返 
     * 回值为false，当preHandle的返回值为false的时候整个请求就结束了。 
     */  
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		long beginTime = System.currentTimeMillis();
        startTimeThreadLocal.set(beginTime);		
        logger.error("访问开始时间:{}", new SimpleDateFormat("hh:mm:ss.SSS").format(beginTime));
		String url=request.getRequestURI();
		return true;
	}

	/** 
     * 这个方法只会在当前这个Interceptor的preHandle方法返回值为true的时候才会执行。postHandle是进行处理器拦截用的，它的执行时间是在处理器进行处理之 
     * 后，也就是在Controller的方法调用之后执行，但是它会在DispatcherServlet进行视图的渲染之前执行，也就是说在这个方法中你可以对ModelAndView进行操 
     * 作。这个方法的链式结构跟正常访问的方向是相反的，也就是说先声明的Interceptor拦截器该方法反而会后调用，这跟Struts2里面的拦截器的执行过程有点像， 
     * 只是Struts2里面的intercept方法中要手动的调用ActionInvocation的invoke方法，Struts2中调用ActionInvocation的invoke方法就是调用下一个Interceptor 
     * 或者是调用action，然后要在Interceptor之前调用的内容都写在调用invoke之前，要在Interceptor之后调用的内容都写在调用invoke方法之后。 
     */

	@Transactional(readOnly = false)
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			ModelAndView modelAndView) throws Exception {
		String ip = getIpAddress(request);
		String url =request.getRequestURL().toString();//当次请求地址
		Object obj=request.getSession().getAttribute("member");//获取用户
		MemberDTO memberDTO=null;
		if(obj!=null)
			memberDTO=(MemberDTO)obj;
//		if(memberDTO!=null){
			//保存页面查看记录，并加入用户信息
			//只需要保存URL即可
			
//		}else{
			//保存页面查看记录，只加入IP信息(暂不实现)
			//只需要保存URL即可
//		}
		
		//商品查看记录保存，当获取到用户对象才保存
		if(memberDTO != null){
			//判断URL是否包含/goodsInfo/simple路径
			String goodsUrl = "/goodsInfo/simple";
			if(url.contains(goodsUrl)){//查看商品
				//备注：用户同一款商品浏览次数+1
				String goodsId = StringUtils.substring(url, StringUtils.lastIndexOf(url, "/")+1);
				Goods goods = goodsService.get(goodsId);
				if(goods != null){
					GoodsView goodsView = goodsViewService.getGoodsView(goodsId, memberDTO.getId());
					if(goodsView != null){
						goodsViewService.save(goodsView);
					}else{
					//添加商品记录
						goodsViewService.saveWeb(memberDTO.getId(), goods.getId());
					}
				}
			}
			
		}
		//活动查看记录保存，当获取到用户对象才保存(暂不实现)
		if(memberDTO!=null){
			
		}
	}

	/** 
     * 该方法也是需要当前对应的Interceptor的preHandle方法的返回值为true时才会执行。该方法将在整个请求完成之后，也就是DispatcherServlet渲染了视图执行， 
     * 这个方法的主要作用是用于清理资源的，当然这个方法也只能在当前这个Interceptor的preHandle方法的返回值为true时才会执行。 
     */  
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
		long beginTime = startTimeThreadLocal.get();//得到线程绑定的局部变量（开始时间）  
		long endTime = System.currentTimeMillis(); 	//2、结束时间  
        logger.error("计时结束：{}  耗时：{}  ", new SimpleDateFormat("hh:mm:ss.SSS").format(endTime), DateUtils.formatDateTime(endTime - beginTime)); 
		
	}

	private String getIpAddress(HttpServletRequest request) { 
	    String ip = request.getHeader("x-forwarded-for"); 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("HTTP_CLIENT_IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getRemoteAddr(); 
	    } 
	    return ip; 
	  } 
}