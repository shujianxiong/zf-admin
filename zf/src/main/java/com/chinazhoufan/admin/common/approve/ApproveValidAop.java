package com.chinazhoufan.admin.common.approve;

import java.lang.reflect.Method;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.chinazhoufan.admin.common.approve.annotation.ApproveAop;
import com.chinazhoufan.admin.common.approve.exception.ApproveValidException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveConfig;
import com.chinazhoufan.admin.modules.bas.service.ap.ApproveConfigService;

@Aspect
@Component
public class ApproveValidAop {
	@Autowired
	private ApproveConfigService approveConfigService;
	
	private static final String APPROVE_TYPE_CREATE="create";//审批创建
	private static final String APPROVE_TYPE_TEST="test";//审批检测
	
	//切入点
	//在所有标注@Token的地方切入如果有多个切入点可以用||拼接
	@Pointcut("@annotation(com.chinazhoufan.admin.common.approve.annotation.ApproveAop)")
	public void approveAop(){
		
	}
	
	//切入前
	@Before("approveAop()")
	public void beforeExec(JoinPoint joinPoint){
		System.out.println("审批检测");
		//获取标注参数
		String[] annotationParame;
		try {
			annotationParame = getAnnotationParame(joinPoint);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ApproveValidException("审批AOP运行异常:getAnnotationParame(joinPoint)");
		}
		ApproveConfig approveConfig = approveConfigService.get(annotationParame[0], annotationParame[1]);
		String approveType=annotationParame[2];
		if(approveConfig==null||StringUtils.isBlank(approveType))
			throw new ApproveValidException("友情提示：未能获取到审批配置项");
		//审批配置是否开启
		if(!approveConfigService.isOpen(approveConfig)){
			return;
		}
		//从方法参数中获得任务项
		BasMission basMission=null; 
		Object[] args = joinPoint.getArgs();
        for (int i = 0; i < args.length; i++) {
            if (args[i] instanceof BasMission) {
            	basMission = (BasMission) args[i];
                break;
            }
        }
        if (basMission == null) {
            throw new ApproveValidException("方法中缺失BasMission类型参数");
        }
        //审批状态检测
        switch (approveType) {
			case APPROVE_TYPE_CREATE:
				approveConfigService.saveBasMissionApprove(approveConfig, basMission);
				break;
			case APPROVE_TYPE_TEST:
				//审批状态检测
		        if(!approveConfigService.isApproval(approveConfig,basMission)){
		        	throw new ApproveValidException("您的任务还未审核通过!");
		        }
				break;
			default:
				break;
		}
	}   
	
	//执行后
	@After("approveAop()")
	public void afterExec(JoinPoint joinPoint){
		System.out.println("方法执行完成");
		//获取标注参数
		String[] annotationParame;
		try {
			annotationParame = getAnnotationParame(joinPoint);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ApproveValidException("审批AOP运行异常:getAnnotationParame(joinPoint)");
		}
		ApproveConfig approveConfig = approveConfigService.get(annotationParame[0], annotationParame[1]);
		String approveType=annotationParame[2];
		if(approveConfig==null||StringUtils.isBlank(approveType))
			throw new ApproveValidException("友情提示：未能获取到审批配置项");
		//审批配置是否开启
		if(!approveConfigService.isOpen(approveConfig)){
			return;
		}
		//从方法参数中获得任务项
		BasMission basMission=null; 
		Object[] args = joinPoint.getArgs();
        for (int i = 0; i < args.length; i++) {
            if (args[i] instanceof BasMission) {
            	basMission = (BasMission) args[i];
                break;
            }
        }
        if (basMission == null) {
            throw new ApproveValidException("方法中缺失BasMission类型参数");
        }
        //审批状态检测
        switch (approveType) {
			case APPROVE_TYPE_CREATE:
//				approveConfigService.saveBasMissionApprove(approveConfig, basMission);
				approveConfigService.saveUmMessageApprove(approveConfig, basMission);
				break;
			default:
				break;
		}
	}
	
	//获得标注参数
    private String[] getAnnotationParame(JoinPoint joinPoint)throws Exception {  
        String targetName = joinPoint.getTarget().getClass().getName();  
        String methodName = joinPoint.getSignature().getName();  
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);  
        Method[] method = targetClass.getMethods();  
        String[] result = new String[3];  
        for (Method m : method) {  
            if (m.getName().equals(methodName)) {  
                Class[] tmpCs = m.getParameterTypes();  
                if (tmpCs.length == arguments.length) {  
                	ApproveAop approveAop = m.getAnnotation(ApproveAop.class);  
                    if (approveAop != null) {  
                    	result[0]=approveAop.businessType();
                    	result[1]=approveAop.businessStatus();
                    	result[2]=approveAop.approveType();
                    }  
                    break;  
                }  
            }  
        }  
        return result;  
    }  
}
