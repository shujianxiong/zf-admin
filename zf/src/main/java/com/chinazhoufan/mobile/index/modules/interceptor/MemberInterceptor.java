/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.usercenter.dto.MemberDTO;

/**
 * 微信前端拦截器
 * @author 杨晓辉
 * @version 2015-12-29
 */
public class MemberInterceptor implements HandlerInterceptor {
	
	@Autowired
	private MemberService memberService;
	
	/** 
     * preHandle方法是进行处理器拦截用的，顾名思义，该方法将在Controller处理之前进行调用，SpringMVC中的Interceptor拦截器是链式的，可以同时存在 
     * 多个Interceptor，然后SpringMVC会根据声明的前后顺序一个接一个的执行，而且所有的Interceptor中的preHandle方法都会在 
     * Controller方法调用之前调用。SpringMVC的这种Interceptor链式结构也是可以进行中断的，这种中断方式是令preHandle的返 
     * 回值为false，当preHandle的返回值为false的时候整个请求就结束了。 
     */  
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		String requestUri = request.getRequestURI(); //请求完整路径，可用于登陆后跳转
//        String contextPath = request.getContextPath();  //项目下完整路径
//        String url = requestUri.substring(contextPath.length()); //请求页面
        
        String openidParam = request.getParameter("openid");		// 获取参数中openid
        Object obj = request.getSession().getAttribute("member");	// 获取session中用户
		
		// 是否有openid参数
		if(StringUtils.isEmpty(openidParam)){
			// 是否已登录
			if(obj == null){
				if(!isAjax(request)){
					request.setAttribute("requestUri", requestUri);
					request.getRequestDispatcher(Global.getMobileIndexPath()+"\\login").forward(request, response);
				}else {
					//response.setContentType();
					//response.setStatus(500);
					response.setCharacterEncoding("UTF-8");  
				    response.setContentType("application/json; charset=utf-8");
				    response.getWriter().print(String.format("{\"status\":%s}", Constants.NOT_LOGIN));
				}
				return false;
			}
		}else {
			request.getSession().setAttribute("openid", openidParam);
			Member member = memberService.getByOpenid(openidParam);
			if(member == null){
				request.setAttribute("requestUri", requestUri);
				request.getRequestDispatcher(Global.getMobileIndexPath()+"\\login").forward(request, response);
				return false;
			}else {
				// 通过openid参数查询到会员，则对会员进行自动登录
				MemberDTO memberDTO = new MemberDTO();
				memberDTO.setId(member.getId());
				memberDTO.setWechatOpenid(openidParam);
				memberDTO.setUsercode(member.getUsercode());
				request.getSession().setAttribute("member", memberDTO);
			}
		}
		return true;
	}

	/** 
     * 这个方法只会在当前这个Interceptor的preHandle方法返回值为true的时候才会执行。postHandle是进行处理器拦截用的，它的执行时间是在处理器进行处理之 
     * 后，也就是在Controller的方法调用之后执行，但是它会在DispatcherServlet进行视图的渲染之前执行，也就是说在这个方法中你可以对ModelAndView进行操 
     * 作。这个方法的链式结构跟正常访问的方向是相反的，也就是说先声明的Interceptor拦截器该方法反而会后调用，这跟Struts2里面的拦截器的执行过程有点像， 
     * 只是Struts2里面的intercept方法中要手动的调用ActionInvocation的invoke方法，Struts2中调用ActionInvocation的invoke方法就是调用下一个Interceptor 
     * 或者是调用action，然后要在Interceptor之前调用的内容都写在调用invoke之前，要在Interceptor之后调用的内容都写在调用invoke方法之后。 
     */  
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			ModelAndView modelAndView) throws Exception {
		
	}

	/** 
     * 该方法也是需要当前对应的Interceptor的preHandle方法的返回值为true时才会执行。该方法将在整个请求完成之后，也就是DispatcherServlet渲染了视图执行， 
     * 这个方法的主要作用是用于清理资源的，当然这个方法也只能在当前这个Interceptor的preHandle方法的返回值为true时才会执行。 
     */  
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
	}
	
	/**
	 * 判断ajax请求
	 * @param request
	 * @return
	 */
	private boolean isAjax(HttpServletRequest request){
	    return (request.getHeader("X-Requested-With") != null  && "XMLHttpRequest".equals( request.getHeader("X-Requested-With").toString())) ;
	}

}
