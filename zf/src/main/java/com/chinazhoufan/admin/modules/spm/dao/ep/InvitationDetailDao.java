/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ep;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ep.InvitationDetail;

import java.util.List;
import java.util.Map;

/**
 * 邀请人记录DAO接口
 * @author 舒剑雄
 * @version 2017-09-04
 */
@MyBatisDao
public interface InvitationDetailDao extends CrudDao<InvitationDetail> {

    int countByMember(Map<String, Object> map);

    List<String> getInviteMemberIds(String memberId);
}