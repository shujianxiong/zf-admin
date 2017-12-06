/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.FileProp;

/**
 * 图片属性表DAO接口
 * @author 刘晓东
 * @version 2016-05-03
 */
@MyBatisDao
public interface FilePropDao extends CrudDao<FileProp> {
	
	public void removeByFileLibraryId(String id);
	
	public void deleteByFileLibraryId(String id);
	
	public List<FileProp> findListByLibraryId(String id);
}