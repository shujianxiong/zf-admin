package com.chinazhoufan.admin.modules.msg.service.uw.aop.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.stereotype.Component;

/**
 * 警报注解标识
 * @author chenshi
 *
 */
@Target(ElementType.METHOD)  
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface WarningServiceMark {

	/**
	 * 是否检测克重异常
	 * 默认 false  不检测
	 * @return  
	 */
	boolean isWeight() default false;
}
