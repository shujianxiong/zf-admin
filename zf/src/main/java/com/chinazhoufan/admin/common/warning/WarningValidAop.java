package com.chinazhoufan.admin.common.warning;

import java.lang.reflect.Method;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.chinazhoufan.admin.common.warning.annotation.WarningAop;
import com.chinazhoufan.admin.common.warning.exception.WarningValidException;
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningConfigService;

@Aspect
@Component
public class WarningValidAop {
	@Autowired
	private WarningConfigService warningConfigService;
	
	//切入点
	//在所有标注@Token的地方切入如果有多个切入点可以用||拼接
	@Pointcut("@annotation(com.chinazhoufan.admin.common.warning.annotation.WarningAop)")
	public void warningAop(){
		
	}
	
	//切入前
	@Before("warningAop()")
	public void beforeExec(JoinPoint joinPoint){
		
	}   
	
	//执行后
	@After("warningAop()")
	public void afterExec(JoinPoint joinPoint){
		System.out.println("方法执行后");
		//获取标注参数
		String[] annotationParame;
		try {
			annotationParame = getAnnotationParame(joinPoint);
		} catch (Exception e) {
			e.printStackTrace();
			throw new WarningValidException("报警AOP运行异常:getAnnotationParame(joinPoint)");
		}
		WarningConfig warningConfig = warningConfigService.getByType(annotationParame[0], annotationParame[1]);
		if(warningConfig==null){
			throw new WarningValidException("友情提示：未能获取到报警配置项");
		}
		//判断配置是否开启
		if (WarningConfig.FALSE_FLAG.equals(warningConfig.getUsableFlag())) {
			return;
		}
		
		//从方法参数中获得所需参数
		Object[] args = joinPoint.getArgs();
		warningConfigService.warningValid(warningConfig,args);
	}
	
	//获得标注参数
    private String[] getAnnotationParame(JoinPoint joinPoint)throws Exception {  
        String targetName = joinPoint.getTarget().getClass().getName();  
        String methodName = joinPoint.getSignature().getName();  
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);  
        Method[] method = targetClass.getMethods();  
        String[] result = new String[2];  
        for (Method m : method) {  
            if (m.getName().equals(methodName)) {  
                Class[] tmpCs = m.getParameterTypes();  
                if (tmpCs.length == arguments.length) {  
                	WarningAop warningAop = m.getAnnotation(WarningAop.class);  
                    if (warningAop != null) {  
                    	result[0]=warningAop.category();
                    	result[1]=warningAop.type();
                    }  
                    break;  
                }  
            }  
        }  
        return result;  
    }  
}
