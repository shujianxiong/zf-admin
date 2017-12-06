/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.dao.um;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;

/**
 * 员工消息中心DAO接口
 * @author 刘晓东
 * @version 2015-12-11
 */
@MyBatisDao
public interface UmMessageDao extends CrudDao<UmMessage> {

	public void view(UmMessage umMessage);
	
	public List<UmMessage> findMyPageByUser(Map<String, Object> map);

	public int countNotReadMessage(String receiveUserId);
	
	/**
	 * 查询所有我的消息（包括收件和发件）
	 * @param umMessage
	 * @return    设定文件
	 * @throws
	 */
	public List<UmMessage> findAllMyList(UmMessage umMessage);
	
	/**
	 * 收件人删除消息，但是发件人那边依然可以看到
	 * @param umMessage
	 * @throws
	 */
	public void deleteUmMessageByReceive(UmMessage umMessage);
}