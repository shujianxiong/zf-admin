package com.chinazhoufan.admin.common.token.exception;

import com.chinazhoufan.admin.common.service.ServiceException;

public class FormTokenParamException extends ServiceException{

	public FormTokenParamException() {
		super();
	}

	public FormTokenParamException(String message) {
		super(message);
	}
}
