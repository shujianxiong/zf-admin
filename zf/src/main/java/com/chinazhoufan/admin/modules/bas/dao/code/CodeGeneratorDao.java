/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.dao.code;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.code.CodeGenerator;

/**
 * 业务编码生成器DAO接口
 * @author 贾斌
 * @version 2015-11-23
 */
@MyBatisDao
public interface CodeGeneratorDao extends CrudDao<CodeGenerator> {
	public List<CodeGenerator> findCodeHandleList(CodeGenerator codeGenerator);
	/**
	 * 通过codeHandle查询业务编码生成器，同时锁定业务编码生成器表
	 * @param codeHandle
	 * @return
	 */
	public List<CodeGenerator> findForUpdate(String codeHandle);
	
}