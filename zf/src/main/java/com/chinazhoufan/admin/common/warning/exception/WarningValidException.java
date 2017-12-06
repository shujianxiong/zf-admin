package com.chinazhoufan.admin.common.warning.exception;

import com.chinazhoufan.admin.common.service.ServiceException;

public class WarningValidException extends ServiceException{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public WarningValidException() {
		super();
	}

	public WarningValidException(String message) {
		super(message);
	}
}
