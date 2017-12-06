/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ic;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.AcActivity;
import com.chinazhoufan.admin.modules.spm.entity.ic.InviteCode;

/**
 * 会员邀请码表DAO接口
 * @author 刘晓东
 * @version 2016-05-19
 */
@MyBatisDao
public interface InviteCodeDao extends CrudDao<InviteCode> {
	
	/**
	 * 删除该活动下面未使用的邀请码
	 * @param acActivity
	 */
	public void removeInviteCodeByActivity(@Param("acActivity")AcActivity acActivity);

	public InviteCode getByInviteCode(String inviteCode);
	
	/**
	 * 根据创建人ID和活动ID，查询该创建人为该活动已创建的邀请码数量
	 * @param createrId		创建人ID
	 * @param activityId	活动ID
	 * @return
	 */
	public Integer getCountByCreaterAndActivity(@Param("createrId")String createrId, @Param("activityId")String activityId);

	public List<InviteCode> findMemberInviteCodeList(InviteCode inviteCode);

	/**
	 * 根据活动ID和会员ID查询邀请码记录
	 * @param activityId
	 * @param memberId
	 * @return
	 */
	public InviteCode getByActivityAndMember(@Param("activityId")String activityId, @Param("memberId")String memberId);
	
}