/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.dao.hc;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.ser.entity.hc.Question;

/**
 * 帮助中心问题DAO接口
 * @author 张金俊
 * @version 2017-07-31
 */
@MyBatisDao
public interface QuestionDao extends CrudDao<Question> {
	
}