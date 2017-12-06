/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.ns;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.ns.MemberNotify;

/**
 * 会员消息DAO接口
 * @author 张金俊
 * @version 2017-07-18
 */
@MyBatisDao
public interface MemberNotifyDao extends CrudDao<MemberNotify> {
	
	/**
	 * 获取指定会员最后一条公告类会员消息
	 * @param memberNotify(memberNotify.member.id、memberNotify.notifyType)
	 * @return
	 */
	public MemberNotify getLastAnnounce(MemberNotify memberNotify);
	
	/**
	 * 根据条件，更新会员消息的查看标记
	 * @param memberNotify
	 */
	public void updateToReaded(MemberNotify memberNotify);
	
}