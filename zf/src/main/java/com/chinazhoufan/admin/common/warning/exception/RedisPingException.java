package com.chinazhoufan.admin.common.warning.exception;

import com.chinazhoufan.admin.common.service.ServiceException;


/**
 * @author  杨晓辉
 * @date 创建时间：2016年8月13日 上午11:37:04 
 * @version 2.0.0 
 */
public class RedisPingException extends ServiceException{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public RedisPingException() {
		super();
	}

	public RedisPingException(String message) {
		super(message);
	}

}
