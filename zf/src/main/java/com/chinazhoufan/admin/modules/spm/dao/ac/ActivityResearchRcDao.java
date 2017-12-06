/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ac;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ac.ActivityResearchRc;

/**
 * 调研活动参与记录DAO接口
 * @author 刘晓东
 * @version 2016-05-27
 */
@MyBatisDao
public interface ActivityResearchRcDao extends CrudDao<ActivityResearchRc> {
	
	/**
	 * 根据调研活动ID，查询该调研活动的参与记录数量
	 * @param arId		调研活动ID
	 * @param status	参与记录状态
	 * @return
	 */
	public Integer getCountByArIdAndStatus(@Param("arId")String arId, @Param("status")String status);
	
	/**
	 * 根据会员和调研活动，查询调研活动参与记录
	 * @param memberId	会员ID
	 * @param arId		调研活动ID
	 * @return
	 */
	public List<ActivityResearchRc> findByMemberAndAr(@Param("memberId")String memberId, @Param("arId")String arId);
	
}