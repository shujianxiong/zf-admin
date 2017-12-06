/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.TreeDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.FileDir;

/**
 * 文件目录
 * @Date 2016年10月26日 下午2:57:59
 */
@MyBatisDao
public interface FileDirDao extends TreeDao<FileDir> {

	/**
	 * 变更文件目录类型
	 * @param fileDir    设定文件
	 * @throws
	 */
	public void updateType(FileDir fileDir);
	
	/**
	 * 检测录入的文件编码是否全局唯一
	 * @param code
	 * @throws
	 */
	public Integer getUniqueByCode(String code);
	
	
	public FileDir findFileDirByCode(@Param("code")String code);
}
