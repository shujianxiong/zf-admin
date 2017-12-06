/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.dao.su;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.wcp.entity.su.SubscribeRecord;

/**
 * 公众号订阅记录DAO接口
 * @author 张金俊
 * @version 2016-05-24
 */
@MyBatisDao
public interface SubscribeRecordDao extends CrudDao<SubscribeRecord> {
	
	/**
	 * 查找用户订阅某公众号的最后一条订阅记录
	 * @param publicid	公众号id
	 * @param openid	用户openid
	 * @return
	 */
	public SubscribeRecord getLastRecord(@Param("publicid")String publicid, @Param("openid")String openid);
	
}