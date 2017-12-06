/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.tn;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.ser.entity.as.WorkorderDeal;

/**
 * 快递单号单段Entity
 * @author liut
 * @version 2017-05-22
 */
public class ExpressNoSegment extends DataEntity<ExpressNoSegment> {
	
	private static final long serialVersionUID = 1L;
	private String expressNo;		// 快递单号
	private String expressCompany;		// 快递公司类型  express_company
	private String status;		// 使用状态（1=使用，0=未使用）
	private Date useTime;		// 使用时间
	
	
	/***************************************** 自定义查询条件属性  ******************************************/
	private MultipartFile file;  //用于接受表单界面传递过来的文件路径

	/******************************************** 自定义常量  *********************************************/
	public static final String EXPRESS_COMPANY_ZJS = "7";//快递公司，默认为7，宅急送
	
	
	public ExpressNoSegment() {
		super();
	}

	public ExpressNoSegment(String id){
		super(id);
	}

	@Length(min=1, max=64, message="快递单号长度必须介于 1 和 64 之间")
	public String getExpressNo() {
		return expressNo;
	}

	public void setExpressNo(String expressNo) {
		this.expressNo = expressNo;
	}
	
	@Length(min=1, max=2, message="快递公司类型长度必须介于 1 和 2 之间")
	public String getExpressCompany() {
		return expressCompany;
	}

	public void setExpressCompany(String expressCompany) {
		this.expressCompany = expressCompany;
	}
	
	@Length(min=1, max=2, message="使用状态长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUseTime() {
		return useTime;
	}

	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
	
}