package com.chinazhoufan.admin.common.token;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.chinazhoufan.admin.common.token.exception.FormTokenParamException;
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
public class FormTokenAop {

	//切入点
	//在所有标注@Token的地方切入如果有多个切入点可以用||拼接
	@Pointcut("@annotation(com.chinazhoufan.admin.common.token.annotation.FormToken)")
	public void token(){
		
	}
	
	//切入前
	@Before("token()")
	public void afterExec(JoinPoint joinPoint){
		System.out.println("Token创建");
		try{
			Object[] args = joinPoint.getArgs();
			HttpServletRequest request=null;
            for (int i = 0; i < args.length; i++) {
                if (args[i] instanceof HttpServletRequest) {
                	request = (HttpServletRequest) args[i];
                    break;
                }
            }
            if (request == null) {
                throw new FormTokenParamException("方法中缺失HttpServletRequest参数");
            }
            long time=System.currentTimeMillis();
            request.setAttribute("token", time);
            request.getSession().setAttribute("token", time+"");
		}catch(FormTokenParamException e){
			
		}
	}
}
