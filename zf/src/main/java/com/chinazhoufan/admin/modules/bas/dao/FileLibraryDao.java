/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.FileLibrary;

/**
 * 图片库DAO接口
 * @author 刘晓东
 * @version 2016-05-03
 */
@MyBatisDao
public interface FileLibraryDao extends CrudDao<FileLibrary> {
	
	/**
	 * 根据图片ID查询图片信息、图片属性信息
	 * @param id 图片ID
	 * @return
	 */
	public FileLibrary findFileAndPropertyById(String id);
	
	public FileLibrary find(String id);
	
	public List<FileLibrary> findByFileUrl(@Param("fileUrl") String fileUrl);
	
}