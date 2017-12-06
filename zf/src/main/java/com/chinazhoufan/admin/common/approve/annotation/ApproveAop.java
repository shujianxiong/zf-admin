package com.chinazhoufan.admin.common.approve.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.stereotype.Component;

@Target(ElementType.METHOD) //用于描述注解的使用范围 
@Retention(RetentionPolicy.RUNTIME) //用于描述注解的生命周期
@Documented //在默认的情况下javadoc命令不会将我们的annotation生成再doc中去的，所以使用该标记就是告诉jdk让它也将annotation生成到doc中去
@Component 
public @interface ApproveAop {
	
	String businessType();//审批业务类型：必须参数
	
	String businessStatus();//审批业务状态：必须参数
	
	String approveType();//审批类型 bas_ap_approve_type
}
