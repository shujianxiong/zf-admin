package com.chinazhoufan.admin.common.token.exception;

import com.chinazhoufan.admin.common.service.ServiceException;

public class FormTokenValidateException extends ServiceException{

	public FormTokenValidateException() {
		super();
	}

	public FormTokenValidateException(String message) {
		super(message);
	}
}
