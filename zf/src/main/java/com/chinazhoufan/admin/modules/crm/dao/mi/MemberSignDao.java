/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mi;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.MemberSign;

/**
 * 会员签到DAO接口
 * @author liut
 * @version 2016-11-25
 */
@MyBatisDao
public interface MemberSignDao extends CrudDao<MemberSign> {
	
}