/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.warning.exception.RedisPingException;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.sys.dto.UserDTO;

/**
 * 移动管理端登录拦截器
 * @author 张金俊
 * @version 2016-10-14
 */
public class UserInterceptor implements HandlerInterceptor {
	
	@Autowired
	private RedisCacheService<String,UserDTO> userDTORedisCacheService;
	@Autowired
	private RedisCacheService<String,String> stringRedisCacheService;
	
	/** 
     * preHandle方法是进行处理器拦截用的，顾名思义，该方法将在Controller处理之前进行调用，SpringMVC中的Interceptor拦截器是链式的，可以同时存在 
     * 多个Interceptor，然后SpringMVC会根据声明的前后顺序一个接一个的执行，而且所有的Interceptor中的preHandle方法都会在 
     * Controller方法调用之前调用。SpringMVC的这种Interceptor链式结构也是可以进行中断的，这种中断方式是令preHandle的返 
     * 回值为false，当preHandle的返回值为false的时候整个请求就结束了。 
     */  
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		// 获取请求参数中的sessionID
        String sessionID = request.getParameter("sid");
        UserDTO userDTO = null;
        try {
        	// 根据sessionID查询会话缓存
        	if(userDTORedisCacheService.exists(String.format(RedisCacheService.MOBILE_SESSION, sessionID))){
        		userDTO = userDTORedisCacheService.get(String.format(RedisCacheService.MOBILE_SESSION, sessionID));
        	}
        	
        	// 是否有sessionID参数、是否登录且有有效会话（有未失效的sessionID缓存）
        	if(StringUtils.isEmpty(sessionID) || userDTO == null){
        		response.setCharacterEncoding("UTF-8");
        		response.setContentType("application/json; charset=utf-8");
        		response.getWriter().print(String.format("{\"status\":%s}", Constants.NOT_LOGIN));
        		return false;
        	}
        	
        	// 当前用户为已登录状态，则更新该用户redis缓存（loginName：sessionID）、（sessionID：userDTO）的失效时间
        	stringRedisCacheService.updateLiveTime(String.format(RedisCacheService.MOBILE_LOGINNAME, userDTO.getLoginName()), new Long(Global.getConfig("redisSession.mobileSessionTimeout")));
        	userDTORedisCacheService.updateLiveTime(String.format(RedisCacheService.MOBILE_SESSION, sessionID), new Long(Global.getConfig("redisSession.mobileSessionTimeout")));
		} catch (RedisPingException rpe) {
			response.setCharacterEncoding("UTF-8");
		    response.setContentType("application/json; charset=utf-8");
		    response.getWriter().print(String.format("{\"status\":%s}", Constants.CACHE_CON_NULL));
			return false;
		} catch (DataAccessException dae) {
			response.setCharacterEncoding("UTF-8");
		    response.setContentType("application/json; charset=utf-8");
		    response.getWriter().print(String.format("{\"status\":%s}", Constants.CACHE_DATAACCESS_FAIL));
			return false;
		}
		
		// session中保存userDTO以供api方法中取用当前用户
		request.getSession().setAttribute("userDTO", userDTO);
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
		// session中移除当前用户的userDTO
		request.getSession().removeAttribute("userDTO");
	}

	/** 
     * 该方法也是需要当前对应的Interceptor的preHandle方法的返回值为true时才会执行。该方法将在整个请求完成之后，也就是DispatcherServlet渲染了视图执行， 
     * 这个方法的主要作用是用于清理资源的，当然这个方法也只能在当前这个Interceptor的preHandle方法的返回值为true时才会执行。 
     */  
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
	}
	
}
