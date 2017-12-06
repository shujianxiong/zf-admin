package com.chinazhoufan.admin.common.token;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.chinazhoufan.admin.common.token.exception.FormTokenParamException;
import com.chinazhoufan.admin.common.token.exception.FormTokenValidateException;
import com.chinazhoufan.admin.common.utils.StringUtils;
/**
 *  表单验证token aop切面
 * 	标注@Before – 切入点执行前执行
 *  标注@After – 切入点执行后执行
 *  标注@AfterReturning – 切入点返回后执行，如果发生异常不执行
 *  标注@AfterThrowing – 异常时执行
 *  标注@Around – 在执行上面其他操作的同时也执行这个方法
 * 	@author 杨晓辉
 *
 */
@Aspect
@Component
public class TokenValidAop {

	//切入点
	//在所有标注@Token的地方切入如果有多个切入点可以用||拼接
	@Pointcut("@annotation(com.chinazhoufan.admin.common.token.annotation.TokenValid)")
	public void token(){
		
	}
	
	//切入前
	@Before("token()")
	public void beforeExec(JoinPoint joinPoint){
		System.out.println("Token检测");
		try{
			Object[] args = joinPoint.getArgs();
            HttpServletRequest request = null;
            for (int i = 0; i < args.length; i++) {
                if (args[i] instanceof HttpServletRequest) {
                    request = (HttpServletRequest) args[i];
                    break;
                }
            } 
            if (request == null) {
                throw new FormTokenParamException("方法中缺失HttpServletRequest参数");
            }
            String token=request.getParameter("token");
            String sToken=(String)request.getSession().getAttribute("token");
            if(!StringUtils.isBlank(token)&&token.equals(sToken)){
            	request.getSession().removeAttribute("token");
            }else{
            	request.setAttribute("message", "警告：您的操作过于频繁！");
            	throw new FormTokenValidateException("表单重复提交");
            }
		}catch(FormTokenParamException e){
			
		}
	}
	
	//执行后
	@After("token()")
	public void afterExec(JoinPoint joinPoint){
		System.out.println("方法执行完成");
	}
	
	@AfterReturning(value="token()",returning="retVal")
	public void doAfterReturning(JoinPoint jp,Object retVal){
        System.out.println("后置返回值通知，获得参数："+retVal);
    } 
}
