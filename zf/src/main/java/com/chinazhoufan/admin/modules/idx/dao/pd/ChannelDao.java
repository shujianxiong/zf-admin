/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.pd;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.pd.Channel;

/**
 * 频道DAO接口
 * @author 张金俊
 * @version 2016-08-12
 */
@MyBatisDao
public interface ChannelDao extends CrudDao<Channel> {

	Channel getDetail(@Param("id")String id);
	
}