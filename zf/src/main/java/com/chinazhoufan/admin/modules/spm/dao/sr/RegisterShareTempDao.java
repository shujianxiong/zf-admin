/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.sr;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.sr.RegisterShareTemp;

/**
 * 注册分享模板DAO接口
 * @author 刘晓东
 * @version 2015-11-06
 */
@MyBatisDao
public interface RegisterShareTempDao extends CrudDao<RegisterShareTemp> {
	
	public int count() ;
	
	public void updateDisabled() ;
}