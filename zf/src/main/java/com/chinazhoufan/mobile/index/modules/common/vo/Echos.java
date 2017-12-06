package com.chinazhoufan.mobile.index.modules.common.vo;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.Page;

/**
 * 信息返回封装
 * @author 杨晓辉
 * @version 2015-12-29
 */
@SuppressWarnings("serial")
public class Echos implements java.io.Serializable {

	private int status;		// 
	private String message;	// 除了存放消息，令牌之类，还可存放结果集类型（比如G=商品，P=产品，T=货品）
	private Object data;
	private Page page;		// page对象
	private List list;
	
	public Echos() {
		super();
	}
	
	public Echos(int status) {
		super();
		this.status = status;
	}
	
	public Echos(int status, Page page) {
		this.status = status;
		this.page = page;
	}

	public Echos(int status, String message) {
		super();
		this.status = status;
		this.message = message;
	}
	
	public Echos(int status, Object data) {
		super();
		this.status = status;
		this.data = data;
	}
	
	public Echos(int status, List list) {
		super();
		this.status = status;
		this.list = list;
	}

	public Echos(int status, String message, Object data) {
		super();
		this.status = status;
		this.message = message;
		this.data = data;
	}
	
	public Echos(int status, String message, List list) {
		super();
		this.status = status;
		this.message = message;
		this.list = list;
	}

	public Echos(int status, Object data, Page page) {
		super();
		this.status = status;
		this.data = data;
		this.page = page;
	}
	

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public Page getPage() {
		return page;
	}
	
	public void setPage(Page page) {
		this.page = page;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	
//	@Override
//	public String toString() {
//		return "Echos [data=" + data + ", message=" + message + ", status="
//				+ status + "]";
//	}
	
	

}
