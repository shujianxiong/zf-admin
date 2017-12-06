/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ep;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ep.Invitation;
import org.apache.ibatis.annotations.Param;

/**
 * 邀请人DAO接口
 * @author 舒剑雄
 * @version 2017-08-31
 */
@MyBatisDao
public interface InvitationDao extends CrudDao<Invitation> {

    Invitation getByMember(@Param("memberId")String memberId);
	
}