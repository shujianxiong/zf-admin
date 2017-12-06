package com.chinazhoufan.admin.common.persistence;

import java.io.Serializable;
import java.util.Date;

/**
 * 查询参数对象
 * @author 杨晓辉
 *
 */

public class SearchParameter implements Serializable{
	
	private String keyWord;//查询关键字
	private Date starTime;//开始时间
	private Date endTime;//结束时间
	private String status;//状态查询
	
	
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	public Date getStarTime() {
		return starTime;
	}
	public void setStarTime(Date starTime) {
		this.starTime = starTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
