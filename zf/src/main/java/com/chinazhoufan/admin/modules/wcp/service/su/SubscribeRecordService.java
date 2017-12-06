/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.su;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.wcp.dao.su.SubscribeRecordDao;
import com.chinazhoufan.admin.modules.wcp.entity.su.SubscribeRecord;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;

/**
 * 公众号订阅记录Service
 * @author 张金俊
 * @version 2016-05-24
 */
@Service
@Transactional(readOnly = true)
public class SubscribeRecordService extends CrudService<SubscribeRecordDao, SubscribeRecord> {
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	public SubscribeRecord get(String id) {
		return super.get(id);
	}
	
	/**
	 * 查找用户订阅某公众号的最后一条订阅记录
	 * @param publicid	公众号id
	 * @param openid	用户openid
	 * @return
	 */
	public SubscribeRecord getLastRecord(String publicid, String openid) {
		return dao.getLastRecord(publicid, openid);
	}
	
	public List<SubscribeRecord> findList(SubscribeRecord subscribeRecord) {
		return super.findList(subscribeRecord);
	}
	
	public Page<SubscribeRecord> findPage(Page<SubscribeRecord> page, SubscribeRecord subscribeRecord) {
		return super.findPage(page, subscribeRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(SubscribeRecord subscribeRecord) {
		super.save(subscribeRecord);
	}
	
	/**
	 * 根据公众号和用户信息，记录用户的公众号订阅记录
	 * @param publicid		公众号id
	 * @param wechatOpenid	用户openid
	 */
	@Transactional(readOnly = false)
	public void saveByOpenid(String publicid, String wechatOpenid) {
		SubscribeRecord subscribeRecord = new SubscribeRecord();
		subscribeRecord.setPublicid(publicid);
		subscribeRecord.setOpenid(wechatOpenid);
		subscribeRecord.setSubscribeTime(new Date());
		super.save(subscribeRecord);
	}
	
	/**
	 * 用户退订公众号，更新公众号订阅记录
	 * @param publicid		公众号id
	 * @param wechatOpenid	用户openid
	 */
	@Transactional(readOnly = false)
	public void cancelByOpenid(String publicid, String openid) {
		SubscribeRecord subscribeRecord = this.getLastRecord(publicid, openid);
		if(subscribeRecord==null){
			logger.error("[error code "+Constants.SUBSCRIBE_CANCEL_ERROR+"]", "未获取到用户的订阅记录,无法更新用户的关注状态");
			return;
		}
		if(subscribeRecord.getCancelTime() == null){
			subscribeRecord.setCancelTime(new Date());
			subscribeRecord.preUpdate();
			super.save(subscribeRecord);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(SubscribeRecord subscribeRecord) {
		super.delete(subscribeRecord);
	}
	
}