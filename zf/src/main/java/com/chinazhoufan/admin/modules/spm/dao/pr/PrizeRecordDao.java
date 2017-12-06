/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.pr;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.pr.PrizeRecord;

/**
 * 奖品领取记录表DAO接口
 * @author liut
 * @version 2016-05-19
 */
@MyBatisDao
public interface PrizeRecordDao extends CrudDao<PrizeRecord> {

	List<PrizeRecord> getByPrizeAndMember(@Param("prizeId")String prizeId, @Param("memberId")String memberId);
	
}