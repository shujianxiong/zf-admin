/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.dao.ar;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.AutoReply;

/**
 * 自动回复表DAO接口
 * @author liut
 * @version 2016-05-25
 */
@MyBatisDao
public interface AutoReplyDao extends CrudDao<AutoReply> {
	
	/**
	 * 根据规则代码查询自动回复规则
	 * @param code
	 * @return
	 */
	public AutoReply getActivityByCode(AutoReply autoReply);
	
	/**
	 * 根据关键字查询自动回复规则
	 * @param keyword
	 * @return
	 */
	public List<AutoReply> getActivityByKeywords(AutoReply autoReply);
	
	public void remove(AutoReply autoReply);
}