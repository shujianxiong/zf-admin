/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;

/**
 * 图片属性表Entity
 * @author 刘晓东
 * @version 2016-05-03
 */
public class FileProp extends DataEntity<FileProp> {
	
	private static final long serialVersionUID = 1L;
	private FileLibrary fileLibrary;		// 图片ID
	private Property property;		// 属性ID
	private Propvalue propvalue;		// 属性值ID
	private String pvalue;		// 属性值
	
	public FileProp() {
		super();
	}

	public FileProp(String id){
		super(id);
	}

	public FileLibrary getFileLibrary() {
		return fileLibrary;
	}

	public void setFileLibrary(FileLibrary fileLibrary) {
		this.fileLibrary = fileLibrary;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public Propvalue getPropvalue() {
		return propvalue;
	}

	public void setPropvalue(Propvalue propvalue) {
		this.propvalue = propvalue;
	}

	public String getPvalue() {
		return pvalue;
	}

	public void setPvalue(String pvalue) {
		this.pvalue = pvalue;
	}
	
}