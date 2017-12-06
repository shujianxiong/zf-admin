/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.service.um;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.modules.msg.dao.um.UmMessageDao;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 员工消息中心Service
 * @author 刘晓东
 * @version 2015-12-11
 */
@Service
@Transactional(readOnly = true)
public class UmMessageService extends CrudService<UmMessageDao, UmMessage> {

	public UmMessage get(String id) {
		return super.get(id);
	}
	
	public List<UmMessage> findList(UmMessage umMessage) {
		return super.findList(umMessage);
	}
	
	public Page<UmMessage> findAllMyPage(Page<UmMessage> page, UmMessage umMessage) {
		umMessage.setPage(page);
		umMessage.setSendUser(UserUtils.getUser());
		umMessage.setReceiveUser(UserUtils.getUser());
		umMessage.setDelFlagReceive(UmMessage.DEL_FLAG_RECEIVE_DEL);
		page.setList(dao.findAllMyList(umMessage));
		return page;
	}
	
	public Page<UmMessage> findPage(Page<UmMessage> page, UmMessage umMessage) {
		return super.findPage(page, umMessage);
	}
	
	public Page<UmMessage> findMyPage(Page<UmMessage> page, UmMessage umMessage) {
		umMessage.setDelFlagReceive(UmMessage.DEL_FLAG_RECEIVE_DEL);
		umMessage.setReceiveUser(UserUtils.getUser());
		return super.findPage(page, umMessage);
	}
	
	public Page<UmMessage> findSendPage(Page<UmMessage> page, UmMessage umMessage) {
		umMessage.setDelFlagReceive(UmMessage.DEL_FLAG_RECEIVE_NORMAL);
		umMessage.setSendUser(UserUtils.getUser());
		return super.findPage(page, umMessage);
	}
	
	public Page<UmMessage> findMyPageByNotViewed(Page<UmMessage> page, UmMessage umMessage) {
		umMessage.setStatus(UmMessage.STATUS_NOT_VIEWED);
		umMessage.setDelFlagReceive(UmMessage.DEL_FLAG_RECEIVE_DEL);
		umMessage.setReceiveUser(UserUtils.getUser());
		return super.findPage(page, umMessage);
	}
	
	
	@Transactional(readOnly = false)
	public void save(UmMessage umMessage) {
		umMessage.setStatus(UmMessage.STATUS_NOT_VIEWED); //未查看
		umMessage.setPushTime(new Date()); //推送时间
		umMessage.setDelFlagReceive(UmMessage.DEL_FLAG_RECEIVE_NORMAL);
		super.save(umMessage);
	}
	
	@Transactional(readOnly = false)
	public void delete(UmMessage umMessage) {
		super.delete(umMessage);
	}
	
	@Transactional(readOnly = false)
	public void deleteUmMessageByReceive(UmMessage umMessage) {
		umMessage.setDelFlagReceive(UmMessage.DEL_FLAG_RECEIVE_DEL);
		dao.deleteUmMessageByReceive(umMessage);
	}
	

	@Transactional(readOnly = false)
	public void view(UmMessage umMessage) {
		umMessage.setStatus(UmMessage.STATUS_VIEWED);
		umMessage.setViewTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss")));
		umMessage.preUpdate();
		dao.update(umMessage);
	}
	
	/**
	 * 移动管理端我的消息记录列表接口
	 * @param page
	 * @param sysUserId
	 * @param category
	 * @param type
	 * @param status
	 * @return
	 */
	public Page<UmMessage> findMyPageByUser(Page<UmMessage> page, String sysUserId,
			String category, String type, String status) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("page", page);
		map.put("sysUserId", sysUserId);
		map.put("category", category);
		map.put("type", type);
		map.put("status", status);
		page.setList(dao.findMyPageByUser(map));
		return page;
	}
	
	/**
	 * 统计未读消息条数
	 * @return
	 */
	public int countNotReadMessage(String sysUserId){
		return dao.countNotReadMessage(sysUserId);
	}
	
	
}