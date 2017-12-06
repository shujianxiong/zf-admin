/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 扫描电子码Entity
 * @author 张金俊
 * @version 2016-11-16
 */
public class ScanCode extends DataEntity<ScanCode> {
	
	private static final long serialVersionUID = 1L;
	private int code;			// 电子码
	private String type;		// 业务类型
	
	/********************************* 自定义常量  *********************************/
	public static final int INIT_CODE			= 10001;// 初始电子码
	
	// 电子码业务类型 [bas_scan_code_type]
	public static final String TYPE_PRODUCT		= "1";	// 货品电子码
	public static final String TYPE_WAREPLACE	= "2";	// 货位电子码
	
	
	public ScanCode() {
		super();
	}

	public ScanCode(String id){
		super(id);
	}
	
	public ScanCode(int code, String type) {
		super();
		this.code = code;
		this.type = type;
	}

	
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}
	
	@Length(min=1, max=2, message="业务类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}