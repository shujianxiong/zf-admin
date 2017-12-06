package com.chinazhoufan.admin.common.approve.exception;

import com.chinazhoufan.admin.common.service.ServiceException;

public class ApproveValidException extends ServiceException{
	
	public ApproveValidException() {
		super();
	}

	public ApproveValidException(String message) {
		super(message);
	}
	
	public ApproveValidException(String message,String errCode) {
		super(message,errCode);
	}
}
