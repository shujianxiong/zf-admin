package com.chinazhoufan.admin.common.warning.exception;

import com.chinazhoufan.admin.common.service.ServiceException;

/**
 * @author  杨晓辉
 * @date 创建时间：2016年10月14日 下午5:12:49 
 * @version 2.0.0 
 */
public class RedisSelectException extends ServiceException{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public RedisSelectException() {
		super();
	}

	public RedisSelectException(String message) {
		super(message);
	}

}
