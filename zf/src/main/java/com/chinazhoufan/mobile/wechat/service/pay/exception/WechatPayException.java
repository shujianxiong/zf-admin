package com.chinazhoufan.mobile.wechat.service.pay.exception;

import com.chinazhoufan.admin.common.service.ServiceException;


/**
 * @author 张金俊
 * @version 创建时间：2017年5月15日 下午4:10:44
 * 类说明
 */
public class WechatPayException extends ServiceException{
	private static final long serialVersionUID = 1L;
	
	private int status;
	
	public WechatPayException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WechatPayException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}
	
	public WechatPayException(String message,int status) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public WechatPayException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
