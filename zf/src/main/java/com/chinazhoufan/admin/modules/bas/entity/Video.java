package com.chinazhoufan.admin.modules.bas.entity;

import com.chinazhoufan.admin.common.persistence.DataEntity;

public class Video extends DataEntity<Video> {

	private static final long serialVersionUID = 1L;
	
	private String code;
	private String type;
	private String fileUrl;
	private String tag;
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	
	
}
