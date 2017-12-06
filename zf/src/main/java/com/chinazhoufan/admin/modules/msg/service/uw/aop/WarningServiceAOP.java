package com.chinazhoufan.admin.modules.msg.service.uw.aop;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.chinazhoufan.admin.modules.msg.service.uw.WarningConfigService;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningService;
import com.chinazhoufan.admin.modules.msg.service.uw.aop.annotation.WarningServiceMark;

@Aspect
@Component
public class WarningServiceAOP {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private WarningService warningService;
	@Autowired
	private WarningConfigService warningConfigService;
	
	@Pointcut(value = "@annotation(com.chinazhoufan.admin.modules.msg.service.uw.aop.annotation.WarningServiceMark)")
	public void point(){}
	
	/**
	 * @AfterReturning  只有执行成功才会执行；@after 不管成功失败都会执行
	 * 仓库警报监控
	 * @param point
	 * @param warningVO  方法返回参数 -- 统一返回
	 * @throws Exception
	 */
//	@AfterReturning(value = "point()")
//	public void afterSave(JoinPoint point) throws Exception{
//		WarningVO warningVO =  getVO(point);
//		if(warningVO != null){
//			warningService.checkStockWarning(warningVO);
//			if(isWeight(point)){
//				warningService.checkWeightWarning(warningVO);
//			}
//		}
//	}
	
	/**
	 * 判断是否需要检测称重
	 * @param point
	 * @return
	 */
	private boolean isWeight(JoinPoint point){
		 Method meths[] = point.getSignature().getDeclaringType().getMethods();
		 for(Method me : meths){
			 Annotation[] anns = me.getDeclaredAnnotations();
			 for(Annotation ann : anns){
			      if(ann instanceof WarningServiceMark){
			    	  return ((WarningServiceMark) ann).isWeight();
			      }
		      }
		 }
		return false;
	}
	
	/**
	 * 取得参数传递对象
	 * @param point
	 * @return
	 */
	private WarningVO getVO(JoinPoint point){
		Object[] objects = point.getArgs();
		for(Object obj : objects){
			if(obj instanceof WarningVO){
				return (WarningVO) obj;
			}
		}
		return null;
	}
}
